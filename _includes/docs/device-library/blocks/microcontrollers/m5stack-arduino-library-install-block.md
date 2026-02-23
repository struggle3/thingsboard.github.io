
为 Arduino IDE 安装开发板：

进入 **文件** > **首选项**，将以下 URL 添加到 **附加开发板管理器网址** 字段。  

```bash 
https://m5stack.oss-cn-shenzhen.aliyuncs.com/resource/arduino/package_m5stack_index.json
```
{:.copy-code}

{% assign esp32ArduinoPreferences='
    ===
        image: /images/devices-library/basic/arduino-ide/preferences.png
'%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=esp32ArduinoPreferences %}

然后进入 **工具** > **开发板** > **开发板管理器** 并安装 ***M5Stack by M5Stack Official*** 开发板。  

{% assign m5StackBoardManager='
    ===
        image: /images/devices-library/basic/microcontrollers/m5stack-arduino-ide-board-manager.png
'%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=m5StackBoardManager %}

安装完成后，通过 **工具** > **开发板** > {{ arduinoBoardPath }} 选择开发板。  

用 USB 线连接设备与电脑，并在 **工具** > **端口** > **/dev/ttyUSB0** 中选择设备端口。  

端口随操作系统不同而不同：  
- Linux 下为 **/dev/ttyUSB**X  
- MacOS 下为 **usb.serial**X.. 或 **usb.modem**X..  
- Windows 下为 **COM**X。  
