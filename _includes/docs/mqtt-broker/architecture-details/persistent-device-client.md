
* TOC
{:toc}

在 TBMQ 1.x 中，持久 DEVICE 客户端依赖 PostgreSQL 进行消息持久化和检索，
确保客户端重连时能投递消息。
PostgreSQL 初期表现良好，但存在根本性限制——只能垂直扩展。
我们预计，随着持久 MQTT 会话数量的增长，PostgreSQL 的架构最终将成为瓶颈。
为解决此问题，我们探索了更易扩展的替代方案，以应对 MQTT broker 日益增长的需求。
鉴于 Redis 的水平扩展能力、原生集群支持及广泛采用，我们很快选择其作为最佳方案。

## PostgreSQL 使用与限制

要充分理解这一迁移的原因，首先需要了解 MQTT 客户端在 PostgreSQL 架构中的工作方式。该架构围绕两个关键表构建。

`device_session_ctx` 表负责维护每个持久 MQTT 客户端的会话状态：

```postgresql
                      Table "public.device_session_ctx"
       Column       |          Type          | Collation | Nullable | Default 
--------------------+------------------------+-----------+----------+---------
 client_id          | character varying(255) |           | not null | 
 last_updated_time  | bigint                 |           | not null | 
 last_serial_number | bigint                 |           |          | 
 last_packet_id     | integer                |           |          | 
Indexes:
    "device_session_ctx_pkey" PRIMARY KEY, btree (client_id)
```

关键列为 `last_packet_id` 和 `last_serial_number`，用于维护持久 MQTT 客户端的消息顺序：

- `last_packet_id` 表示收到的最后一条 MQTT 消息的 packet ID。
- `last_serial_number` 作为持续递增的计数器，防止 MQTT packet ID 在达到 65535 限制后回绕时出现消息顺序问题。

`device_publish_msg` 表负责存储必须发布给持久 MQTT 客户端（订阅者）的消息：

```postgresql
                         Table "public.device_publish_msg"
          Column          |          Type          | Collation | Nullable | Default 
--------------------------+------------------------+-----------+----------+---------
 client_id                | character varying(255) |           | not null | 
 serial_number            | bigint                 |           | not null | 
 topic                    | character varying      |           | not null | 
 time                     | bigint                 |           | not null | 
 packet_id                | integer                |           |          | 
 packet_type              | character varying(255) |           |          | 
 qos                      | integer                |           | not null | 
 payload                  | bytea                  |           | not null | 
 user_properties          | character varying      |           |          | 
 retain                   | boolean                |           |          | 
 msg_expiry_interval      | integer                |           |          | 
 payload_format_indicator | integer                |           |          | 
 content_type             | character varying(255) |           |          | 
 response_topic           | character varying(255) |           |          | 
 correlation_data         | bytea                  |           |          | 
Indexes:
    "device_publish_msg_pkey" PRIMARY KEY, btree (client_id, serial_number)
    "idx_device_publish_msg_packet_id" btree (client_id, packet_id)
```

需要强调的关键列：

- `time` – 记录消息存储时的系统时间（时间戳）。该字段用于定期清理过期消息。
- `msg_expiry_interval` – 表示消息的过期时间（秒）。
  仅对包含过期属性的传入 MQTT 5.0 消息设置。
  若缺少过期属性，消息没有特定过期时间，在基于时间或大小的清理移除前一直有效。

这两个表共同管理消息持久化和会话状态。
`device_session_ctx` 表设计用于快速检索为每个持久 MQTT 客户端存储的最后 MQTT packet ID 和 serial number。
当从共享 Kafka topic 收到客户端消息时，broker 会查询该表以获取最新值。
这些值依次递增并分配给每条消息，然后保存到 `device_publish_msg` 表。

