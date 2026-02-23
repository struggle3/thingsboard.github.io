可根据您的配置自定义 downlink。以下示例为发送 attribute 更新消息。需在 downlink encoder function 中的
`//downlink data input` 行修改代码

```
data: msg.firmware
```
{: .copy-code}

并在 metadata 中指明所需参数：

```
metadata: {
  "EUI": "$Device_EUI",
  "port": 1
}
```
{: .copy-code}

&#42;**EUI** 为设备 EUI，来自 LORIOT 中的设备。

&#42;**port** 取值范围为 1 到 223。

{% include images-gallery.html imageCollection="devices" %}

Downlink converter 示例：

```javascript
// Encode downlink data from incoming Rule Engine message
// msg - JSON message payload downlink message json
// msgType - type of message, for ex. 'ATTRIBUTES_UPDATED', 'POST_TELEMETRY_REQUEST', etc.
// metadata - list of key-value pairs with additional data about the message
// integrationMetadata - list of key-value pairs with additional data defined in Integration executing this converter
// Result object with encoded downlink payload
var result = {
    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "TEXT",
    // downlink data
    data: msg.firmware,
    // Optional metadata object presented in key/value format
    metadata: {
            "EUI": "BE7A000000000552",
            "port": 1
    }
};
return result;
``` 
{: .copy-code}

<br>
**ThingsBoard 4.0** 中为 Loriot downlink 功能新增选项，支持避免双重十六进制编码。
若数据已是十六进制格式，可在消息中添加以下 metadata 属性：

```
"isHexEncoded": "true"
```
{: .copy-code}

启用该属性后，downlink 消息将以非双重十六进制编码形式发送至 Loriot。

无双重十六进制编码的 downlink converter 示例：

```javascript
// Encode downlink data from incoming Rule Engine message
// msg - JSON message payload downlink message json
// msgType - type of message, for ex. 'ATTRIBUTES_UPDATED', 'POST_TELEMETRY_REQUEST', etc.
// metadata - list of key-value pairs with additional data about the message
// integrationMetadata - list of key-value pairs with additional data defined in Integration executing this converter
// Result object with encoded downlink payload
var result = {
    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "TEXT",
    // downlink data
    data: "B104",
    // Optional metadata object presented in key/value format
    metadata: {
        "EUI": "BE7A000000000552",
        "port": 1, 
        "isHexEncoded": "true"
    }
};
return result;
``` 
{: .copy-code}

向 integration 添加 converter。可在创建 integration 或编辑时完成。

{% include images-gallery.html imageCollection="create_downlink-java" %}