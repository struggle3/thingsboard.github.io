_发送图片需将图片编码为Base64。可使用支持Base64编码的服务，并将结果字符串填入以下示例中的`encodedImage`。_

generator JS 代码示例
```js
var encodedImage = 'HERE_YOU_BASE_64_ENCODED_IMAGE';
var images = {
    "tb.example.png": encodedImage
};
var metadata = { 
    userEmail: 'info@thingsboard.org', 
    images: JSON.stringify(images), 
    isHtml: true 
};
var msgType = "POST_TELEMETRY_REQUEST";
return { msg: {}, metadata: metadata, msgType: msgType }
```
{% include images-gallery.html imageCollection="image_generator" %}
