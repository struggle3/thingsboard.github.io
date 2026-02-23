
```javascript
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - key/value 对象

/** 解码器 **/

// 将 payload 解码为 JSON
var data = decodeToJson(payload);

var deviceName = data.?bizData.?devId != null ? data.?bizData.?devId : data.?devId;
var deviceType = 'Tuya device';

var telemetry = [];
if (data.status != null) {
    for (var i = 0; i < data.status.length; i++) {
        var res = {};
        var code = data.status[i].code;
        var value = data.status[i].value;
        if (code == "cur_voltage" || code == "cur_power") {
            value = data.status[i].value / 10;
        } else if (code == "cur_current") {
            value = data.status[i].value / 100;
        }
        res[code] = value;
        telemetry.push(res);
    }

} else {
    telemetry = data;
}

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    attributes: {},
    telemetry: telemetry,
    deviceName: deviceName,
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
```
{:.copy-code.expandable-15}