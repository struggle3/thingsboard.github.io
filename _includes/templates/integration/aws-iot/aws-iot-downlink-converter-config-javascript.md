{% include images-gallery.html imageCollection="downlink_0-1-1" %}

下行转换器示例：

```ruby
// 从传入规则引擎消息编码下行数据

// msg - 下行消息 JSON 负载
// msgType - 消息类型，例如 'ATTRIBUTES_UPDATED'、'POST_TELEMETRY_REQUEST' 等
// metadata - 包含消息附加数据的键值对列表
// integrationMetadata - 包含执行此转换器的集成中定义的附加数据的键值对列表

/** 编码器 **/
var data = {};

// 处理来自传入消息和元数据的数据
data.v0 = msg.state;
data.m0 = "att_upd_success";
data.devSerialNumber = metadata['ss_serialNumber'];

// 包含编码下行负载的结果对象
var result = {
    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",
    // 下行数据
    data: JSON.stringify(data),
    // 以键/值格式呈现的可选元数据对象
    metadata: {
            type: "sensors/device/upload"
    }
};
return result;
```
{: .copy-code}
