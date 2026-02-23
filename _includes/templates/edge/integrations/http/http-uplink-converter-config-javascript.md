复制以下脚本：

```ruby
// 从 buffer 解码上行消息
// payload - 字节数组
// metadata - 键/值对象

/** Decoder **/

// 将 payload 解码为字符串
// var payloadStr = decodeToString(payload);

// 将 payload 解码为 JSON
var data = decodeToJson(payload);

var deviceName = data.deviceName;
var deviceType = data.deviceType;

// 包含设备属性/遥测数据的结果对象
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
       model: data.model,
       serialNumber: data.param2,
   },
   telemetry: {
       temperature: data.temperature
   }
};

/** 辅助函数 **/

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}
function decodeToJson(payload) {
   // 将 payload 转换为字符串
   var str = decodeToString(payload);
   // 将字符串解析为 JSON
   var data = JSON.parse(str);
   return data;
}

return result;
```
{: .copy-code}

选择「Create new」并将复制的代码粘贴到 Decoder 函数部分。点击「Next」；

![image](/images/pe/edge/integrations/http/add-http-integration-template-2-java-edge.png)