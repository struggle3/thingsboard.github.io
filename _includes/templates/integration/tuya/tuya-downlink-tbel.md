```javascript
/** 编码器 **/

var command = {};
command["code"] = msg.method;
if (msg.params == "false" || msg.params == "true") {
    command["value"] = Boolean.valueOf(msg.params);
} else {
    command["value"] = msg.params;
}

var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(command),

    // 可选的 key/value 格式元数据对象
    metadata: {
        deviceId: metadata.deviceName
    }

};

return result;
```
{: .copy-code}