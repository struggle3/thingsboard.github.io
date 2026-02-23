{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-downlink-java-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-java-1-pe.png)
{% endif %}

<br>
向集成添加转换器。您可以根据配置自定义下行。
我们来看一个发送属性更新消息的示例。因此我们应修改 **//下行数据** 输入行下的下行编码器函数中的代码：

```ruby
data: JSON.stringify(msg)
```
{: .copy-code}
其中 **msg** 是我们接收并发回设备的消息。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-downlink-java-2-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-java-2-pe.png)
{% endif %}

<br>
下行转换器示例：

```ruby
// 从传入规则引擎消息编码下行数据

// msg - 下行消息 JSON 负载
// msgType - 消息类型，例如 'ATTRIBUTES_UPDATED'、'POST_TELEMETRY_REQUEST' 等
// metadata - 包含消息附加数据的键值对列表
// integrationMetadata - 包含执行此转换器的集成中定义的附加数据的键值对列表

var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(msg),

    // 以键/值格式呈现的可选元数据对象
    metadata: {
    }
};

return result;
```
{: .copy-code}
