请将以下脚本复制并粘贴到 Decoder 函数部分：

```javascript
/** Decoder **/

// 将 payload 解码为字符串
var payloadStr = decodeToString(payload);
var data = JSON.parse(payloadStr);

var deviceName =  metadata.topic.split("/")[3];
// 将 payload 解码为 JSON
var deviceType = 'sensor';

// 包含设备属性和遥测数据的结果对象
var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    attributes: {
        integrationName: metadata['integrationName'],
    },
    telemetry: {
        temperature: data.value,
    }
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
``` 
{: .copy-code}

![image](/images/pe/edge/integrations/mqtt/add-mqtt-integration-template-2-edge.png)