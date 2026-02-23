* Select the **"Create new"** tab and enter the **converter name**.
* Copy and insert the **TBEL Decoder function** script:

```javascript
/** Decoder **/

// decode payload to string
var payloadStr = decodeToString(payload);

// decode payload to JSON
// var data = decodeToJson(payload);

var deviceName = payloadStr.substring(0,6);
var deviceType = payloadStr.substring(6,13);

// Result object with device/asset attributes/telemetry data
var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    attributes: {},
    telemetry: {
        temperature: parseFloat(payloadStr.substring(13,17)),
        humidity: parseFloat(payloadStr.substring(17,19))
    }
};

/** Helper functions 'decodeToString' and 'decodeToJson' are already built-in **/

return result;
``` 
{: .copy-code.expandable-8}

{% include images-gallery.html imageCollection="binary-converter" %}

* After adding the uplink converter, click the **"Next"** button.

若需使用 **JavaScript** 开发转换函数，请使用 [适用于 JS 的 binary payload 脚本](/docs/pe/edge/user-guide/resources/binary-payload-converter.json){:target="_blank"}。