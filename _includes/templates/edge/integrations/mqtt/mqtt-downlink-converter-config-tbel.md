请将以下脚本复制并粘贴到 Encoder 函数部分：

```javascript
/** Encoder **/

// 编码后的下行 payload 结果对象
var result = {

        // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
        contentType: "JSON",

        // 下行数据
        data: JSON.stringify(msg),

        // 可选的元数据对象，以键/值格式呈现
        metadata: {
            topic: 'tb-edge/mqtt-integration-tutorial/sensors/'+metadata['originatorName']+'/rx'
        }
    };

return result;
``` 
{: .copy-code}

![image](/images/pe/edge/integrations/mqtt/add-mqtt-integration-template-3-edge.png)