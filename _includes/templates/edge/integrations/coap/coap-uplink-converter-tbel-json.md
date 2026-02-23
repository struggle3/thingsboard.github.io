* Select the **"Create new"** tab and enter the **converter name**.
* Copy and insert the **TBEL Decoder function** script:

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

/** Helper functions 'decodeToString' and 'decodeToJson' are already built-in **/

return result;
``` 
{: .copy-code.expandable-8}

{% include images-gallery.html imageCollection="json-converter" %}
* After adding the uplink converter, click the **"Next"** button.

若需使用 JavaScript 开发转换函数，请使用 [适用于 JS 的 JSON payload 脚本](/docs/pe/edge/user-guide/resources/json-payload-converter.json){:target="_blank"}。