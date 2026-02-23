{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

以管理员身份打开记事本或其他编辑器（右键点击应用图标并选择「以管理员身份运行」）。  
打开以下文件进行编辑（在文件选择对话框中选「所有文件」而非「文本文档」，编码为 UTF-8）：

```text 
C:\Program Files (x86)\tb-edge\conf\tb-edge.yml
``` 
{: .copy-code}

#### 数据库配置

在上一步的 "tb-edge.yml" 文件中找到 "# SQL DAO Configuration" 段落。  

请将 **YOUR_POSTGRES_PASSWORD_HERE** 替换为实际的 postgres 用户密码：

```yml
# SQL DAO Configuration
spring:
  data:
    jpa:
      repositories:
        enabled: "true"
  jpa:
    hibernate:
      ddl-auto: "none"
  datasource:
    driverClassName: "${SPRING_DRIVER_CLASS_NAME:org.postgresql.Driver}"
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/tb_edge}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:YOUR_POSTGRES_PASSWORD_HERE}"
``` 
#### 配置云端连接

{% include templates/edge/install/copy-edge-credentials.md %}

找到 "# Cloud configuration" 段落，将 **PUT_YOUR_EDGE_KEY_HERE** 和 **PUT_YOUR_EDGE_SECRET_HERE** 分别替换为 Edge 的 **key 和 secret**。  

将 **PUT_YOUR_CLOUD_IP** 替换为运行 {{appPrefix}} 的机器 IP 地址：
{% if docsPrefix == 'pe/edge/' %}
* 若 Edge 连接到 [**ThingsBoard Cloud**](https://thingsboard.cloud/signup)，请使用 **thingsboard.cloud**。

**注意：** **thingsboard.cloud** 在 Edge 通信中使用 SSL 协议。请同时将 **CLOUD_RPC_SSL_ENABLED** 设为 **true**。
{% endif %}
* Edge 与 cloud 实例在同一台机器上运行时使用 **localhost**。  
* Edge 连接同一网络或 Docker 内的 cloud 实例时使用 **X.X.X.X** IP 地址。

{% if docsPrefix == 'pe/edge/' %}
```yml
# Cloud configuration
cloud:
    routingKey: "${CLOUD_ROUTING_KEY:PUT_YOUR_EDGE_KEY_HERE}"
    secret: "${CLOUD_ROUTING_SECRET:PUT_YOUR_EDGE_SECRET_HERE}"
    rpc:
      host: "${CLOUD_RPC_HOST:PUT_YOUR_CLOUD_IP}"
      ssl:
        # 若使用 thingsboard.cloud 或已在 Server 上配置 TLS 连接，则设为 'true'；否则设为 'false'。
        enabled: "${CLOUD_RPC_SSL_ENABLED:true/false}" 
```
{% else %}
```yml
# Cloud configuration
cloud:
    routingKey: "${CLOUD_ROUTING_KEY:PUT_YOUR_EDGE_KEY_HERE}"
    secret: "${CLOUD_ROUTING_SECRET:PUT_YOUR_EDGE_SECRET_HERE}"
    rpc:
      host: "${CLOUD_RPC_HOST:PUT_YOUR_CLOUD_IP}"
```
{% endif %}

{% capture local-deployment %}
若 ThingsBoard Edge 与 **{{appPrefix}}** 服务器运行在同一台机器上，需调整以下配置参数以避免端口冲突。

请在 ThingsBoard Edge 配置文件（**C:\Program Files (x86)\tb-edge\conf\tb-edge.yml**）中定位并修改以下参数：
<br>
<br>**...**
<br>**port: "${HTTP_BIND_PORT:18080}"**
<br>**...**
<br>**bind_port: "${MQTT_BIND_PORT:11883}"**
<br>**...**
<br>**bind_port: "${COAP_BIND_PORT:15683}"**
<br>**...**
<br>**LWM2M_ENABLED: false**
<br>**...**
{% if docsPrefix == 'pe/edge/' %}
<br>**bind_port: "${INTEGRATIONS_RPC_PORT:19090}"**
<br>**...**
{% endif %}
确保以上端口（18080、11883、15683）未被其他应用占用。

{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}
