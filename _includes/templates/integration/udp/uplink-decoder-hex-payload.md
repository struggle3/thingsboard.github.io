{% include templates/tbel-vs-js.md %}

请复制以下 **TBEL** 脚本：

```javascript
/** Decoder **/

// decode payload to JSON
var data = decodeToJson(payload).reports[0].value;

// Result object with device telemetry data
var result = {
    deviceName: hexToString(data.substring(0, 12)),
    deviceType: hexToString(data.substring(12, 26)),
    telemetry: {
        temperature: parseFloat(hexToString(data.substring(26, 34))),
        humidity: parseFloat(hexToString(data.substring(34, 38))),
    }
};

/** Helper functions **/

// Hexadecimal string to string
function hexToString(hex) {
    return bytesToString(hexToBytes(hex));
}

return result;
``` 
{:.copy-code.expandable-15}

<br>
若使用 **JavaScript decoder function**，请使用以下脚本：

```javascript
/** Decoder **/

// decode payload to JSON
var data = decodeToJson(payload).reports[0].value;

// Result object with device telemetry data
var result = {
    deviceName: hexToString(data.substring(0, 12)),
    deviceType: hexToString(data.substring(12, 26)),
    telemetry: {
        temperature: parseFloat(hexToString(data.substring(26, 34))),
        humidity: parseFloat(hexToString(data.substring(34, 38))),
    }
};

/** Helper functions **/

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

// Hexadecimal string to string
function hexToString(hex) {
    var str = '';
    for (var i = 0; i < hex.length; i += 2) {
        var notNullValue = parseInt(hex.substr(i, 2), 16);
        if (notNullValue) {
            str += String.fromCharCode(notNullValue);
        }
    }
    return str;
}

function decodeToJson(payload) {
    // convert payload to string.
    var str = decodeToString(payload);

    // parse string to JSON
    var data = JSON.parse(str);
    return data;
}

return result;
``` 
{:.copy-code.expandable-10}

<br>
将复制的脚本粘贴到 decoder function 区域，然后点击「**Next**」；

![image](/images/user-guide/integrations/udp/udp-integration-setup-2-hex-tbel-pe.png)

{% capture difference %}
**NOTE**
<br>
Debug 模式对开发和故障排查很有用，但在生产环境中启用会显著增加数据库占用的磁盘空间，因为所有调试数据都会存储其中。强烈建议调试完成后关闭 Debug 模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
