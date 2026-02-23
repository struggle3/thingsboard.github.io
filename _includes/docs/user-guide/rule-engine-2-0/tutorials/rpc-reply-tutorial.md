* TOC
{:toc}

本教程说明如何使用 [RPC call reply](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply/) 节点，并涵盖：
- 使用 [rule chain](/docs/user-guide/rule-engine-2-0/nodes/flow/rule-chain/) 节点创建并连接不同 rule chains。
- 使用 filter [script](/docs/user-guide/rule-engine-2-0/nodes/filter/script/) 节点过滤消息。
- 使用 transformation [script](/docs/user-guide/rule-engine-2-0/nodes/transformation/script/) 节点转换入站消息。
- 使用 [related entity data](/docs/user-guide/rule-engine-2-0/nodes/enrichment/related-entity-data/) 节点获取关联实体的最新 telemetry。
- 使用 [log](/docs/user-guide/rule-engine-2-0/nodes/action/log/) 节点记录消息。

## 简介
有两个设备：controller 和 thermostat。需从 controller 发起 [client-side RPC](/docs/{{docsPrefix}}user-guide/rpc/#client-side-rpc) 调用，请求关联 thermostat 的当前温度。
RPC 调用包含 2 个属性：

- method：**getCurrentTemperature**
- params：**空 JSON 对象**

## 模型定义
房间内安装有 2 个设备：thermostat 和 controller。 

- thermostat 表示为 Device，名称为 **Thermostat A**，类型为 **Thermostat**。 
- controller 表示为 Device，名称为 **Controller A**，类型为 **Controller**。 
- 通过 relation 类型 **Thermostat** 创建从 **Controller A** 到 **Thermostat A** 的 relation。

## 配置 Rule Chains

### 新建 Rule Chain：Related thermostat temperature

进入 **Rule Chains** -> **Add new Rule Chain** 

配置：

- Name：**Related thermostat temperature**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/create-chain.png)

规则链已创建。点击规则链行以打开。

##### 添加节点：related entity data
添加 **related entity data** 节点并将其连接到 **input** 节点。

该节点将获取关联 thermostat **Thermostat A** 的最新 **temperature** 读数，并以 **roomTemperature** 为名保存到消息 metadata 中。

配置：

- Name：**Get temperature from related Thermostat**
- Direction：**From originator**
- Max relation level：**1**
- Relation type：**Thermostat**
- Entity type：**Device**
- Data to fetch：**Latest telemetry**
- Source attribute key：**temperature**
- Target key：**roomTemperature**

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-related-entity-data-config-data-to-fetch.png)

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-related-entity-data-config-relations-query.png)

##### 添加 transformation 节点：script
添加 transformation **script** 节点并将其连接到 **related entity data** 节点。

该节点将把原始消息转换为 RPC 回复消息。**RPC call reply** 节点以消息 payload 作为对请求的响应发送，因此需在 transformation 节点中构建正确的 payload。

配置：

- Name：**Build response**
- ScriptLang：**TBEL**
- Script:
  ```javascript 
     return {msg: {"temperature": metadata.roomTemperature}, metadata: metadata, msgType: msgType};
  ```
  {: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/transform.png)

##### 添加 action 节点：RPC call reply
**RPC call reply** 节点从消息 metadata 中获取 RPC requestId，该 id 用于识别入站 RPC 调用。

该节点获取消息 payload 并作为响应发送给消息 originator。

配置：

- Name：**Send response**
- Request ID：**requestId**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/reply.png)

<br>
<br>

该规则链已配置完毕，请保存。**Related thermostat temperature** 规则链应如下所示：

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/rpc-chain-view.png)


### 连接规则链
现在将把新规则链与 **Root Rule Chain** 连接起来。

需要把 **method** 属性为 **getCurrentTemperature** 的入站 RPC 请求路由到新规则链 **Related thermostat temperature**。
返回规则链列表并打开 **Root Rule Chain** 进行所需修改。

##### 添加 filter 节点：script
添加 filter **script** 节点，并以 relation type **RPC Request from Device** 连接到默认 **message type switch** 节点。

默认 **Root Rule Chain** 应已有从 **message type switch** 到名为 "Log RPC from Device" 的 **log** 节点的连接。
此时需用新建的 **script** 节点替换 log 节点 **Log RPC from Device**。
请不要删除 log 节点，将复用它记录未知 RPC 请求。

