
还可通过[共享属性](/docs/{{page.docsPrefix}}user-guide/attributes/#shared-attributes)更新功能修改闪烁周期。    

{% assign updateLedBlinkingPeriod = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-1.png,
        title: 修改闪烁周期只需在仪表板上更改数值即可。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-blinking-interval-change.png,
        title: 按勾选图标应用后，将显示确认消息。
'
%} 

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateLedBlinkingPeriod %}

{% assign updateLedState= '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-0.png,
        title: 仅当关闭闪烁模式时方可操作。
'
%}

在关闭闪烁时改变状态，可使用同一部件中的开关：  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateLedState %}

{% if boardLedCount == 0 %}

该开发板无内置可控 LED 指示灯。  
可通过串口监视器（**工具** -> **串口监视器**）检查共享属性变更结果，波特率选择 115200。  

{% endif %}

实现该功能使用变量 "blinkingInterval"，出现在以下代码中：  

- Connecting modules to use API functionality:  
```cpp
...
#include <AttributeRequest.h>
...
Attribute_Request<2U, MAX_ATTRIBUTES> attr_request;
...
const std::array<IAPI_Implementation*, ...> apis = {
    ...
    &shared_update
    ...
};
...
```
使用属性请求功能需引入相关模块并将其作为所用 API 的一部分。

- 共享属性更新回调：  
    
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

...
// Attribute request did not receive a response in the expected amount of microseconds 
void requestTimedOut() {
  Serial.printf("Attribute request timed out did not receive a response in (%llu) microseconds. Ensure client is connected to the MQTT broker and that the keys actually exist on the target device\n", REQUEST_TIMEOUT_MICROSECONDS);
}
...
const Attribute_Request_Callback<MAX_ATTRIBUTES> attribute_shared_request_callback(&processSharedAttributes, REQUEST_TIMEOUT_MICROSECONDS, &requestTimedOut, SHARED_ATTRIBUTES_LIST);
...
```

- 订阅共享属性更新：  
    
```cpp
...
    if (!shared_update.Shared_Attributes_Request(attribute_shared_request_callback)) {
      Serial.println("Failed to request for shared attributes");
      return;
    }
...
```

- 闪烁相关代码：  
    
```cpp
...

  if (ledMode == 1 && millis() - previousStateChange > blinkingInterval) {
    previousStateChange = millis();
    ledState = !ledState;
    digitalWrite(LED_BUILTIN, ledState);
    tb.sendTelemetryData(LED_STATE_ATTR, ledState);
    tb.sendAttributeData(LED_STATE_ATTR, ledState);
    if (LED_BUILTIN == 99) {
      Serial.print("LED state changed to: ");
      Serial.println(ledState);
    }
  }
...
```

{% if boardLedCount == 3 %}

{% assign updateLedColor = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-led-color.png,
        title: 可通过 ThingsBoard 仪表板上的部件更新开发板 LED 颜色。 
'
%}

开发板集成 RGB LED，可控制其颜色。  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateLedColor %}

通过修改共享属性 "ledColor" 控制 LED，其值为 "R,G,B" 格式的 RGB 字符串。

以下代码用于解析接收到的值并保存：

```cpp
...
if (strcmp(it->key().c_str(), LED_COLOR_ATTR) == 0) {
  std::string data = it->value().as<std::string>();
  Serial.print("Updated colors: ");
  Serial.println(data.c_str());
  int i = 0;
  bool end = false;
  while (data.length() > 0) {
    int index = data.find(',');
    if (index == -1) {
      end = true;
      index = data.length();
    }
    switch (i) {
      case 0:
        redColor = map(atoi(data.substr(0, index).c_str()), 0, 255, 255, 0);
        break;
      case 1:
        greenColor = map(atoi(data.substr(0, index).c_str()), 0, 255, 255, 0);
        break;
      case 2:
        blueColor = map(atoi(data.substr(0, index).c_str()), 0, 255, 255, 0);
        break;
      default:
        break;
    }
    i++;
    if (end) {
      break;
    } else {
      data = data.substr(index + 1);
    }
  }
  setLedColor();
}
...
```

以下函数用于设置 LED 颜色：  

```cpp
...
void setLedColor() {
  if (redColor < 255 && ledState) {
    analogWrite(LEDR, redColor);
  } else {
    pinMode(LEDR, OUTPUT);
    digitalWrite(LEDR, LOW);
  }
  if (greenColor < 255 && ledState) {
    analogWrite(LEDG, greenColor);
  } else {
    pinMode(LEDG, OUTPUT);
    digitalWrite(LEDG, LOW);
  }
  if (blueColor < 255 && ledState) {
    analogWrite(LEDB, blueColor);
  } else {
    pinMode(LEDB, OUTPUT);
    digitalWrite(LEDB, LOW);
  }
}
...
```

{% endif %}

{% if OLEDInstallationRequired == "true" %}

{% assign updateTextOnDisplay = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-update-oled-screen.png,
        title: 在输入框中输入文本并应用更改，文本将显示在上方区域。
'
%}

还可更改显示屏上的文本，可修改共享属性 **screenText** 或使用示例仪表板。  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateTextOnDisplay %}

可使用以下特殊符号：  
- **\n** - 换行  
- **\t** - 四个空格  

连接 OLED 显示屏使用以下代码（I2C 连接至开发板引脚 **5** 和 **4**）：  

```cpp
...
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);
...
Wire.begin(5, 4);
if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C, false, false)) { 
    Serial.println("Cannot initialize screen!");
}
...
```

处理接收文本及特殊符号使用以下代码：  
```cpp
...
if (strcmp(it->key().c_str(), SCREEN_TEXT_ATTR) == 0) {
    screenText = String(it->value().as<const char*>());
    screenText.replace("\\n", "\n");
    screenText.replace("\\t", "    ");
    screenTextUpdated = true;
}
...
```

在显示屏上显示接收文本使用以下代码：  
```cpp
...

  if (screenTextUpdated) {
    screenTextUpdated = false;
    display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(SSD1306_WHITE);
    display.setCursor(0, 0);
    display.println(screenText);
    display.display();
    Serial.println("Screen updated!");
  }
...
```

{% endif %}

可修改逻辑以实现目标，并添加自定义属性处理。  
