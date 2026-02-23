**CoAP** 是一种适用于受限设备的轻量级 IoT 协议。CoAP 基于 UDP，但类似 HTTP，采用请求-响应模型。
#### 订阅共享设备属性变更

要订阅共享设备属性变更，向以下 URL 发送 GET 请求：

```bash
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

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

执行命令：
```bash
coap get -o coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

一旦共享属性被服务端组件（REST API 或规则链）更改，客户端将收到更新。

#### 发布时序数据或属性消息

要向 **ThingsBoard Edge** 发布客户端设备属性，向以下 URL 发送 POST 请求：

```bash
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

* **$THINGSBOARD_HOST_NAME** 为 ThingsBoard Edge 实例的实际主机名或 IP 地址
* **$ACCESS_TOKEN** 为设备的实际访问令牌

使用 [**new-attributes-values.json**](/docs/reference/resources/new-attributes-values.json){: target="_blank"} 文件中的数据发布客户端属性更新：

```bash
cat new-attributes-values.json | coap post coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}
