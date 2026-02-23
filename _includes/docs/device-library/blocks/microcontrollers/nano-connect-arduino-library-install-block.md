
为 Arduino IDE 安装开发板： 

{% assign raspberryPiPicoInstallation = '
    ===
        image: /images/devices-library/basic/microcontrollers/nano-connect-arduino-ide-board-manager.png
        title: 进入 **工具** > **开发板** > **开发板管理器** 并安装 ***Arduino Mbed OS RP2040 Boards by Arduino*** 开发板。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=raspberryPiPicoInstallation %}

安装完成后，通过 **工具** > **开发板** > {{ arduinoBoardPath }} 选择开发板。  

用 USB 线连接设备与电脑，并在 **工具** > **端口** > **/dev/ttyUSB0** 中选择设备端口。  

端口随操作系统不同而不同：  
- Linux 下为 **/dev/ttyUSB**X  
- MacOS 下为 **usb.serial**X.. 或 **usb.modem**X..  
- Windows 下为 **COM**X。  

{% assign wifininaInstallationRequired = "true" %}
