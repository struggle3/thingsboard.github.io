复制以下脚本：

```ruby
// 将规则引擎消息编码为下行数据

// msg - 下行消息的 JSON 载荷
// msgType - 消息类型，如 'ATTRIBUTES_UPDATED'、'POST_TELEMETRY_REQUEST' 等
// metadata - 消息的键值对形式的附加数据
// integrationMetadata - 执行此转换器的集成中定义的键值对形式的附加数据

var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(msg),

    // 可选的 key/value 形式元数据对象
    metadata: {
    }
};

return result;
```
{: .copy-code}

选择「Create new」并将复制的代码粘贴到编码器函数区域，点击「Next」；

![image](/images/pe/edge/integrations/http/add-http-integration-template-3-java-edge.png)