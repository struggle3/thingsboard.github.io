为在启动时从 ThingsBoard 获取设备状态，代码中实现了相应[功能](/docs/{{page.docsPrefix}}reference/mqtt-api/#request-attribute-values-from-the-server)。  

以下为示例代码的相关部分：  

- 引入模块以使用 API 功能：  
```cpp
...
#include <AttributeRequest.h>
...
Attribute_Request<2U, MAX_ATTRIBUTES> attr_request;
...
const std::array<IAPI_Implementation*, ...> apis = {
    ...
    &attr_request,
    ...
};
...
```
需在代码中定义要使用的 API。

- 属性回调：  
    
```cpp
...
void processSharedAttributes(const JsonObjectConst &data) {
  for (auto it = data.begin(); it != data.end(); ++it) {
    if (strcmp(it->key().c_str(), BLINKING_INTERVAL_ATTR) == 0) {
      const uint16_t new_interval = it->value().as<uint16_t>();
      if (new_interval >= BLINKING_INTERVAL_MS_MIN && new_interval <= BLINKING_INTERVAL_MS_MAX) {
        blinkingInterval = new_interval;
        Serial.print("Updated blinking interval to: ");
        Serial.println(new_interval);
      }
    } else if(strcmp(it->key().c_str(), LED_STATE_ATTR) == 0) {
      ledState = it->value().as<bool>();
      digitalWrite(LED_BUILTIN, ledState ? HIGH : LOW);
      Serial.print("Updated state to: ");
      Serial.println(ledState);
    }
  }
  attributesChanged = true;
}

void processClientAttributes(const JsonObjectConst &data) {
  for (auto it = data.begin(); it != data.end(); ++it) {
    if (strcmp(it->key().c_str(), LED_MODE_ATTR) == 0) {
      const uint16_t new_mode = it->value().as<uint16_t>();
      ledMode = new_mode;
    }
  }
}
...
// Attribute request did not receive a response in the expected amount of microseconds 
void requestTimedOut() {
  Serial.printf("Attribute request timed out did not receive a response in (%llu) microseconds. Ensure client is connected to the MQTT broker and that the keys actually exist on the target device\n", REQUEST_TIMEOUT_MICROSECONDS);
}
...
const Attribute_Request_Callback<MAX_ATTRIBUTES> attribute_shared_request_callback(&processSharedAttributes, REQUEST_TIMEOUT_MICROSECONDS, &requestTimedOut, SHARED_ATTRIBUTES_LIST);
const Attribute_Request_Callback<MAX_ATTRIBUTES> attribute_client_request_callback(&processClientAttributes, REQUEST_TIMEOUT_MICROSECONDS, &requestTimedOut, CLIENT_ATTRIBUTES_LIST);
...
```

共有三个回调：
* 共享属性回调：专用于共享属性，主要接收包含闪烁间隔的响应，以确定合适的闪烁周期；
* 客户端属性回调：专用于客户端属性，接收 LED 模式与状态信息，收到后保存并应用这些参数；
* 请求超时回调：在属性数据请求超时时触发，用于处理超时。

此功能使设备在重启后能保持实际状态。  

- 属性请求：    
```cpp
...
    // Request current states of shared attributes
    if (!attr_request.Shared_Attributes_Request(attribute_shared_request_callback)) {
      Serial.println("Failed to request for shared attributes");
      return;
    }

    // Request current states of client attributes
    if (!attr_request.Client_Attributes_Request(attribute_client_request_callback)) {
      Serial.println("Failed to request for client attributes");
      return;
    }
...
``` 
为使回调能接收数据，需向 ThingsBoard 发送请求。  