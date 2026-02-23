{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-data-converters-1-tbel-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/data-converters-2-tbel-pe.png)
{% endif %}

**Uplink converter 示例：**

```ruby
// Decode an uplink message from a buffer
// payload - array of bytes
// metadata - key/value object

/** Decoder **/
 
// decode payload to string
// var payloadStr = decodeToString(payload);

// decode payload to JSON
var data = decodeToJson(payload);

var deviceName = data.deviceName;
var deviceType = data.deviceType;

// Result object with device attributes/telemetry data
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

/** Helper functions 'decodeToString' and 'decodeToJson' are already built-in **/

return result;
```
{: .copy-code}

可在创建 converter 时或创建后修改 decoder function。若 converter 已存在，点击「铅笔」图标进行编辑。
复制 converter 的配置示例（或您自己的配置）并插入到 decoder function 中。点击「勾选」图标保存更改。

{% include images-gallery.html imageCollection="converter-tbel" %}