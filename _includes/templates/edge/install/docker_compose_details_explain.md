{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

说明：    
- **restart: always：** 系统重启或故障后 ThingsBoard Edge 将自动启动。
- **8080:8080：** 将本地端口 8080 映射到容器内部 HTTP 端口 8080。
- **1883:1883：** 将本地端口 1883 映射到容器内部 MQTT 端口 1883。
- **5683-5688:5683-5688/udp：** 将本地 UDP 端口 5683–5688 映射到容器内部 CoAP 与 LwM2M 端口。
{% if docsPrefix == 'pe/edge/' %}
- **thingsboard/tb-edge-pe:{{ site.release.pe_edge_full_ver }}：** ThingsBoard Edge PE Docker 镜像。
{% else %}
- **thingsboard/tb-edge:{{ site.release.edge_full_ver }}：** ThingsBoard Edge Docker 镜像。
{% endif %}
- **CLOUD_ROUTING_KEY：** 填入实际的 Edge key。
- **CLOUD_ROUTING_SECRET：** 填入实际的 Edge secret。
- **CLOUD_RPC_HOST：** 运行 ThingsBoard 平台的机器 IP 地址或主机名。
{% if docsPrefix == 'pe/edge/' %}
- **CLOUD_RPC_SSL_ENABLED：** 定义 Edge 与 ThingsBoard 服务器间连接是否使用 SSL。_true_ 启用，_false_ 禁用。
{% endif %}

{% capture cloud_rpc_host %}
请将 **CLOUD_RPC_HOST** 设为运行 {{appPrefix}} 的机器 IP 地址：
* 切勿使用 **'localhost'**——在 Docker 容器内 **'localhost'** 指 Edge 服务自身地址。
{% if docsPrefix == 'pe/edge/' %}
* 若将 Edge 连接到 [**ThingsBoard Cloud**](https://thingsboard.cloud/signup){: target="_blank"}，请使用 **thingsboard.cloud**。

**注意：** **thingsboard.cloud** 在 Edge 通信中使用 SSL。请将 **CLOUD_RPC_SSL_ENABLED** 改为 **true**。
{% endif %}
* Edge 连接同一网络或 Docker 环境中的 Cloud 实例时，使用 **X.X.X.X** IP 地址。

{% endcapture %}
{% include templates/info-banner.md content=cloud_rpc_host %}

{% capture local-deployment %}
若 **ThingsBoard Edge** 与 **{{appPrefix}}** 服务器运行在 **同一台机器** 上，需修改端口配置以避免端口冲突。

请确保端口 **18080、11883、15683-15688** 未被其他应用占用。

{% endcapture %}

{% include templates/info-banner.md content=local-deployment %}

要更新 **docker-compose.yml** 中的端口配置，请执行：

```bash
sed -i 's/8080:8080/18080:8080/; s/1883:1883/11883:1883/; s/5683-5688:5683-5688\/udp/15683-15688:5683-5688\/udp/' docker-compose.yml
```
{: .copy-code}


