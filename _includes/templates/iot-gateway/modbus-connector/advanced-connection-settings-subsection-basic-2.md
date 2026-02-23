您可以配置其他设置，例如：TLS 连接、字节序、字序等。以下参数用于配置高级连接设置：

- **字节序** - Modbus 连接的字节序，可选 **LITTLE** 或 **BIG**。
- **字序** - Modbus 连接的字序，可选 **LITTLE** 或 **BIG**。
- **厂商名称** - Modbus 连接的厂商名称。
- **产品代码** - Modbus 连接的产品代码。
- **厂商 URL** - Modbus 连接的厂商 URL。
- **产品名称** - Modbus 连接的产品名称。
- **型号名称** - Modbus 连接的型号名称。
- **TLS** - 启用或禁用 Modbus 连接的 TLS（**仅用于 TCP 和 UDP 连接**）：
  - **客户端证书路径** - 客户端证书文件路径。
  - **客户端私钥路径** - 客户端私钥文件路径。
  - **密码** - 客户端私钥文件密码。

{% capture difference %}
所有配置参数列表及详细说明请参阅 
[高级配置](/docs/iot-gateway/config/modbus/#device-rpc-methods) 章节。

更多使用示例请参阅 [示例用法](/docs/iot-gateway/config/modbus/#usage-examples-2) 章节。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

配置高级连接设置的步骤：

{% assign advancedConnectionSettingsBasic = '
    ===
        image: /images/gateway/modbus-connector/advanced-connection-settings-basic-1-ce.png,
        title: 点击「**高级连接设置**」子部分将其打开；
    ===
        image: /images/gateway/modbus-connector/advanced-connection-settings-basic-2-ce.png,
        title: 进行必要设置。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=advancedConnectionSettingsBasic %}
