```js
/** 编码器 **/

var value = parseInt(msg.params.replace(/"/g,""));
var data = {value: value};
// 包含编码下行负载的结果对象
var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(data),

    // 以键/值格式呈现的可选元数据对象
    metadata: {
        topic: 'tb/mqtt-integration-tutorial/sensors/'+metadata['deviceName']+'/rx'
    }

};

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/mqtt/mqtt-integration-edit-downlink-converter-java-1-pe.png)
