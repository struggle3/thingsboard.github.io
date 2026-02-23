{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-downlink-tbel-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-tbel-1-pe.png)
{% endif %}

<br>
向 integration 添加 converter。可根据您的配置自定义 downlink。
Let’s consider an example where we send an attribute update message. So we should change code in the downlink encoder function under line **//downlink data** input:

```ruby
data: JSON.stringify(msg)
```
{: .copy-code}
where **msg** is the message that we receive and send back to the device.

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-downlink-tbel-2-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-tbel-2-pe.png)
{% endif %}

<br>
Downlink converter 示例：

```ruby
// Encode downlink data from incoming Rule Engine message

// msg - JSON message payload downlink message json
// msgType - type of message, for ex. 'ATTRIBUTES_UPDATED', 'POST_TELEMETRY_REQUEST', etc.
// metadata - list of key-value pairs with additional data about the message
// integrationMetadata - list of key-value pairs with additional data defined in Integration executing this converter

var result = {

    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "JSON",

    // downlink data
    data: JSON.stringify(msg),

    // Optional metadata object presented in key/value format
    metadata: {
    }
};

return result;
```
{: .copy-code}
