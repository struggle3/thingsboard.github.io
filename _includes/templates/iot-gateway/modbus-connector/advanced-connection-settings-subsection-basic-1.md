您可以配置其他设置，例如：TLS 连接、轮询时间、字节序和字序等。
下表描述了相关参数：

| **参数**                   | **默认值** | **描述**                                                               |
|:--------------------------------|:------------------|-------------------------------------------------------------------------------|
| 连接超时 (s)          | **35**            | 连接 Modbus 服务器的超时时间（秒）                            |
| 字节序                      | **LITTLE**        | 读取字节的顺序                                                        |
| 字序                      | **LITTLE**        | 读取多个寄存器时字的顺序                             |
| 重试                         | **true**          | 是否向主站重试发送数据。可选值：true 或 false  |
| 空值时重试                | **true**          | 主站返回空值时是否重试                            |
| 无效时重试              | **true**          | 主站返回失败时是否重试                           |
| 轮询周期 (ms)                | **5000**          | 检查从站属性和遥测的周期（毫秒） |
| 连接尝试时间 (ms)       | **5000**          | 连接主站前的等待时间（毫秒）              |
| 连接尝试次数           | **5**             | 通过 ThingsBoard 网关进行的连接尝试次数        |
| 失败尝试后等待 (ms) | **300000**        | 向主站发送数据前等待的时间（毫秒）     |
| ---                             |                   |                                                                               |

{% assign advancedConnectionSettings = '
    ===
        image: /images/gateway/modbus-connector/advanced-connection-settings-1-ce.png,
        title: 点击「**高级连接设置**」子部分将其打开；
    ===
        image: /images/gateway/modbus-connector/advanced-connection-settings-2-ce.png,
        title: 进行必要设置。
'
%}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=advancedConnectionSettings %}

此外，您还可以配置 TLS 连接（**仅用于 TCP/UDP 连接类型**）。下表描述了配置 TLS 连接所需的参数：

| **参数**                   | **描述**                                             |
|:--------------------------------|:------------------------------------------------------------|
| 客户端证书文件路径 | 网关文件系统中证书文件的路径         |
| 私钥文件路径        | 私钥文件路径                                    | 
| 密码                        | 服务器密码                                             |
| 服务器主机名                 | 服务器主机名（应与证书中的主机名匹配） | 
| ---                             |                                                             |

![image](/images/gateway/modbus-connector/tls-connection.png)
