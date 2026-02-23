**MQTT** 是一种轻量级协议，常用于 IoT 通信。

要与 **ThingsBoard Edge** 通过 **MQTT** 通信，建议安装 [MQTT Broker](/docs/{{peDocsPrefix}}reference/mqtt-api/?connectdevice=mqtt-linux#mqtt-connect){: target="_blank"}。这样设备即可 **发布** 遥测或属性消息，并 **订阅** 属性更新主题。

#### 订阅共享设备属性变更

要订阅共享设备属性变更，发送 SUBSCRIBE 消息：
```bash
mosquitto_sub -d -h$THINGSBOARD_HOST_NAME-t "v1/devices/me/attributes" -u "$ACCESS_TOKEN"
```
{: .copy-code}

* **v1/devices/me/attributes** ThingsBoard Edge 上的主题，用于设备监听来自云端与其属性相关的任何更新。
* 将 **$THINGSBOARD_HOST_NAME** 替换为 ThingsBoard Edge 实例的实际主机名或 IP 地址。
    
{% assign accessTokenPE = '
  ===
    image: /images/pe/edge/config/subscribe-to-attribute/9-copy-access-token-pe.webp,
    title: 将 **$ACCESS_TOKEN** 替换为设备的实际访问令牌。要查找设备访问令牌，请进入 **实体 > 设备** 部分并点击该设备。在 **「设备详情」** 页面，点击 **「复制访问令牌」** 按钮即可复制令牌。
'
%}

{% assign accessTokenCE = '
  ===
    image: /images/edge/config/subscribe-to-attribute/9-copy-access-token.webp,
    title: 将 **$ACCESS_TOKEN** 替换为设备的实际访问令牌。要查找设备访问令牌，请进入 **实体 > 设备** 部分并点击该设备。在 **「设备详情」** 页面，点击 **「复制访问令牌」** 按钮即可复制令牌。
'
%}

{% if docsPrefix contains "pe/edge" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=accessTokenPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="true" imageCollection=accessTokenCE %}
{% endif %}

#### 发布时序数据或属性消息

要向 **ThingsBoard Edge** 发布客户端设备属性，发送 PUBLISH 消息。

可发布遥测数据：

```bash
mosquitto_pub -d -h$THINGSBOARD_HOST_NAME-t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -m "{"attribute1": "value1", "attribute2": true}"
```
{: .copy-code}

* **v1/devices/me/attributes** 遥测数据发布到的主题。
* **$THINGSBOARD_HOST_NAME** ThingsBoard Edge 实例的实际主机名或 IP 地址
* **$ACCESS_TOKEN** 设备的实际访问令牌
* **{"attribute1": "value1", "attribute2": true}** 遥测数据

也可使用 [**new-attributes-values.json**](/docs/reference/resources/new-attributes-values.json){: target="_blank"} 文件中的数据发布客户端属性更新：

```bash
mosquitto_pub -d -h$THINGSBOARD_HOST_NAME-t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -f "new-attributes-values.json"
```
{: .copy-code}