虽然该设计确保了可靠的消息投递，但也引入了性能限制。
根据 TimescaleDB 博客 [文章](https://www.timescale.com/blog/postgresql-timescaledb-1000x-faster-queries-90-data-compression-and-much-more#ingest-performance)，
在理想条件下，vanilla PostgreSQL 每秒最多可处理约 30 万次插入。
然而，该性能取决于硬件、工作负载和表结构等因素。
虽然垂直扩展可带来一定提升，但 PostgreSQL 的每表插入吞吐量最终会达到硬性上限。

## Redis 作为可扩展替代方案

我们选择迁移到 Redis 的动机，是其能够解决 PostgreSQL 遇到的核心性能瓶颈。
PostgreSQL 依赖基于磁盘的存储和垂直扩展，而 Redis 主要在内存中运行，显著降低读写延迟。
此外，Redis 的分布式架构使 TBMQ 能够水平扩展，即便客户端会话和存储消息数量增长，也能保持持久消息的检索和投递高效。

鉴于上述优势，我们开始迁移并评估可与 Redis Cluster 约束对齐、同时保留 PostgreSQL 方案功能的数据结构，以实现高效水平扩展。
这也为我们提供机会，通过利用 Redis 的内置过期机制等特性，改进原设计的某些方面（如定期清理）。

### Redis Cluster 约束

从 PostgreSQL 迁移到 Redis 时，我们意识到复制现有数据模型需要多种 Redis 数据结构才能高效处理消息持久化和排序。
这意味着每个持久 MQTT 客户端会话需要使用多个 key。

{% include images-gallery.html imageCollection="redis-cluster-constraints" %}

Redis Cluster 将数据分布在多个 slot 以实现水平扩展。
但多 key 操作必须访问同一 slot 内的 key。
若 key 位于不同 slot，操作将触发跨 slot 错误，导致命令无法执行。
我们在 key 名称中使用持久 MQTT 客户端 ID 作为 [hash tag](https://redis.io/docs/latest/operate/oss_and_stack/reference/cluster-spec/#hash-tags) 来解决此问题。
通过将 client ID 用花括号 `{}` 包裹，Redis 确保同一客户端的所有 key 被哈希到同一 slot。
这保证每个客户端的相关数据集中在一起，使多 key 操作能够无错误执行。

### 通过 Lua 脚本实现原子操作

在 TBMQ 这样的高吞吐量环境中，一致性至关重要，同一 MQTT 客户端可能同时收到多条消息。
Hash tag 有助于避免跨 slot 错误，但若无原子操作，仍存在竞态条件或部分更新的风险。
这可能导致消息丢失或顺序错误。确保更新同一 MQTT 客户端 key 的操作为原子操作非常重要。

Redis 设计为原子执行单条命令。
但在我们场景中，需要在单次操作中为每个 MQTT 客户端更新多个数据结构。
若按顺序执行且不具备原子性，若另一进程在命令之间修改同一数据，则会引入不一致。
这时 [Lua 脚本](https://redis.io/docs/latest/develop/interact/programmability/eval-intro/) 派上用场。Lua 脚本作为单一、隔离单元执行。
脚本执行期间，不允许其他命令并发运行，确保脚本内操作原子执行。

基于此，我们决定：对任何操作（如保存消息或重连时检索未投递消息），均执行独立的 Lua 脚本。
这确保单个 Lua 脚本内的所有操作位于同一 hash slot，保持原子性和一致性。

### Redis 数据结构

迁移的关键要求之一是保持消息顺序，此前由 PostgreSQL 的 `device_publish_msg` 表中的 `serial_number` 列处理。
在评估多种 Redis 数据结构后，我们确定 [sorted sets](https://redis.io/docs/latest/develop/data-types/sorted-sets/)（ZSET）是最佳替代方案。

Redis sorted set 按 score 自然组织数据，支持快速按升序或降序检索消息。
虽然 sorted set 提供了维护消息顺序的高效方式，但将完整消息 payload 直接存入 sorted set 会导致内存占用过高。
Redis 不支持 sorted set 内单成员的 TTL。因此，除非显式移除，消息会无限持久。
与 PostgreSQL 类似，我们须使用 `ZREMRANGEBYSCORE` 执行定期清理以删除过期消息。
该操作复杂度为 `O(log N + M)`，其中 `M` 为移除的元素数。
为克服此限制，我们决定将消息 payload 存储为 string 数据结构，而在 sorted set 中存储对这些 key 的引用。

{% include images-gallery.html imageCollection="redis-data-structures" %}

上图可见，每个 key 遵循 `{client_id}_messages` 模式，
其中 `client_id` 为实际 client ID 的占位符，
其周围的花括号 `{}` 用于创建 hashtag。
还可注意到，即使 MQTT packet ID 回绕，score 仍持续增长。

让我们更详细地查看图中内容。
首先，将 MQTT packet ID 等于 `65534` 的消息引用加入 sorted set：

```bash
ZADD {client_id}_messages 65534 {client_id}_messages_65534
```
{: .copy-code}

此处，`{client_id}_messages` 为 sorted set 的 key 名，`{client_id}` 作为从持久 MQTT 客户端唯一 ID 派生的 hashtag。
后缀 `_messages` 是为一致性添加的常量。
在 sorted set key 名之后，score 值 `65534` 对应客户端收到的消息的 MQTT packet ID。
最后是引用 key，指向 MQTT 消息的实际 payload。
与 sorted set key 类似，消息引用 key 使用 MQTT 客户端 ID 作为 hashtag，后跟 `_messages` 后缀和 MQTT packet ID 值。

下一次迭代中，将 packet ID 等于 `65535` 的 MQTT 消息的引用加入 sorted set。这是最大 packet ID，范围为 65535。

```bash
ZADD {client_id}_messages 65535 {client_id}_messages_65535
```
{: .copy-code}

因此在下一迭代中，MQTT packet ID 应为 `1`，而 score 应继续增长至 `65536`。

```bash
ZADD {client_id}_messages 65536 {client_id}_messages_1
```
{: .copy-code}

该方法确保消息引用在 sorted set 中正确排序，不受 packet ID 范围限制影响。

消息 payload 使用支持过期 `(EX)` 的 `SET` 命令存储为 string 值，提供 `O(1)` 复杂度的写入和 TTL 应用：

```bash
SET {client_id}_messages_1 "{
  \"packetType\":\"PUBLISH\",
  \"payload\":\"eyJkYXRhIjoidGJtcWlzYXdlc29tZSJ9\",
  \"time\":1736333110026,
  \"clientId\":\"client\",
  \"retained\":false,
  \"packetId\":1,
  \"topicName\":\"europe/ua/kyiv/client/0\",
  \"qos\":1
}" EX 600
```
{: .copy-code}

除高效更新和 TTL 应用外，另一好处是消息 payload 可被检索：

```bash
GET {client_id}_messages_1
```
{: .copy-code}

或删除：

```bash
DEL {client_id}_messages_1
```
{: .copy-code}

均为常数复杂度 `O(1)`，不影响 sorted set 结构。

我们 Redis 架构的另一重要元素是使用 string key 存储已处理的最后 MQTT packet ID：

```bash
GET {client_id}_last_packet_id
"1"
```
{: .copy-code}

该方法与 PostgreSQL 方案中的用途相同。
客户端重连时，服务器必须确定正确的 packet ID，分配给将保存到 Redis 的下一条消息。
最初我们考虑使用 sorted set 的最高 score 作为参考。
但由于 sorted set 可能为空或完全被移除的场景，
我们得出结论：最可靠的做法是单独存储最后 packet ID。

### 动态管理 Sorted Set 大小

这种结合 sorted set 和 string 的混合方法，消除了基于时间的定期清理需求，因为现已对每条消息应用 TTL。
此外，沿用 PostgreSQL 设计，我们需要以某种方式处理基于配置中设置的消息限制的 sorted set 清理。

```yaml
# Maximum number of PUBLISH messages stored for each persisted DEVICE client
limit: "${MQTT_PERSISTENT_SESSION_DEVICE_PERSISTED_MESSAGES_LIMIT:10000}"
```
{: .copy-code}

此限制是我们设计的重要部分，使我们能控制和预测每个持久 MQTT 客户端所需的内存分配。
例如，客户端可能连接后触发持久会话注册，随后迅速断开。
在此类场景中，必须确保为该客户端存储的消息数（在等待可能的重连期间）保持在定义的限制内，防止无限内存使用。

```java
if (messagesLimit > 0xffff) {
    throw new IllegalArgumentException("Persisted messages limit can't be greater than 65535!");
}
```
{: .copy-code}

为反映 MQTT 协议的自然约束，单个客户端的最大持久消息数设为 `65535`。

为在 Redis 方案中实现此逻辑，我们实现了 sorted set 大小的动态管理。
添加新消息时，对 sorted set 进行裁剪，确保消息总数保持在所需限制内，并清理关联的 string 以释放内存。

```lua
-- Get the number of elements to be removed
local numElementsToRemove = redis.call('ZCARD', messagesKey) - maxMessagesSize
-- Check if trimming is needed
if numElementsToRemove > 0 then
    -- Get the elements to be removed (oldest ones)
    local trimmedElements = redis.call('ZRANGE', messagesKey, 0, numElementsToRemove - 1)
    -- Iterate over the elements and remove them
    for _, key in ipairs(trimmedElements) do
        -- Remove the message from the string data structure
        redis.call('DEL', key)
        -- Remove the message reference from the sorted set
        redis.call('ZREM', messagesKey, key)
    end
end
```
{: .copy-code}

### 消息检索与清理

我们的设计不仅确保在持久化新消息时的动态大小管理，还支持在消息检索时的清理，
即设备重连以处理未投递消息时。
该方法通过移除过期消息的引用来保持 sorted set 的整洁。

```lua
-- Define the sorted set key
local messagesKey = KEYS[1]
-- Define the maximum allowed number of messages
local maxMessagesSize = tonumber(ARGV[1])
-- Get all elements from the sorted set
local elements = redis.call('ZRANGE', messagesKey, 0, -1)
-- Initialize a table to store retrieved messages
local messages = {}
-- Iterate over each element in the sorted set
for _, key in ipairs(elements) do
    -- Check if the message key still exists in Redis
    if redis.call('EXISTS', key) == 1 then
        -- Retrieve the message value from Redis
        local msgJson = redis.call('GET', key)
        -- Store the retrieved message in the result table
        table.insert(messages, msgJson)
    else
        -- Remove the reference from the sorted set if the key does not exist
        redis.call('ZREM', messagesKey, key)
    end
end
-- Return the retrieved messages
return messages
```
{: .copy-code}

通过利用 Redis 的 sorted set 和 string，以及 Lua 脚本实现原子操作，我们的新设计实现了高效的消息持久化、检索和动态清理。
该设计解决了基于 PostgreSQL 方案的可扩展性限制。

## 从 Jedis 迁移到 Lettuce

为验证基于 Redis 的新架构在持久消息存储方面的可扩展性，我们选择点对点（P2P）MQTT 通信模式作为性能测试场景。
与 fan-in（多对一）或 fan-out（一对多）场景不同，P2P 模式通常涉及一对一通信，并为每对通信创建新的持久会话。
这使其非常适合评估系统随会话数量增长的扩展能力。

在开始大规模测试之前，我们进行了原型测试，发现使用 PostgreSQL 做持久消息存储时吞吐量上限为 30k msg/s。
迁移到 Redis 时，我们使用 Jedis 库进行 Redis 交互，主要用于缓存管理。
因此，我们最初决定扩展 Jedis 以处理持久 MQTT 客户端的消息持久化。
然而，使用 Jedis 的 Redis 实现的初步结果出乎意料。
尽管我们预计 Redis 会显著优于 PostgreSQL，但性能提升有限，仅达到 40k msg/s 吞吐量，而 PostgreSQL 的上限为 30k msg/s。

这促使我们排查瓶颈，发现 Jedis 是限制因素。
Jedis 虽然可靠，但以同步方式操作，按顺序处理每条 Redis 命令。
这迫使系统在执行下一条操作前等待当前操作完成。
在高吞吐量环境中，这种方式显著限制了 Redis 的潜力，无法充分利用系统资源。
为克服此限制，我们迁移到 [Lettuce](https://github.com/redis/lettuce)，一个基于 [Netty](https://github.com/netty/netty) 的异步 Redis 客户端。
使用 Lettuce 后，我们的吞吐量提升至 60k msg/s，展示了非阻塞操作和更高并行度的好处。

{% include images-gallery.html imageCollection="jedis-to-lettuce" %}

Lettuce 允许多条命令并行发送和处理，充分利用 Redis 的并发工作负载能力。
最终，该迁移释放了我们预期的 Redis 性能提升，为成功的规模化 P2P 测试铺平了道路。
有关测试架构、方法和结果的深入了解，请参阅我们详细的性能测试 [文章](/docs/{{docsPrefix}}mqtt-broker/reference/1m-throughput-p2p-performance-test)。
