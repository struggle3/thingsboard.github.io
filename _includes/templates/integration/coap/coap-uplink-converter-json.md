请将以下脚本复制并粘贴到 Decoder function 区域：

```javascript
/** Decoder **/

// decode payload to JSON
var data = decodeToJson(payload);

// Result object with device/asset attributes/telemetry data

var deviceName = data.deviceName;
var deviceType = data.deviceType;
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {},
   telemetry: {
       temperature: data.temperature,
       humidity: data.humidity
   }
};

/** Helper functions **/

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   // covert payload to string.
   var str = decodeToString(payload);

   // parse string to JSON
   var data = JSON.parse(str);
   return data;
}

return result;
``` 
{: .copy-code}


Decoder function 用于将入站数据和 metadata 解析为 ThingsBoard 可消费的格式。 
**deviceName** and **deviceType** are required, while **attributes** and **telemetry** are optional.
**attributes** and **telemetry** are flat key-value objects. Nested objects are not supported.