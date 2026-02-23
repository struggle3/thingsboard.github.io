安装 ThingsBoard Arduino SDK 需执行以下步骤：  

{% assign libraryInstallation = '
    ===
        image: /images/devices-library/basic/arduino-ide/tools-manage-libraries.png
        title: 进入 **工具** 选项卡，点击 **管理库**。
    ===
        image: /images/devices-library/basic/arduino-ide/manage-libraries-thingsboard.png
        title: 在搜索框中输入 **ThingsBoard** 并点击找到的库的 **安装** 按钮。
' 
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=libraryInstallation %}    

{% capture libraryVersion %}

所有示例代码均需 ThingsBoard 库版本 {% if wifininaInstallationRequired == "true" %}**0.10.2**{% else %}**0.14.0**{% endif %}.  

{% endcapture %}

{% include templates/warn-banner.md content=libraryVersion %}

{% if mbedtlsInstallationRequired == "true" %}

基于 ESP8266 或 RP2040 芯片的开发板还需安装 "mbedtls" 和 "arduino-timer" 库。  

{% assign mbedtlsInstallation='
    ===
        image: /images/devices-library/basic/arduino-ide/install-mbedtls.png,
        title: 在库搜索框中输入 **mbedtls** 并安装 **Seeed_Arduino_mbedtls by Peter Yang** 库
    ===
        image: /images/devices-library/basic/arduino-ide/install-arduino-timer.png,
        title: 在库搜索框中输入 **arduino-timer** 并安装 **arduino-timer by Michael Contreras** 库
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=mbedtlsInstallation %}

{% endif %}

{% if OLEDInstallationRequired == "true" %}

控制显示屏还需安装 Adafruit SSD1306 库。  

{% assign oledInstallation='
    ===
        image: /images/devices-library/basic/arduino-ide/install-adafruit-ssd1306.png,
        title: 在库搜索框中输入 **Adafruit SSD1306** 并安装 **Adafruit SSD1306 by Adafruit** 库
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=oledInstallation %}

{% endif %}

{% if wifininaInstallationRequired == "true" %}

基于 RP2040 芯片的开发板还需安装 "WiFiNINA" 库。  

{% assign wifininaInstallation='
    ===
        image: /images/devices-library/basic/arduino-ide/install-wifinina.png,
        title: 在库搜索框中输入 **WiFiNINA** 并安装 **WiFiNINA by Arduino** 库
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=wifininaInstallation %}

{% endif %}

至此已安装全部所需库与工具。  