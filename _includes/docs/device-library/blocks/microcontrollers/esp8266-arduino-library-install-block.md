
{% assign installESP8266='
    ===
        image: /images/devices-library/basic/microcontrollers/esp8266-arduino-ide-board-manager.png,
        title: 在搜索框中输入 ESP8266 并安装 Espressif Community 的 esp8266。
' %}

为 Arduino IDE 安装开发板：

Go to **File** > **Preferences** and add the following URL to the Additional Boards Manager URLs field.  

```bash 
http://arduino.esp8266.com/stable/package_esp8266com_index.json
```
{:.copy-code}

{% assign esp8266ArduinoPreferences='
    ===
        image: /images/devices-library/basic/arduino-ide/preferences.png
'%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=esp8266ArduinoPreferences %}

然后进入 **Tools** > **Board** > **Board Manager** 并安装 ***ESP8266*** 开发板。  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=installESP8266 %}

安装完成后，通过 **工具** > **开发板** > {{ arduinoBoardPath }} 选择开发板。  

用 USB 线连接设备与电脑，并在 **工具** > **端口** > **/dev/ttyUSB0** 中选择设备端口。  

端口随操作系统不同而不同：  
- Linux 下为 **/dev/ttyUSB**X  
- MacOS 下为 **usb.serial**X.. 或 **usb.modem**X..  
- Windows 下为 **COM**X。  

{% assign mbedtlsInstallationRequired="true" %}