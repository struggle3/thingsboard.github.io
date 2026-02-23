{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{% include templates/edge/install/copy-edge-credentials.md %}

编辑 **ThingsBoard Edge** 配置文件。

{% if docsPrefix == 'pe/edge/' %}

{% capture tabspec %}tb-edge-install-ubuntu
tb-edge-install-ubuntu-cloud,<div style="text-align:center;">Cloud<br>(North America)</div>,shell,resources/tb-edge-ubuntu-install-usa-cloud.sh,/docs/user-guide/install/pe/edge/resources/tb-edge-ubuntu-install-usa-cloud.sh
tb-edge-install-ubuntu-cloud-eu,<div style="text-align:center;">Cloud<br>(Europe)</div>,shell,resources/tb-edge-ubuntu-install-eu-cloud.sh,/docs/user-guide/install/pe/edge/resources/tb-edge-ubuntu-install-eu-cloud.sh
tb-edge-install-ubuntu-onprem,<div style="text-align:center;">On-Premise<br>(Local host)</div>,shell,resources/tb-edge-ubuntu-install-onprem.sh,/docs/user-guide/install/pe/edge/resources/tb-edge-ubuntu-install-onprem.sh{% endcapture %}
{% include tabs.html %}

{% else %}

```bash
sudo sh -c 'cat <<EOL >> /etc/tb-edge/conf/tb-edge.conf
export CLOUD_ROUTING_KEY=<PUT_YOUR_EDGE_KEY_HERE>
export CLOUD_ROUTING_SECRET=<PUT_YOUR_EDGE_SECRET_HERE>
export CLOUD_RPC_HOST=<PUT_YOUR_RPC_HOST>
export CLOUD_RPC_PORT=7070
export CLOUD_RPC_SSL_ENABLED=false
export HTTP_BIND_PORT=18080
export MQTT_BIND_PORT=11883
export COAP_BIND_PORT=15683
export LWM2M_ENABLED=false
export SNMP_ENABLED=false
EOL'
```

{% endif %}

* **PUT_YOUR_EDGE_KEY_HERE：** 替换为 **实际的 Edge Key**。
* **PUT_YOUR_EDGE_SECRET_HERE：** 替换为 **实际的 Edge Secret**。
* **PUT_YOUR_RPC_HOST：**
  * Edge 与 Server 实例在同一台机器上时使用 **localhost**。
  * Edge 连接同一网络或 Docker 内的 Server 实例时使用 **X.X.X.X** IP 地址。

#### 配置 PostgreSQL（可选）

若修改了 PostgreSQL 默认数据源设置，请使用以下命令：

```bash
sudo sh -c 'cat <<EOL >> /etc/tb-edge/conf/tb-edge.conf
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/tb_edge
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=<PUT_YOUR_POSTGRESQL_PASSWORD_HERE>
EOL'
```
{: .copy-code}

* **PUT_YOUR_POSTGRESQL_PASSWORD_HERE：** 替换为实际的 **PostgreSQL 用户密码**。