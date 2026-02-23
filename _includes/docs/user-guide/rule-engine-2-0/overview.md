* TOC
{:toc}

<b>规则引擎</b>是 ThingsBoard 中负责接收、转换、路由和响应来自设备及相关资产的事件与遥测数据的核心数据处理机制。

规则引擎围绕三大组件构建：

- [消息](#rule-engine-message) — 任何入站事件。可以是设备入站数据、设备生命周期事件、REST API 事件、RPC 请求等。
- [规则节点](#rule-node) — 对入站消息执行的函数。有多种不同类型的节点，可对入站消息进行过滤、转换或执行特定操作。
- [规则链](#rule-chain) — 节点之间通过关系连接，规则节点的出站消息会发送到下游连接的规则节点。

## 主要特性

- <b>流式处理</b>。遥测、属性、RPC、事件等入站数据会被规则引擎立即处理，可进行过滤、丰富或转换。
- <b>规则链即工作流</b>。数据处理被组织成<b>规则链</b> — 由若干<b>规则节点</b>组成的工作流。每个节点执行特定操作，如过滤、写入数据库、发送通知或调用外部 API。
- <b>灵活性与可扩展性</b>。规则引擎支持内置节点及通过脚本（JavaScript 或 TBEL）实现的自定义逻辑，也可与外部系统（HTTP、Kafka、MQTT）集成。
- <b>集成与响应</b>。规则引擎可根据事件触发业务逻辑，例如在超过温度阈值时发送邮件或短信，或与外部服务/平台集成。

## 典型用途

以下是可通过<b>ThingsBoard 规则链</b>配置的常见场景：
- <b>数据校验与转换</b> — 在持久化到数据库前校验并修改入站遥测或属性。
- <b>遥测聚合</b> — 将遥测或属性从设备复制到关联资产以实现聚合。例如，可将多台设备的数据合并到关联资产中用于汇总分析。
- <b>告警管理</b> — 根据定义的条件创建、更新或清除告警。
- <b>设备生命周期监控</b> — 在设备状态变化时触发操作。例如，设备上线或离线时生成告警。
- <b>数据丰富</b> — 加载处理所需的额外上下文。例如，从设备所属客户或租户属性中加载设备的温度阈值。
- <b>外部系统集成</b> — 触发对外部应用和服务的 REST API 调用。
- <b>通知</b> — 在复杂事件发生时发送邮件告警，可在邮件模板中包含关联实体的属性。
- <b>用户个性化</b> — 在事件处理时考虑用户偏好。
- <b>远程控制</b> — 根据定义的条件对设备执行 RPC 调用。
- <b>大数据/云集成</b> — 连接 Kafka、Spark、AWS 等外部管道和平台。

## 规则引擎消息

规则引擎消息是一种可序列化、不可变的数据结构，用于表示系统中的各类消息。例如：

  * 来自设备的入站[遥测](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"}、[属性更新](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"}或[RPC 调用](/docs/{{docsPrefix}}user-guide/rpc/){:target="_blank"}；
  * 实体生命周期事件：创建、更新、删除、分配、取消分配、属性更新；
  * 设备状态事件：连接、断开、活跃、不活跃等；
  * 其他系统事件。
  
规则引擎消息包含以下信息：

  * 消息 ID：基于时间的全局唯一标识符；
  * 消息来源：设备、资产或其他[实体](/docs/{{docsPrefix}}user-guide/entities-and-relations/){:target="_blank"}标识符；
  * 消息类型：如「发布遥测」或「不活跃事件」等；
  * 消息负载：包含实际消息内容的 JSON 体；
  * 元数据：与消息相关的键值对列表。 

## 规则节点

规则节点是规则引擎的基本组件，一次处理一条入站消息并产生一条或多条出站消息。
规则节点是规则引擎的主要逻辑单元，可对入站消息进行过滤、丰富、转换，执行操作或与外部系统通信。

## 规则节点连接

规则节点可与其他规则节点连接。每条关系都有关系类型，用于标识关系的逻辑含义。
当规则节点产生出站消息时，会指定用于将消息路由到下游节点的关系类型。
 
常见关系类型为「Success」和「Failure」。
表示逻辑运算的规则节点可使用「True」或「False」。
部分规则节点使用完全不同的关系类型，例如：「Post Telemetry」、「Attributes Updated」、「Entity Created」等。

部分规则节点支持自定义连接名称。输入自定义连接名并点击「Create a new one!」链接即可：

![image](/images/user-guide/rule-engine-2-0/nodes/custom-connection.png)

所有连接名称**区分大小写**。

## 规则链

规则链是规则节点及其关系的逻辑组合。例如，以下规则链将：

  * 将所有遥测消息保存到数据库；
  * 当消息中温度字段高于 50 度时触发「高温告警」；
  * 当消息中温度字段低于 -40 度时触发「低温告警」；
  * 当脚本存在逻辑或语法错误时，将温度检查脚本执行失败记录到控制台。

![image](/images/user-guide/rule-engine-2-0/rule-node-relations.png)

租户管理员可定义一条**根规则链**，并可选择定义多条其他规则链。
根规则链处理所有入站消息，并可将其转发到其他规则链进行后续处理。
其他规则链也可将消息转发到不同规则链。

例如，以下规则链将：

  * 当消息中温度高于 50 度时触发「高温告警」；
  * 当消息中温度低于 50 度时清除「高温告警」；
  * 将告警「创建」和「清除」事件转发到负责通知相应用户的外部规则链。
 
![image](/images/user-guide/rule-engine-2-0/rule-chain-references.png)

## 消息处理结果

消息处理有三种可能结果：Success（成功）、Failure（失败）、Timeout（超时）。
当处理链中最后一个规则节点成功处理消息时，该次处理标记为「Success」。
若某规则节点产生「Failure」且没有其他规则节点处理该失败，则标记为「Failure」。
当总处理时间超过可配置阈值时，标记为「Timeout」。

下图展示了可能的场景：

![image](/images/user-guide/rule-engine-2-0/not-a-failure.png)

若「Transformation」脚本失败，消息不会标记为「Failed」，因为有通过「Failure」关系连接的「Save to DB」节点处理。
若「Transformation」脚本成功，将通过 REST API 推送到「External System」。
若外部系统过载，REST API 调用可能暂时阻塞。假设消息包处理总超时为 20 秒，忽略 Transformation 脚本执行时间（< 1ms）。
若「External System」在 20 秒内响应，消息将被成功处理。
同样，若「Save to DB」调用成功，消息也会被成功处理。
若外部系统在 20 秒内未响应，该次处理将标记为「timed-out」。
若「Save to DB」调用失败，消息将标记为失败。

### 规则引擎队列

参见新版[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/){:target="_blank"}

#### 队列提交策略

参见新版[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-submit-strategy){:target="_blank"}

#### 队列处理策略

参见新版[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-processing-strategy){:target="_blank"}

#### 默认队列

参见新版[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#default-queues){:target="_blank"}

## 预定义消息类型

预定义消息类型列表如下：

<table>
  <thead>
      <tr>
          <td><b>消息类型</b></td><td><b>显示名称</b></td><td><b>描述</b></td><td><b>消息元数据</b></td><td><b>消息负载</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>POST_ATTRIBUTES_REQUEST</td>
          <td><b>发布属性</b></td>
          <td>设备请求发布<a href="/docs/{{docsPrefix}}user-guide/attributes/#attribute-types">客户端</a>属性（参见 <a href="/docs/{{docsPrefix}}reference/mqtt-api/#publish-attribute-update-to-the-server">attributes api</a>）</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type</td>
          <td>key/value json: <br> <code style="font-size: 12px;">{ <br> &nbsp;&nbsp;"currentState": "IDLE" <br> }</code></td>
      </tr>
      <tr>
          <td>POST_TELEMETRY_REQUEST</td>
          <td><b>发布遥测</b></td>
          <td>设备请求发布遥测（参见 <a href="/docs/{{docsPrefix}}reference/mqtt-api/#telemetry-upload-api">telemetry upload api</a>）</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type,<br><b>ts</b> - timestamp (milliseconds)</td>
          <td>key/value json: <br> <code style="font-size: 12px;">{ <br> &nbsp;&nbsp;"temperature": 22.7 <br> }</code></td>
      </tr>
      <tr>
          <td>TO_SERVER_RPC_REQUEST</td>
          <td><b>来自设备的 RPC 请求</b></td>
          <td>设备发起的 RPC 请求（参见 <a href="/docs/{{docsPrefix}}reference/mqtt-api/#client-side-rpc">client side rpc</a>）</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type,<br><b>requestId</b> - RPC request Id provided by client</td>
          <td>json containing <b>method</b> and <b>params</b>: <br> <code style="font-size: 12px;">{ <br> &nbsp;&nbsp;"method": "getTime", <br>&nbsp;&nbsp;"params": { "param1": "val1" } <br> }</code></td>
      </tr>
      <tr>
          <td>RPC_CALL_FROM_SERVER_TO_DEVICE</td>
          <td><b>下发至设备的 RPC 请求</b></td>
          <td>服务端发往设备的 RPC 请求（参见 <a href="/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc-api">server side rpc api</a>）</td>
          <td><b>requestUUID</b> - 系统用于识别回复目标的内部请求 ID，<br><b>expirationTime</b> - 请求过期时间，<br><b>oneway</b> - 指定请求类型：<i>true</i> - 无响应，<i>false</i> - 有响应</td>
          <td>json containing <b>method</b> and <b>params</b>: <br> <code style="font-size: 12px;">{ <br> &nbsp;&nbsp;"method": "getGpioStatus", <br>&nbsp;&nbsp;"params": { "param1": "val1" } <br> }</code></td>
      </tr>
      <tr>
          <td>ACTIVITY_EVENT</td>
          <td><b>活跃事件</b></td>
          <td>设备变为活跃状态时产生的事件</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type</td>
          <td>json containing device activity information: <br> <code style="font-size: 12px;">{<br> &nbsp;&nbsp;"active": true,<br> &nbsp;&nbsp;"lastConnectTime": 1526979083267,<br> &nbsp;&nbsp;"lastActivityTime": 1526979083270,<br> &nbsp;&nbsp;"lastDisconnectTime": 1526978493963,<br> &nbsp;&nbsp;"lastInactivityAlarmTime": 1526978512339,<br> &nbsp;&nbsp;"inactivityTimeout": 10000<br>}</code></td>
      </tr>
      <tr>
          <td>INACTIVITY_EVENT</td>
          <td><b>不活跃事件</b></td>
          <td>设备变为不活跃状态时产生的事件</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type</td>
          <td>json containing device activity information, see <b>Activity Event</b> payload</td>
      </tr>
      <tr>
          <td>CONNECT_EVENT</td>
          <td><b>连接事件</b></td>
          <td>设备连接时产生的事件</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type</td>
          <td>json containing device activity information, see <b>Activity Event</b> payload</td>
      </tr>
      <tr>
          <td>DISCONNECT_EVENT</td>
          <td><b>断开事件</b></td>
          <td>设备断开时产生的事件</td>
          <td><b>deviceName</b> - originator device name,<br><b>deviceType</b> - originator device type</td>
          <td>json containing device activity information, see <b>Activity Event</b> payload</td>
      </tr>
      <tr>
          <td>ENTITY_CREATED</td>
          <td><b>实体已创建</b></td>
          <td>系统中创建新实体时产生的事件</td>
          <td><b>userName</b> - name of the user who created the entity,<br><b>userId</b> - the user Id</td>
          <td>json containing created entity details: <br> <code style="font-size: 12px;">{<br> &nbsp;&nbsp;"id": {<br> &nbsp;&nbsp;&nbsp;&nbsp;"entityType": "DEVICE",<br> &nbsp;&nbsp;&nbsp;&nbsp;"id": "efc4b9e0-5d0f-11e8-8559-37a7f8cdca74"<br> &nbsp;&nbsp;},<br> &nbsp;&nbsp;"createdTime": 1526918366334,<br> &nbsp;&nbsp;...<br> &nbsp;&nbsp;"name": "my-device",<br> &nbsp;&nbsp;"type": "temp-sensor"<br>}</code></td>
      </tr>
      <tr>
          <td>ENTITY_UPDATED</td>
          <td><b>实体已更新</b></td>
          <td>现有实体被更新时产生的事件</td>
          <td><b>userName</b> - name of the user who updated the entity,<br><b>userId</b> - the user Id</td>
          <td>json containing updated entity details, see <b>Entity Created</b> payload</td>
      </tr>
      <tr>
          <td>ENTITY_DELETED</td>
          <td><b>实体已删除</b></td>
          <td>现有实体被删除时产生的事件</td>
          <td><b>userName</b> - name of the user who deleted the entity,<br><b>userId</b> - the user Id</td>
          <td>json containing deleted entity details, see <b>Entity Created</b> payload</td>
      </tr>
      <tr>
          <td>ENTITY_ASSIGNED</td>
          <td><b>实体已分配</b></td>
          <td>现有实体被分配给客户时产生的事件</td>
          <td><b>userName</b> - name of the user who performed assignment operation,<br><b>userId</b> - the user Id,<br><b>assignedCustomerName</b> - assigned customer name,<br><b>assignedCustomerId</b> - Id of assigned customer</td>
          <td>json containing assigned entity details, see <b>Entity Created</b> payload</td>
      </tr>
      <tr>
          <td>ENTITY_UNASSIGNED</td>
          <td><b>实体已取消分配</b></td>
          <td>现有实体从客户处取消分配时产生的事件</td>
          <td><b>userName</b> - name of the user who performed unassignment operation,<br><b>userId</b> - the user Id,<br><b>unassignedCustomerName</b> - unassigned customer name,<br><b>unassignedCustomerId</b> - Id of unassigned customer</td>
          <td>json containing unassigned entity details, see <b>Entity Created</b> payload</td>
      </tr>
      <tr>
          <td>ADDED_TO_ENTITY_GROUP</td>
          <td><b>已加入组</b></td>
          <td>实体被加入<a href="/docs/{{docsPrefix}}user-guide/groups/">实体组</a>时产生的事件。该消息类型为 <a href="/products/thingsboard-pe/">ThingsBoard PE</a> 专有。</td>
          <td><b>userName</b> - name of the user who performed assignment operation,<br><b>userId</b> - the user Id,<br><b>addedToEntityGroupName</b> - entity group name,<br><b>addedToEntityGroupId</b> - Id of entity group</td>
          <td>empty json payload</td>
      </tr>
      <tr>
          <td>REMOVED_FROM_ENTITY_GROUP</td>
          <td><b>已移出组</b></td>
          <td>实体从<a href="/docs/{{docsPrefix}}user-guide/groups/">实体组</a>中移除时产生的事件。该消息类型为 <a href="/products/thingsboard-pe/">ThingsBoard PE</a> 专有。</td>
          <td><b>userName</b> - name of the user who performed unassignment operation,<br><b>userId</b> - the user Id,<br><b>removedFromEntityGroupName</b> - entity group name,<br><b>removedFromEntityGroupId</b> - Id of entity group</td>
          <td>empty json payload</td>
      </tr>
      <tr>
          <td>ATTRIBUTES_UPDATED</td>
          <td><b>属性已更新</b></td>
          <td>执行实体属性更新时产生的事件</td>
          <td><b>userName</b> - name of the user who performed attributes update,<br><b>userId</b> - the user Id,<br><b>scope</b> - updated attributes scope (can be either <b>SERVER_SCOPE</b> or <b>SHARED_SCOPE</b>)</td>
          <td>key/value json with updated attributes: <br> <code style="font-size: 12px;">{ <br> &nbsp;&nbsp;"softwareVersion": "1.2.3" <br> }</code></td>
      </tr>
      <tr>
          <td>ATTRIBUTES_DELETED</td>
          <td><b>属性已删除</b></td>
          <td>实体部分属性被删除时产生的事件</td>
          <td><b>userName</b> - name of the user who deleted attributes,<br><b>userId</b> - the user Id,<br><b>scope</b> - deleted attributes scope (can be either <b>SERVER_SCOPE</b> or <b>SHARED_SCOPE</b>)</td>
          <td>json with <b>attributes</b> field containing list of deleted attributes keys: <br> <code style="font-size: 12px;">{ <br> &nbsp;&nbsp;"attributes": ["modelNumber", "serial"] <br> }</code></td>
      </tr>
      <tr>
        <td>ALARM</td>
        <td><b>告警事件</b></td>
        <td>告警被创建、更新或删除时产生的事件</td>
        <td> 
            All fields from original Message Metadata
            <br><b>isNewAlarm</b> - 若刚创建新告警则为 true
            <br><b>isExistingAlarm</b> - 若告警已存在则为 true
            <br><b>isClearedAlarm</b> - 若告警已清除则为 true
        </td>
        <td>json containing created alarm details: <br><code style="font-size: 12px;">
        {
          <br> &nbsp;&nbsp;"tenantId": {
            <br> &nbsp;&nbsp;&nbsp;&nbsp; ...
          <br> &nbsp;&nbsp;},
          <br> &nbsp;&nbsp;"type": "High Temperature Alarm",
          <br> &nbsp;&nbsp;"originator": {
            <br> &nbsp;&nbsp;&nbsp;&nbsp; ...
          <br> &nbsp;&nbsp;},
          <br> &nbsp;&nbsp;"severity": "CRITICAL",
          <br> &nbsp;&nbsp;"status": "CLEARED_UNACK",
          <br> &nbsp;&nbsp;"startTs": 1526985698000,
          <br> &nbsp;&nbsp;"endTs": 1526985698000,
          <br> &nbsp;&nbsp;"ackTs": 0,
          <br> &nbsp;&nbsp;"clearTs": 1526985712000,
          <br> &nbsp;&nbsp;"details": {
            <br> &nbsp;&nbsp;&nbsp;&nbsp;"temperature": 70,
            <br> &nbsp;&nbsp;&nbsp;&nbsp;"ts": 1526985696000
          <br> &nbsp;&nbsp;},
          <br> &nbsp;&nbsp;"propagate": true,
          <br> &nbsp;&nbsp;"id": "33cd8999-5dac-11e8-bbab-ad47060c9431",
          <br> &nbsp;&nbsp;"createdTime": 1526985698000,
          <br> &nbsp;&nbsp;"name": "High Temperature Alarm"
        <br>}
        </code>
        </td>
      </tr>
      <tr>
        <td>ALARM_ASSIGNED</td>
        <td><b>告警已分配</b></td>
        <td>告警被分配给某用户时产生的事件</td>
        <td> 
            All fields from original Message Metadata
            <br><b>entityName</b> - name of alarm
            <br><b>entityType</b> - ALARM
            <br><b>userEmail</b> - user email
            <br><b>userFirstName</b> - user first name
            <br><b>userId</b> - user id
            <br><b>userLastName</b> - user last name
            <br><b>userName</b> - user name
        </td>
        <td>json containing alarm details, see Alarm event<br>        
        </td>
      </tr>
      <tr>
        <td>ALARM_UNASSIGNED</td>
        <td><b>告警已取消分配</b></td>
        <td>告警从用户处取消分配时产生的事件</td>
        <td> 
            All fields from original Message Metadata
            <br><b>entityName</b> - name of alarm
            <br><b>entityType</b> - ALARM
            <br><b>userEmail</b> - user email
            <br><b>userFirstName</b> - user first name
            <br><b>userId</b> - user id
            <br><b>userLastName</b> - user last name
            <br><b>userName</b> - user name
        </td>
        <td>json containing alarm details, see Alarm event<br>        
        </td>
      </tr>
      <tr>
        <td>COMMENT_CREATED</td>
        <td><b>评论已创建</b></td>
        <td>告警评论被创建时产生的事件</td>
        <td> 
            All fields from original Message Metadata
            <br><b>userId</b> - user id
            <br><b>userName</b> - user name
            <br><b>userFirstName</b> - first name of user
            <br><b>userLastName</b> - last name of user
            <br><b>userEmail</b> - email of user
            <br><b>comment</b> - json object containing comment details and text of comment
        </td>
        <td>json containing alarm details, see Alarm event
        </td>
      </tr>
      <tr>
        <td>COMMENT_UPDATED</td>
        <td><b>评论已更新</b></td>
        <td>告警评论被更新时产生的事件</td>
        <td> 
            All fields from original Message Metadata
            <br><b>userId</b> - user id
            <br><b>userName</b> - user name
            <br><b>userFirstName</b> - first name of user
            <br><b>userLastName</b> - last name of user
            <br><b>userEmail</b> - email of user
            <br><b>comment</b> - json object containing comment details and text of comment
        </td>
        <td>json containing alarm details, see Alarm event
        </td>
      </tr>
      <tr>
          <td>REST_API_REQUEST</td>
          <td><b>发送至规则引擎的 REST API 请求</b></td>
          <td>用户执行 REST API 调用时产生的事件</td>
          <td><b>requestUUID</b> - the unique request id,<br><b>expirationTime</b> - the expiration time of the request</td>
          <td>json with request payload</td>
      </tr>
   </tbody>
</table>
 
## 规则节点类型

所有可用规则节点按其性质分组：

  * [**过滤节点**](/docs/user-guide/rule-engine-2-0/nodes/filter/){:target="_blank"} — 用于消息过滤与路由
  * [**丰富节点**](/docs/user-guide/rule-engine-2-0/nodes/enrichment/){:target="_blank"} — 用数据库中的信息丰富消息
  * [**转换节点**](/docs/user-guide/rule-engine-2-0/nodes/transformation/){:target="_blank"} — 修改消息字段，如来源、类型、数据和元数据
  * [**动作节点**](/docs/user-guide/rule-engine-2-0/nodes/action/){:target="_blank"} — 根据消息执行各类操作
  * [**外部节点**](/docs/user-guide/rule-engine-2-0/nodes/external/){:target="_blank"} — 与外部系统交互
  * [**流控节点**](/docs/user-guide/rule-engine-2-0/nodes/flow/){:target="_blank"} — 控制规则链间消息流及与队列交互
  * [**分析节点**](/docs/user-guide/rule-engine-2-0/nodes/analytics/){:target="_blank"} — 聚合数据

## 配置

每个规则节点可有依赖其实现的特定配置参数。
例如，「Filter - script」规则节点可通过处理入站数据的自定义 JS 函数配置。
「External - send email」节点可配置邮件服务器连接参数。
  
在规则链编辑器中双击节点可打开规则节点配置窗口：    
  
![image](/images/user-guide/rule-engine-2-0/rule-node-configuration.png)

### 测试脚本函数

部分规则节点提供用于测试 TBEL/JS 函数的 UI。
点击 **Test Filter Function** 将打开 JS 编辑器，可替换输入参数并验证函数输出。
    
![image](/images/user-guide/rule-engine-2-0/rule-node-test-function.png)

可配置：

- 左上角字段的 **Message Type**。
- 左侧 Message 区域的 **Message payload**。
- 右侧 Metadata 区域的 **Metadata**。
- Filter 区域中的实际 **TBEL/JS script**。

点击 **Test** 后，输出将在右侧 **Output** 区域显示。

## 规则引擎统计

ThingsBoard 团队已准备规则引擎的「默认」仪表板。
该仪表板会为每个租户自动加载。
可通过「Api Usage」->「View statistics」访问（见下图）。

{% include images-gallery.html imageCollection="open-statistics"  %}

统计收集默认启用，由配置属性控制。

您可在下方仪表板中查看处理错误及其原因的洞察：

{% include images-gallery.html imageCollection="view-statistics"  %}

## 调试

ThingsBoard 支持查看每个规则节点的入站和出站消息。
要启用调试，需在主配置窗口中勾选「Debug mode」（见[配置](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#configuration){:target="_blank"}节首图）。

调试启用后，可查看入站、出站消息及对应关系类型。
下图示例为调试消息视图：
  
![image](/images/user-guide/rule-engine-2-0/rule-node-debug.png)  

## 管理规则链

规则链页面展示已配置的租户规则链列表。可在此创建、导出/导入、删除规则链或将规则链设为根。

### 创建规则链

要添加新规则链，请执行：

{% include images-gallery.html imageCollection="create-rule-chain" showListImageTitles="true" %}

### 导入/导出

可将规则链[导出](#export-rule-chain)为 JSON 文件，并[导入](#import-rule-chain)到当前或其他 ThingsBoard 实例。

#### 导出规则链

要导出规则链，请执行：

- 进入「<b>规则链</b>」页面。
- 点击目标规则链行的「<b>导出规则链</b>」图标。
 
包含该规则链配置的 JSON 文件将保存到本地。

{% include images-gallery.html imageCollection="export-rule-chain" %}

#### 导入规则链

要从 JSON 文件导入规则链，请执行：

{% include images-gallery.html imageCollection="import-rule-chain" showListImageTitles="true" %}

{% capture difference %}
**注意 1：**
<br>
所有导入的规则链均**不是**根规则链。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture difference %}
**注意 2：**
<br>
若导入的规则链引用其他规则链（通过 **Rule Chain** 节点），保存前需更新这些引用。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 设为根规则链

要将规则链设为根，请执行：

{% include images-gallery.html imageCollection="make-rule-chain-as-root" showListImageTitles="true" %}

### 删除规则链

可通过以下任一方式删除规则链：

第一种方式：

{% include images-gallery.html imageCollection="delete-rule-chain-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-rule-chain-2" showListImageTitles="true" %}

也可一次删除多条规则链。

{% include images-gallery.html imageCollection="delete-rule-chain-3" showListImageTitles="true" %}

{% unless docsPrefix contains "paas/" %}
## 架构

了解规则引擎内部实现，请参阅[架构](/docs/{{docsPrefix}}reference/){:target="_blank"}页面。

{% endunless %}
## 向规则引擎发送自定义 REST API 调用

{% assign feature = "Custom Rule Engine REST API calls" %}{% include templates/pe-feature-banner.md %}

ThingsBoard 提供将自定义 REST API 调用发送至规则引擎的 API，处理请求负载并在响应体中返回处理结果。
适用于多种场景，例如：
 
 - 通过自定义 API 扩展平台现有 REST API；
 - 用设备/资产/客户属性丰富 REST API 调用并转发到外部系统做复杂处理；
 - 为自定义部件提供自定义 API。
 
要执行 REST API 调用，可使用 rule-engine-controller 的 [REST APIs](/docs/{{docsPrefix}}reference/rest-api/){:target="_blank"}： 
 
![image](/images/user-guide/rule-engine-2-0/rest-api.png) 

> <b>注意</b>：调用中指定的实体 ID 将成为规则引擎消息的来源。若不指定实体 ID 参数，当前用户实体将作为消息来源。

## 教程

ThingsBoard 提供若干教程，帮助通过示例设计规则链：

  * [**转换来自设备的入站消息**](/docs/user-guide/rule-engine-2-0/tutorials/transform-incoming-telemetry/){:target="_blank"} 
  * [**使用设备先前记录转换入站消息**](/docs/user-guide/rule-engine-2-0/tutorials/transform-telemetry-using-previous-record/) {:target="_blank"}
  * [**在入站设备消息时创建和清除告警**](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/){:target="_blank"}
  * [**设备告警时向客户发送邮件**](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) {:target="_blank"}
  * [**在关联设备间发送消息**](/docs/user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial/){:target="_blank"}
  
更多教程见[此处](/docs/{{docsPrefix}}guides/){:target="_blank"}。

{% unless docsPrefix contains "paas/" %}

## 故障排查

若使用 Kafka 队列处理消息，ThingsBoard 可监控消息推送到 Kafka 的速率是否高于消费与处理速率（若如此，消息处理延迟将增加）。
要启用该功能，需开启 Kafka consumer-stats（参见[配置属性](/docs/user-guide/install/{{docsPrefix}}config/#thingsboard-core-settings){:target="_blank"}的 <b>queue.kafka.consumer-stats</b> 节）。

启用 Kafka consumer-stats 后，可在日志中看到消费组的 offset lag（见[故障排查](/docs/user-guide/troubleshooting/#logs){:target="_blank"}）（tb-core、tb-rule-engine 及所有传输服务均有消费组日志）。

日志示例：

```bash
2021-03-19 15:01:59,794 [kafka-consumer-stats-11-thread-1] INFO  o.t.s.q.k.TbKafkaConsumerStatsService - [re-Main-consumer] Topic partitions with lag: [[topic=[tb_rule_engine.main.0], partition=[0], committedOffset=[5413], endOffset=[5418], lag=[5]]].
```

由此可知有 5 条（5418 - 5413 = 5）消息已推送到 <b>Main</b> 队列（<b>tb_rule_engine.main.0</b> Kafka 主题）但尚未处理。

日志一般结构如下：

```bash
TIME [STATS_PRINTING_THREAD_NAME] INFO  o.t.s.q.k.TbKafkaConsumerStatsService - [CONSUMER_GROUP_NAME] Topic partitions with lag: [[topic=[KAFKA_TOPIC], partition=[KAFKA_TOPIC_PARTITION], committedOffset=[LAST_PROCESSED_MESSAGE_OFFSET], endOffset=[LAST_QUEUED_MESSAGE_OFFSET], lag=[LAG]],[topic=[ANOTHER_TOPIC], partition=[], committedOffset=[], endOffset=[], lag=[]],...].
```

其中：
- `CONSUMER_GROUP_NAME` — 正在处理消息的消费组名称（可为规则引擎队列、core 队列等）
- `KAFKA_TOPIC` — Kafka 主题名称
- `KAFKA_TOPIC_PARTITION` — 主题分区号
- `LAST_PROCESSED_MESSAGE_OFFSET` — 消费端已处理的最后一条消息序号（规则引擎中最后确认的消息等）
- `LAST_QUEUED_MESSAGE_OFFSET` — 已成功推送到 Kafka 主题的最后一条消息序号
- `LAG` — 未处理消息数量

**注意：**仅当该消费组存在 lag 时才会打印相关日志。

{% endunless %}
