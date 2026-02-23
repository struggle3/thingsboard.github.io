复制以下脚本：

```ruby
// 从 incoming Rule Engine 消息编码下行数据

// msg - 下行消息的 JSON 消息 payload
// msgType - 消息类型，例如 'ATTRIBUTES_UPDATED'、'POST_TELEMETRY_REQUEST' 等
// metadata - 包含消息附加数据的键值对列表
// integrationMetadata - 包含执行此转换器的 Integration 中定义的附加数据的键值对列表

var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(msg),

    // 可选的 metadata 对象，以键/值格式表示
    metadata: {
    }
};

return result;
```
{: .copy-code}

选择「Create new」并将复制的代码粘贴到 Encoder 函数部分。点击「Next」；

![image](/images/pe/edge/integrations/http/add-http-integration-template-3-edge.png)