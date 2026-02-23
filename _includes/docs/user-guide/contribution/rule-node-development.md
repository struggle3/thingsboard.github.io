
* TOC
{:toc}

## 概述

本教程将介绍如何创建自定义 Rule Node 并将其添加到 ThingsBoard 服务器实例。
将涉及三种 Rule Node：Filter、Enrichment 和 Transformation。

## 前提条件

假设你已完成以下指南并阅读了下列文章：

  * [快速入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南
  * [Rule Engine 概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/) 文档

并已安装以下第三方依赖：

  * [OpenJDK 17](/docs/{{doscPrefix}}user-guide/install/ubuntu/#step-1-install-java-17-openjdk)
  * [Maven 3.6.0+](https://maven.apache.org/install.html)
  * Any modern Java IDE, although we recommend [IntelliJ IDEA](https://www.jetbrains.com/idea/download)
  * [Optional] Install [Lombok](https://projectlombok.org/) plugin to your favorite IDE.

## Step 1. 下载并构建示例项目

克隆仓库并进入仓库目录：

```bash
git clone -b {{ site.release.branch }} https://github.com/thingsboard/rule-node-examples
cd rule-node-examples
```
{: .copy-code}

默认情况下，示例项目配置为使用 ThingsBoard社区版的 API。
这使你的 Rule Node 与平台的 Community 版和 Professional 版均兼容。

若需使用 Professional Edition 专属 API（例如操作 Entity Groups 等），
请在 `pom.xml` 中修改 "thingsboard.version" 参数：

```bash
nano pom.xml
```
{: .copy-code}

例如，以下属性设置为 {{ site.release.pe_full_ver }} Professional Edition：

```xml
...
    <properties>
        ...
        <thingsboard.version>{{ site.release.pe_full_ver }}</thingsboard.version>
        ...
    </properties>
...
```
{: .copy-code}


最后，构建项目：

```bash
mvn clean install
```

预期输出：

```text
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.431 s
[INFO] Finished at: 2020-08-18T11:01:40+03:00
[INFO] ------------------------------------------------------------------------
```

## Step 2. 将项目导入 IDE

确保已安装 [Lombok](https://projectlombok.org/) 插件。将项目以 Maven 项目形式导入 IDE。

## Step 3. 创建 Rule Node

创建新 Rule Node 时，需实现
[TbNode](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbNode.java) interface and annotate it with the
[RuleNode](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/RuleNode.java) annotation.

例如，可参考一个根据消息 payload 中 key 是否存在过滤传入消息的简单 Rule Node。
此 Rule Node 是上一步下载项目的一部分。


```java
@RuleNode(
        type = ComponentType.FILTER,
        name = "check key",
        relationTypes = {"True", "False"},
        configClazz = TbKeyFilterNodeConfiguration.class,
        nodeDescription = "Checks the existence of the selected key in the message payload.",
        nodeDetails = "If the selected key exists - send Message via <b>True</b> chain, otherwise <b>False</b> chain is used.",
        uiResources = {"static/rulenode/custom-nodes-config.js"},
        configDirective = "tbFilterNodeCheckKeyConfig")
public class TbKeyFilterNode implements TbNode {

    private static final ObjectMapper mapper = new ObjectMapper();

    private TbKeyFilterNodeConfiguration config;
    private String key;


    @Override
    public void init(TbContext tbContext, TbNodeConfiguration configuration) throws TbNodeException {
        this.config = TbNodeUtils.convert(configuration, TbKeyFilterNodeConfiguration.class);
        key = config.getKey();
    }

    @Override
    public void onMsg(TbContext ctx, TbMsg msg) {
        try {
            ctx.tellNext(msg, mapper.readTree(msg.getData()).has(key) ? "True" : "False");
        } catch (IOException e) {
            ctx.tellFailure(msg, e);
        }
    }

    @Override
    public void destroy() {
    }
}
```

上述源码需注意以下几点：

### @RuleNode 注解

@RuleNode 注解定义节点类型、名称、描述、UI 表单及出站 [relations](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection)。

可用参数说明如下：

* *type*：可选 [Rule Node 类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-types) 之一，决定 Rule Chain Editor 中 Rule Node 所属分组；
* *name*：Rule Node 名称，用于 Rule Chain Editor 及调试信息；
* *nodeDescription*：节点简要描述，在 Rule Chain Editor 中展示；
* *nodeDetails*：节点完整描述，支持 HTML，在 Rule Chain Editor 中展示；
* *configClazz*：描述配置 JSON 的完整类名；
* *relationTypes*：预定义 [relation types](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection) 字符串数组，应与 [TbContext.tellNext](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbContext.java#L76) 中使用的值一致；
* *customRelations*：布尔值，表示是否在 [TbContext.tellNext](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbContext.java#L76) 中使用自定义 relations；
* *configDirective*：用于编辑 Rule Node 配置的 Angular UI 指令名，可选，为空时使用原始 JSON 编辑器；
* *uiResources*：包含配置指令的 Angular UI 文件路径，可选，为空时使用原始 JSON 编辑器；
* *icon*：angular material 包中的图标名；
* *iconUrl*：Rule Chain Editor 节点列表中显示 Rule Node 的图标完整 URL；
* *docUrl*：Rule Node 文档页链接，在 Rule Chain Editor 中可见。 


### Rule Node 生命周期

**"init"** 方法在创建新 Rule Node 时由 Rule Engine 调用，
例如将 Rule Node 添加到 Rule Chain 或系统重启时。
此方法主要用于解析 JSON 配置或获取 [TbContext](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbContext.java) 本地副本。
"TbNodeUtils.convert" 将原始配置解析为指定类的 Java 对象。

**"destroy"** 方法在 Rule Node 销毁时由 Rule Engine 调用，
例如从 Rule Chain 中移除 Rule Node 或系统停止时。

用户修改现有 Rule Node 配置时，Rule Engine 会依次调用 **"destroy"** 和 **"init"**。

### 处理传入消息

Rule Node 实现**必须**使用下列方法之一告知 Rule Engine 消息已成功处理：

```java

/**
 * 表示 Rule Node 已成功处理消息。
 * 将消息发送到 Rule Chain 中通过 "Success" relationType
 * 连接到当前 Rule Node 的所有 Rule Node。
 *
 * @param msg
 */
void tellSuccess(TbMsg msg);

/**
 * 将消息发送到 Rule Chain 中通过指定 relationType
 * 连接到当前 Rule Node 的所有 Rule Node。
 *
 * @param msg
 * @param relationType
 */
void tellNext(TbMsg msg, String relationType);

/**
 * 将消息发送到 Rule Chain 中通过指定 relationTypes 之一
 * 连接到当前 Rule Node 的所有 Rule Node。
 *
 * @param msg
 * @param relationTypes
 */
void tellNext(TbMsg msg, Set<String> relationTypes);

```

若消息处理失败，Rule Node 实现**必须**调用 "tellFailure" 方法：

```java

/**
 * 向 Rule Engine 通知当前消息处理失败。
 *
 * @param msg - 消息
 * @param th  - 异常
 */
void tellFailure(TbMsg msg, Throwable th);

```

若 Rule Node 实现未调用上述任何方法，Rule Engine 将等待可配置超时，**阻塞**其他消息处理，并最终将当前消息标记为失败。

### 使用 ThingsBoard 服务

[TbContext](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbContext.java) 包含多种有用服务的 "getter"。
请在 IDE 中勾选 "Download Sources" 以方便浏览这些服务的接口。
可用服务 getter 简要列表如下：

```java
// 操作实体 attributes：读取和保存；
AttributesService getAttributesService();

// 对 customer 实体执行 CRUD（Create、Read、Update、Delete）操作；
CustomerService getCustomerService();

// 对用户执行 CRUD 操作；
UserService getUserService();

// 对 assets 执行 CRUD 操作；
AssetService getAssetService();

// 对 devices 执行 CRUD 操作；
DeviceService getDeviceService();

// 对 entity views 执行 CRUD 操作；
EntityViewService getEntityViewService();

// 以编程方式创建和管理 dashboards；
DashboardService getDashboardService();

// 创建和清除 alarms；
RuleEngineAlarmService getAlarmService();

// 以编程方式创建和管理 rule chains；
RuleChainService getRuleChainService();

// 向设备发送 RPC 命令；
RuleEngineRpcService getRpcService();

// 将 telemetry 存储到数据库并通过 WebSocket 推送到 dashboards；
RuleEngineTelemetryService getTelemetryService();

// 查找 telemetry 并保存到数据库，不向 dashboards 发送通知；
TimeseriesService getTimeseriesService();

// 以编程方式查询和管理实体 relations；
RelationService getRelationService();
```

ThingsBoard PE 用户可通过 *TbContext.getPeContext()* 访问额外服务。TbPeContext 提供以下服务：

```java
// 以编程方式创建和管理 integrations；
IntegrationService getIntegrationService();

// 以编程方式创建和管理 entity groups；
EntityGroupService getEntityGroupService();

// 以编程方式创建 reports；
ReportService getReportService();

// 以编程方式管理 blob 实体；
BlobEntityService getBlobEntityService();

// 以编程方式管理 group 权限；
GroupPermissionService getGroupPermissionService();

// 以编程方式管理 roles；
RoleService getRoleService();

// 获取实体 owner（TenantId 或 CustomerId）
EntityId getOwner(TenantId tenantId, EntityId entityId);

// 清除实体 owners 缓存
void clearOwners(EntityId entityId);

// 获取当前实体的所有子 customers
Set<EntityId> getChildOwners(TenantId tenantId, EntityId parentOwnerId);

// 变更实体 owner，targetOwnerId 为 TenantId 或 CustomerId
void changeDashboardOwner(TenantId tenantId, EntityId targetOwnerId, Dashboard dashboard) throws ThingsboardException;

void changeUserOwner(TenantId tenantId, EntityId targetOwnerId, User user) throws ThingsboardException;

void changeCustomerOwner(TenantId tenantId, EntityId targetOwnerId, Customer customer) throws ThingsboardException;

void changeEntityViewOwner(TenantId tenantId, EntityId targetOwnerId, EntityView entityView) throws ThingsboardException;

void changeAssetOwner(TenantId tenantId, EntityId targetOwnerId, Asset asset) throws ThingsboardException;

void changeDeviceOwner(TenantId tenantId, EntityId targetOwnerId, Device device) throws ThingsboardException;

void changeEntityOwner(TenantId tenantId, EntityId targetOwnerId, EntityId entityId, EntityType entityType) throws ThingsboardException;

// 向 integration 推送自定义 downlink 消息
void pushToIntegration(IntegrationId integrationId, TbMsg tbMsg, FutureCallback<Void> callback);
```


### 从 Rule Node 创建新消息

有时需要基于当前消息创建并推送派生消息到 Rule Engine。 
例如，编写一个将当前 customer 的消息复制到其所有 devices 的自定义 Rule Node：

```java

@Override
public void onMsg(TbContext ctx, TbMsg msg) {
    EntityId msgOriginator = msg.getOriginator();
    // 确认消息来源为 Customer；
    if (EntityType.CUSTOMER.equals(msgOriginator.getEntityType())) {
        CustomerId customerId = new CustomerId(msgOriginator.getId());
        boolean hasNext = true;
        // 创建 page link 以遍历 devices；
        PageLink pageLink = new PageLink(1024);
        while (hasNext) {
            // 使用 Device Service 从数据库获取 devices；
            PageData<Device> devices = ctx.getDeviceService().findDevicesByTenantIdAndCustomerId(ctx.getTenantId(), customerId, pageLink);
            hasNext = devices.hasNext();
            pageLink = pageLink.nextPageLink();
            for (Device device : devices.getData()) {
                // 创建具有不同 originator 的新消息
                TbMsg newMsg = TbMsg.newMsg(msg.getQueueName(), msg.getType(), device.getId(), msg.getMetaData(), msg.getData());
                // 使用 enqueueForTellNext 而非 tellNext 推送到队列，确保消息被持久化；
                ctx.enqueueForTellNext(newMsg, "Success");
            }
        }
        // 不要忘记确认原始消息或调用 ctx.tellSuccess(msg)；
        ctx.ack(msg);
    } else {
        ctx.tellFailure(msg, new IllegalArgumentException("Msg originator is not Customer!"));
    }
}

```

我们使用 [TbContext.enqueueForTellNext](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbContext.java#L119) 将新消息推送到 Rule Engine。
消息将根据 relation type 推送到相关 Rule Nodes。另一种方式是将消息置于处理起点，即 root rule chain。

```java

void enqueue(TbMsg msg, String queueName, Runnable onSuccess, Consumer<Throwable> onFailure);

```

也可使用另一方法，以接收新消息成功入队的确认：

```java

void enqueueForTellNext(TbMsg msg, String queueName, String relationType, Runnable onSuccess, Consumer<Throwable> onFailure);

```

### 多线程

Rule Engine 采用 [actor model](https://en.wikipedia.org/wiki/Actor_model) 实现，对 Rule Node 邮箱中的每条新消息
依次调用 [TbNode.onMsg](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbNode.java#L30)。
因此，若在同一线程中处理消息，实现是线程安全的。

但出于性能考虑，大部分 API 调用在单独线程中执行。
例如，以下为保存传入消息中 telemetry 的正确方式：

```java

@Override
public void onMsg(TbContext ctx, TbMsg msg) {
    try {
        // 解析传入消息；
        ObjectNode json = (ObjectNode) mapper.readTree(msg.getData());
        // 将温度从 °F 转为 °C
        double temperatureF = json.get("temperature").asDouble();
        double temperatureC = (temperatureF - 32) * 5 / 9;
        // 创建 telemetry 数据点
        TsKvEntry tsKvEntry = new BasicTsKvEntry(System.currentTimeMillis(), new DoubleDataEntry("temperature", temperatureC));
        // 使用异步 API 并通过 callback 保存 telemetry
        ctx.getTelemetryService().saveAndNotify(ctx.getTenantId(), msg.getOriginator(), Collections.singletonList(tsKvEntry), new FutureCallback<Void>() {
            @Override
            public void onSuccess(@Nullable Void aVoid) {
                // telemetry 已保存，可确认消息；
                ctx.tellSuccess(msg);
            }

            @Override
            public void onFailure(Throwable throwable) {
                // telemetry 未保存，需由 Rule Engine 重新处理消息；
                ctx.tellFailure(msg, throwable);
            }
        });
    } catch (JsonProcessingException e) {
        ctx.tellFailure(msg, e);
    }
}

```

注意，我们是在 callback 线程中通过 TbContext.tellSuccess "确认"或"转发"消息，而非主线程。


### 集群模式

每个 rule-engine 微服务会启动一个 Rule Node 实例。例如有 3 个 rule engine 实例时，每个都会启动一个 RuleNode 实例。
Rule Engine [messages](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-message) 按消息 originator id（device 或 asset id）分区。
因此，来自同一 device 的消息会始终发送到特定 rule engine 微服务上的同一 Rule Node 实例。
仅当 Rule Nodes 被添加或移除时会出现 "repartition" 事件。

作为 Rule Node 开发者，可重写 [TbNode.onPartitionChangeMsg](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbNode.java#L34)
以响应集群拓扑变化。对根据消息 originator（device/asset）id 缓存信息的有状态节点很有用。
要判断当前 entity id 是否属于当前分配的 partition 列表，可使用 [TbContext.isLocalEntity](https://github.com/thingsboard/thingsboard/blob/{{ site.release.branch }}/rule-engine/rule-engine-api/src/main/java/org/thingsboard/rule/engine/api/TbContext.java#L152)。
完整示例如下：

```java
package org.thingsboard.rule.engine.node.filter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.thingsboard.rule.engine.api.EmptyNodeConfiguration;
import org.thingsboard.rule.engine.api.RuleNode;
import org.thingsboard.rule.engine.api.TbContext;
import org.thingsboard.rule.engine.api.TbNode;
import org.thingsboard.rule.engine.api.TbNodeConfiguration;
import org.thingsboard.rule.engine.api.TbNodeException;
import org.thingsboard.server.common.data.DataConstants;
import org.thingsboard.server.common.data.id.EntityId;
import org.thingsboard.server.common.data.kv.AttributeKvEntry;
import org.thingsboard.server.common.data.plugin.ComponentType;
import org.thingsboard.server.common.msg.TbMsg;
import org.thingsboard.server.common.msg.queue.PartitionChangeMsg;

import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.ExecutionException;


@Slf4j
@RuleNode(
        type = ComponentType.FILTER,
        name = "Cache example",
        relationTypes = {"True", "False"},
        configClazz = EmptyNodeConfiguration.class,
        nodeDescription = "Checks that the incoming value exceeds certain threshold",
        nodeDetails = "If temperature is too high - send Message via <b>True</b> chain, otherwise <b>False</b> chain is used.",
        uiResources = {"static/rulenode/rulenode-core-config.js"},
        configDirective = "tbNodeEmptyConfig")
public class TbCacheExampleNode implements TbNode {

    private static final ObjectMapper mapper = new ObjectMapper();
    private ConcurrentMap<EntityId, Double> cache;

    @Override
    public void init(TbContext tbContext, TbNodeConfiguration configuration) throws TbNodeException {
        this.cache = new ConcurrentHashMap<>();
    }

    @Override
    public void onMsg(TbContext ctx, TbMsg msg) {
        try {
            // 解析传入消息；
            ObjectNode json = (ObjectNode) mapper.readTree(msg.getData());
            double temperature = json.get("temperature").asDouble();
            // 从缓存或数据库获取 temperatureThreshold attribute
            Double temperatureThreshold = getCacheValue(ctx, msg.getOriginator(), "temperatureThreshold", 42);
            // 比较并对比较结果进行处理；
            ctx.tellNext(msg, temperature > temperatureThreshold ? "True" : "False");
        } catch (JsonProcessingException e) {
            ctx.tellFailure(msg, e);
        }
    }

    @Override
    public void onPartitionChangeMsg(TbContext ctx, PartitionChangeMsg msg) {
        // 清除已不再分配给当前服务器 partition 的实体缓存
        cache.entrySet().removeIf(entry -> !ctx.isLocalEntity(entry.getKey()));
    }

    private double getCacheValue(TbContext ctx, EntityId entityId, String attributeKey, double defaultValue) {
        // 从缓存或数据库获取值。
        return cache.computeIfAbsent(entityId, id -> {
            try {
                Optional<AttributeKvEntry> attr = ctx.getAttributesService().find(ctx.getTenantId(), entityId, DataConstants.SERVER_SCOPE, attributeKey).get();
                if (attr.isPresent()) {
                    return attr.get().getDoubleValue().orElse(defaultValue);
                } else {
                    return defaultValue;
                }
            } catch (InterruptedException | ExecutionException e) {
                throw new RuntimeException(e);
            }
        });
    }


    @Override
    public void destroy() {
        // 若配置已变更，建议清空整个缓存。
        cache.clear();
    }
}

```


## Step 4. 将自定义 Rule Nodes 导入 ThingsBoard 实例

完成 Rule Node 编码后，再次执行构建命令：

```bash
mvn clean install
```

然后，将 jar 文件作为依赖库放入 ThingsBoard 项目。构建产物位于：

```bash
target/rule-engine-1.0.0-custom-nodes.jar
```

现在可将包含 Rule Nodes 的 jar 文件添加到 ThingsBoard 实例：
{% unless docsPrefix %}
* ThingsBoard 以服务方式安装时使用 Step 4.1。
* ThingsBoard 从源码构建并本地 IDE 启动时使用 Step 4.2。

### Step 4.1 将 JAR 文件添加到以服务方式安装的 ThingsBoard
{% endunless %}

- 首先，执行以下命令将 jar 文件复制到 ThingsBoard extensions：

```bash
sudo cp rule-engine-1.0.0-custom-nodes.jar /usr/share/thingsboard/extensions/
```

- 接着执行以下命令将 owner 改为 ThingsBoard：

```bash
sudo chown thingsboard:thingsboard /usr/share/thingsboard/extensions/*
```

重启 ThingsBoard 服务：

```bash
sudo service thingsboard restart
```

**ThingsBoard 重启后需清除浏览器缓存并刷新页面以重新加载 Rule Nodes 的 UI**

{% unless docsPrefix %}
### Step 4.2 将 JAR 文件添加到使用 IDE 启动的本地 ThingsBoard

- 参见 [IDEA](https://www.jetbrains.com/help/idea/library.html#add-library-to-module-dependencies) 和 [Eclipse](https://help.eclipse.org/luna/index.jsp?topic=%2Forg.eclipse.jst.j2ee.doc.user%2Ftopics%2Ftjimpapp.html) 的独立说明。
 
重启 ThingsBoard 服务端容器。详见：[Running server-side container](/docs/{{docsPrefix}}user-guide/contribution/how-to-contribute/#running-server-side-container)。
 
**ThingsBoard 重启后需清除浏览器缓存并刷新页面以重新加载 Rule Nodes 的 UI**
{% endunless %}

## Step 5. 在 thingsboard.yml 中添加自定义包名

**注意**：若将包名从 **org.thingsboard.rule.engine** 改为公司包名（如 **com.example.rule.engine**），
需在 **thingsboard.yml** 的 plugins 部分添加该包名：

```yaml
# 插件配置参数
plugins:
  # 插件 classpath 扫描时使用的逗号分隔包列表
  scan_packages: "${PLUGINS_SCAN_PACKAGES:org.thingsboard.server.extensions,org.thingsboard.rule.engine,com.example.rule.engine}"

```

## Step 6. 排查 Rule Node 问题

验证自定义 Rule Node 的简便方式是创建 [generator](/docs/user-guide/rule-engine-2-0/nodes/action/generator/) Rule Node
并连接到自定义 Rule Node，以生成可配置的传入消息流。
完成后，为自定义 Rule Node 开启 [debug](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#debugging) 以验证节点输出并检查错误。 

{% unless docsPrefix %}
## Step 7. Rule Node UI 定制（可选）

ThingsBoard Rule Nodes 的 UI 通过官方 [github repo](https://github.com/thingsboard/rule-node-examples-ui-ngx) 中的另一项目配置。构建说明详见 [link](https://github.com/thingsboard/rule-node-examples-ui-ngx#rule-node-examples-ui-ngx)。

在热重载模式下运行 Rule Node UI 容器：

- 首先在 **proxy.conf.js** 中将常量 **ruleNodeUiforwardPort** 从 **8080** 改为 **5000**，文件位置：

```
nano ${TB_WORK_DIR}/ui-ngx/proxy.conf.js
```

- 其次，以热重载模式运行 UI 容器。详见：[Running UI container in hot redeploy mode](/docs/{{docsPrefix}}user-guide/contribution/how-to-contribute/#running-ui-container-in-hot-redeploy-mode)。

- 最后在本地目录 **TB_RULE_NODE_UI_WORK_DIR** 中执行：

    ```
    npm start
    ```
{% endunless %}

## 下一步

 {% assign currentGuide = "Contribution" %}{% include templates/multi-project-guides-banner.md %}
