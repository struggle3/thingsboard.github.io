
{% assign changeStateAndMode = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-0.png,
        title: 使用开关部件将 LED 设为常亮。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-1.png,
        title: 使用圆形开关部件将 LED 设为闪烁模式。
 '
 %}

可手动切换 LED 状态，并在常亮与闪烁模式间切换。
可使用仪表板中的以下部分：  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=changeStateAndMode %}
  
注意：仅在关闭闪烁模式时可更改 LED 状态。  

示例代码中实现了 [RPC 命令](/docs/{{page.docsPrefix}}user-guide/rpc/#server-side-rpc) 处理。  
实现设备控制使用了以下代码部分：  

- Connecting modules to use API functionality:  

```cpp
...
#include <Server_Side_RPC.h>
...
Server_Side_RPC<..., ...> rpc;
...

const std::array<IAPI_Implementation*, ...> apis = {
    ...
    &rpc,
    ...
    }
...
```
使用 RPC 需引入相关模块并将其作为所用 API 的一部分。  

- RPC 请求回调：  
    
```cpp
...

void processSetLedMode(const JsonVariantConst &data, JsonDocument &response) {
  Serial.println("Received the set led state RPC method");

  // Process data
  int new_mode = data;

  Serial.print("Mode to change: ");
  Serial.println(new_mode);
  StaticJsonDocument<1> response_doc;

  if (new_mode != 0 && new_mode != 1) {
    response_doc["error"] = "Unknown mode!";
    response.set(response_doc);
    return;
  }

  ledMode = new_mode;

  attributesChanged = true;


  response_doc["newMode"] = (int)ledMode;
  // Returning current mode
  response.set(response_doc);
}

...
{% if hasCamera == "true" %}
const std::array<RPC_Callback, 2U> callbacks = {
  RPC_Callback{ "setLedMode", processSetLedMode },
  RPC_Callback{ "takePicture", processTakePicture }
};
{% else %}
const std::array<RPC_Callback, 1U> callbacks = {
  RPC_Callback{ "setLedMode", processSetLedMode }
};
{% endif %}
...
```

- 订阅 RPC 请求：  
    
```cpp
...
    if (!rpc.RPC_Subscribe(callbacks.cbegin(), callbacks.cend())) {
      Serial.println("Failed to subscribe for RPC");
      return;
    }
...
```

{% if hasCamera == "true" %}

{% assign takePictureRPC = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-take-a-picture.png,
        title: 可通过按下 ThingsBoard 仪表板上的按钮从摄像头模块拍照。 
'
%}

开发板集成摄像头后，可拍照并在仪表板上查看。  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=takePictureRPC %}

通过向设备发送 "takePicture" RPC 实现拍照。   

以下代码用于拍照。

```cpp
...

bool captureImage() {
  camera_fb_t *fb = NULL;
  fb = esp_camera_fb_get();
  if (!fb) {
    return false;
  }
  encode((uint8_t *)fb->buf, fb->len);
  esp_camera_fb_return(fb);
  return true;
}
...
```

JSON 无法直接传递照片原始字节数组，故需将字节编码为 Base64：  

```cpp
...
void encode(const uint8_t *data, size_t length) {
  size_t size = base64_encode_expected_len(length) + 1;
  base64_encodestate _state;
  base64_init_encodestate(&_state);
  int len = base64_encode_block((char *)&data[0], length, &imageBuffer[0], &_state);
  len = base64_encode_blockend((imageBuffer + len), &_state);
}
...
```

编码后的图片在主循环中发送：  

```cpp
...
if (sendPicture) {
tb.sendTelemetryData(PICTURE_ATTR, imageBuffer);
sendPicture = false;
}
...
```

{% endif %}

可修改代码以实现您的目标，并添加自定义 RPC 命令处理。  


