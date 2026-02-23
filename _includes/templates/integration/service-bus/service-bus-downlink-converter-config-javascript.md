您可以使用我们的下行转换器示例，或根据您的配置编写自己的转换器：

```javascript
// 将传入的规则引擎消息编码为下行数据
// msg - 下行消息的 JSON 消息 payload
// 包含编码后下行 payload 的结果对象
var result = {
    contentType: "JSON",
    data: JSON.stringify(msg),
    metadata: {
        deviceId: 'Sensor A1'
    }
};

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-downlink-converter-java-1-pe.png)