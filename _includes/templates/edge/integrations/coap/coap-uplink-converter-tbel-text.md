* Select the **"Create new"** tab and enter the **converter name**.
* Copy and insert the **TBEL Decoder function** script:

```javascript
/** Decoder **/

// decode payload to string
var strArray = decodeToString(payload);
var payloadArray = strArray.replaceAll("\"", "").split(',');

var telemetryPayload = {};
for (var i = 2; i < payloadArray.length; i = i + 2) {
    var telemetryKey = payloadArray[i];
    var telemetryValue = parseFloat(payloadArray[i + 1]);
    telemetryPayload[telemetryKey] = telemetryValue;
}

// Result object with device attributes/telemetry data
var result = {
    deviceName: payloadArray[0],
    deviceType: payloadArray[1],
    telemetry: telemetryPayload,
    attributes: {}
};

/** Helper functions 'decodeToString' and 'decodeToJson' are already built-in **/

return result;
``` 
{: .copy-code.expandable-8}

{% include images-gallery.html imageCollection="text-converter" %}
* After adding the uplink converter, click the **"Next"** button.

若需使用 JavaScript 开发转换函数，请使用 [适用于 JS 的 text payload 脚本](/docs/pe/edge/user-guide/resources/text-payload-converter.json){:target="_blank"}。