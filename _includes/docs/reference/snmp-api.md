
* TOC
{:toc}

## SNMP Basics

简单网络管理协议（SNMP）是一种互联网标准协议，用于从受管设备收集信息及向设备发送信息以修改其行为。

SNMP架构由SNMP管理器和SNMP代理组成。SNMP代理是运行在连接至网络的设备上的程序。SNMP代理将受管系统上的管理数据以变量形式暴露。通过SNMP可访问的变量按层次组织，这些层次由管理信息库（MIB）描述。MIB描述设备子系统的管理数据结构，使用包含对象标识符（OID）的层次命名空间。每个OID标识一个可通过SNMP读取或设置的变量。代理从MIB获取信息，在收到查询后交给SNMP管理器。SNMP管理器负责与所连SNMP代理通信，向代理发起查询、接收响应并设置代理变量。ThingsBoard SNMP传输充当管理器角色。管理器与代理之间通过消息和命令交互，传输使用的命令类型为"GET"和"SET"。每条SNMP消息包含一个协议数据单元（PDU）。

SNMP工作于互联网协议栈的应用层。SNMP消息可通过用户数据报协议（UDP）或传输控制协议（TCP）传输：可通过 `SNMP_UNDERLYING_PROTOCOL` 环境变量配置。

SNMP已发展并部署了三个重要版本。SNMP v1为协议原始版本，较新的SNMP v2c和SNMP v3在性能、灵活性和安全性上有所改进。ThingsBoard均支持。

## 设备配置设置

首先需配置SNMP设备配置：指定请求超时（确认请求重发或超时前的毫秒数）、重试次数（请求超时前的重试次数）及主要部分——通信配置。

设备配置示例：

{% include images-gallery.html imageCollection="deviceProfileConfiguring1" %}

配置类型将在查看SNMP设备配置后说明。

## 设备连接配置

无论SNMP设备版本如何，均需指定主机和端口。

就SNMP安全而言，SNMP v1和v2c以明文在网络中发送密码（community string），SNMP v3支持认证与数据加密。

因此，v1和v2c版本必须设置community string。此类SNMP设备的配置示例：

{% include images-gallery.html imageCollection="deviceConfiguring1" %}

继续说明SNMP第三版本。ThingsBoard使用"authPriv"安全级别，同时启用认证与加密。采用的安全模型为USM（基于用户的安全模型）。

SNMP v3设备需配置以下属性（除主机和端口外）：

- username
- security name
- context name
- authentication protocol（用于对认证口令进行哈希的哈希函数名称；支持SHA-1、SHA-224/256/384/512和MD5）
- authentication passphrase
- privacy protocol（数据加密算法；支持DES（CBC模式）及AES-128/192/256）
- privacy passphrase
- engine id

版本3配置示例：

{% include images-gallery.html imageCollection="deviceConfiguring2" %}

## Telemetry

如前所述，SNMP设备配置中需包含特定通信配置，遥测查询同样需要。此类配置需指定映射及查询频率。映射用于将OID的接收值按指定数据类型解析后映射到具体遥测键。

示例：

{% include images-gallery.html imageCollection="deviceProfileConfiguring2" %}

支持的数据类型为：`LONG`、`DOUBLE`、`BOOLEAN`和`STRING`（SNMP中配置为`JSON`的接收变量值将被视为普通字符串）。

此配置及其他查询配置使用的方法类型为`GET`。

## Attributes

### Client-side attributes

为配置SNMP设备属性查询，可添加另一通信配置。该配置与遥测配置相同，需包含映射及所需查询频率。

示例：

{% include images-gallery.html imageCollection="deviceProfileConfiguring3" %}

### Shared attributes

为使SNMP设备接收部分共享属性更新，可在SNMP设备配置中添加另一通信配置：

{% include images-gallery.html imageCollection="deviceProfileConfiguring4" %}

此配置只需配置映射：共享属性更新值将设置到哪个OID。映射中的键为共享属性名称。使用的SNMP方法为`SET`。

此类配置（以及使用`SET`类型SNMP方法的其他配置）需要数据类型以决定在PDU中发送何种SNMP变量类型。`LONG`数据类型使用`INTEGER`（或`Integer32`，有符号32位整数），其他数据类型使用`OCTET STRING`。

## 服务端RPC

要发送自定义SNMP请求，可使用RPC功能。首先，需在设备配置中配置若干键映射以供RPC命令使用：

{% include images-gallery.html imageCollection="deviceProfileConfiguring5" %}

配置完成后，即可在RPC命令中使用所配置映射的键：

```json
{
  "method": "GET",
  "params": {
    "key": "systemInfo"
  }
}
```

如您所见，"method"字段须指定SNMP方法类型：`GET`或`SET`。此例中会向OID "1.2.3.0.9.2.8.1"发送"GET" SNMP请求，将响应解析为字符串，再按以下格式路由至下一规则节点：

```json
{
  "systemInfo": "SNMP device"
}
```

"SET" RPC命令示例：

```json
{
  "method": "SET",
  "params": {
    "key": "lastUpdateTime",
    "value": "12901200312"
  }
}
```

此情况下将向映射中配置的OID（"1.2.3.0.6.4.3.1"）发送"SET" SNMP请求，值为"12901200312"的OCTET STRING。

注意："SET"请求须在RPC命令中指定值。

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