配置：

- Name：**Filter getCurrentTemperature RPC**
- ScriptLang：**TBEL**
- Script:
  ```javascript 
     return msg.method == "getCurrentTemperature";
  ```
  {: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/filter-rpc-request.png)

此后，所有 message type 为 **RPC Request from Device** 的入站消息都会路由到此节点。
在该节点内，函数仅过滤 **method** == **getCurrentTemperature** 的允许 RPC 请求。

##### 添加节点：rule chain
添加 **rule chain** 节点，以 **True** 连接连接到上一个 filter *script* 节点 "Filter getCurrentTemperature RPC"。

配置：

- Name：**To Related thermostat temperature**
- Rule Chain：**Related thermostat temperature**
- Forward message to the originator's default rule chain：**Disabled**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/add-rule-chain-node.png)

现在，所有满足配置 filter 的消息都会路由到 **Related thermostat temperature** 规则链。

##### 记录未知请求
将 filter **script** 节点 "Filter getCurrentTemperature RPC" 以 **False** 连接重新连接到先前断开的 **log** 节点。
所有 method 不等于 "getCurrentTemperature" 的入站 RPC 请求将从 filter **script** 传递到 **log** 节点。

配置：

- Name：**Log RPC from Device**
- ScriptLang：**TBEL**
- Script:
  ```javascript 
     return '\nIncoming message:\n' + JSON.stringify(msg) + '\nIncoming metadata:\n' + JSON.stringify(metadata);
  ```
  {: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/log-unexpected.png)

<br>
<br>

**Root Rule Chain** 的修改已完成，请保存。**Root Rule Chain** 应如下所示：

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/root-chain-view.png)


## 验证配置
配置已完成，可验证规则链是否按预期工作。

先从为 **Thermostat A** 设备发布 "temperature" telemetry 开始。发送 HTTP 请求将使用 **curl** 工具。

- 触发 telemetry 上传：进入设备页的 **Check connectivity** 选项卡，复制 **curl** 命令以发布 thermostat 设备的 telemetry。

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/copy-curl-command.png)

- 执行复制的命令：

```shell
curl -v -X POST https://thingsboard.cloud/api/v1/CF8zr16VZeCk7zRyztZB/telemetry --header Content-Type:application/json --data "{temperature:25}"
```
{: .copy-code}

将使用 REST RPC API 模拟 **Controller A** 设备从设备到服务器的 RPC 请求。

为触发 RPC 请求，需对 **Controller A** 设备执行与 **Thermostat A** 相同操作：从 **Check connectivity** 选项卡复制 **curl** 命令。
然后修改命令以触发 REST RPC API：

 - 将 API 路径中的 **telemetry** 替换为 **rpc**
 - 将 payload 从 <code>{temperature:25}</code> 改为 <code>{method: "getCurrentTemperature", params:{}}</code>

修改后的命令应类似：

```shell
curl -v -X POST https://thingsboard.cloud/api/v1/ZcHBHbptBqxgV1A6Qrtx/rpc --header Content-Type:application/json --data "{method: "getCurrentTemperature", params:{}}"
```
{: .copy-code}

响应：
```shell
{"temperature":"25"}
```
{: .copy-code}

符合预期。**Controller A** 向 ThingsBoard 发送 method 为 **getCurrentTemperature** 的 RPC 调用。
消息经配置的规则链路由，关联 thermostat 的最新 telemetry 被获取并返回在响应中。

若尝试提交未知 method 的请求：

```shell
curl -v -X POST https://thingsboard.cloud/api/v1/ZcHBHbptBqxgV1A6Qrtx/rpc --header Content-Type:application/json --data "{method: "getCurrentHumidity", params:{}}"
```
{: .copy-code}

可在 ThingsBoard 日志中看到：

<br>

```less
[rule-dispatcher-0-3] INFO  o.t.rule.engine.action.TbLogNode -
Incoming message:
{"method":"getCurrentHumidity","params":{}}
Incoming metadata:
{"deviceType":"Controller","requestId":"1","sessionId":"54c2abd1-6496-4ab3-9036-e044083b1823","serviceId":"tb-core-1","deviceName":"Controller A"}
```
{: .copy-code}

<br>
<br>
有关 ThingsBoard 中 RPC 的更多说明，请阅读 [RPC capabilities](/docs/{{docsPrefix}}user-guide/rpc/) 一文。
<br>
<br>
