将传入消息作为下行消息推送到选定的集成。消息路由至 `Success` 连接（成功提交到集成时）或 `Failure` 连接（提交期间发生错误时）。

## 用法

通过集成发送下行消息的典型流程如下：

1. 消息到达 integration downlink 节点，包含要发送给设备的数据。可以是命令、配置更新或任何其他 payload。

2. 消息推送到集成，根据其协议特定逻辑（如发布到 MQTT topic）进行处理。

3. 若消息成功提交到集成，经 `Success` 连接路由。若提交期间发生错误，经 `Failure` 连接路由。

{% capture async_note %}
**异步处理**：`Success` 连接表示消息已成功提交到集成以供处理，而非下行已投递到设备。实际投递到设备由集成异步进行。
{% endcapture %}
{% include templates/warn-banner.md content=async_note %}

{% capture integration_note %}
**需配置集成**：使用此节点前，请确保目标集成已在 ThingsBoard 实例中正确配置并启用。
{% endcapture %}
{% include templates/info-banner.md content=integration_note %}

## 配置

配置指定哪个集成应接收下行消息。

- **Integration（集成）** - 将推送下行消息的集成。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbIntegrationDownlinkConfiguration",
  "type": "object",
  "properties": {
    "integrationId": {
      "type": "string",
      "format": "uuid",
      "description": "The UUID of the integration to push downlink messages to."
    }
  },
  "required": [
    "integrationId"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点将完整传入消息推送到集成。
2. 消息成功提交到集成后，经 `Success` 连接转发。

## 输出连接

- `Success`
    - 消息已成功提交到集成以供处理。传出消息与传入消息相同。
- `Failure`
    - 提交期间发生错误，例如：
        - 集成不存在
        - 集成已禁用
        - 未能将消息提交到集成

## 示例

### 示例 1 — 将遥测转发到外部 MQTT broker

**传入消息**

发起者：`DEVICE`。

数据：

```json
{
  "voltage": 230.5,
  "current": 12.3,
  "power": 2835.15,
  "energy": 145.6
}
```

元数据：

```json
{
  "deviceName": "smart-meter-001",
  "deviceType": "smart-meter"
}
```

**节点配置**

```json
{
  "integrationId": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d"
}
```

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

遥测数据成功提交到配置为将数据转发到外部分析平台的 MQTT 集成。集成将把消息发布到外部 broker 的相应 MQTT topic 以供进一步处理。
