**HTTP** 是一种通用网络协议，可用于 IoT 应用。HTTP 协议基于 TCP，采用请求-响应模型。

#### 订阅共享设备属性变更

要订阅共享设备属性的变更，向以下 URL 发送 GET 请求，可带可选参数 `timeout`：

```bash
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes/updates
```
{: .copy-code}

* **/attributes/updates** 用于获取设备属性更新的端点。
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
curl -v -X GET http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes/updates?timeout=20000
```
{: .copy-code}

* **timeout=20000** 服务器将保持连接 20 秒。若在此超时时间内设备的 **shared attribute**（共享属性）被更新，服务器将立即返回更新结果。

#### 发布时序数据或属性消息

要向 ThingsBoard Edge 发布客户端设备属性，向以下 URL 发送 POST 请求：

```bash
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

* **$THINGSBOARD_HOST_NAME** 为 ThingsBoard Edge 实例的实际主机名或 IP 地址
* **$ACCESS_TOKEN** 为设备的实际访问令牌

发布客户端属性更新：

```bash
curl -v -X POST --data "{"attribute1": "value1", "attribute2":true, "attribute3": 43.0}" https:/$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes --header "Content-Type:application/json"
```

也可使用 [**new-attributes-values.json**](/docs/reference/resources/new-attributes-values.json){: target="_blank"} 文件中的数据发布客户端属性更新：

```bash
curl -v -X POST -d @new-attributes-values.json https://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes --header "Content-Type:application/json"
```
{: .copy-code}
