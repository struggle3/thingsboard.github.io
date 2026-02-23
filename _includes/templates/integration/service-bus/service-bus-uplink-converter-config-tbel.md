可使用以下代码，将其复制到 decoder function 区域：

```javascript
/** Decoder **/

// decode payload to string
var data = decodeToJson(payload);
var deviceName = data.devName;
var deviceType = 'thermostat';

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
        temperature: data.msg.temp,
        humidity: data.msg.humidity
    }
};

/** Helper functions 'decodeToString' and 'decodeToJson' are already built-in **/
return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-uplink-converter-tbel-1-pe.png)