{% if docsPrefix == null %}
{% assign cacheUrl = "redis_url" %}
{% else %}
{% assign cacheUrl = "valkey_url" %}
{% endif %}

* TOC
{:toc}

本指南将帮助您在 Linux 或 macOS 上使用 Docker 安装并启动独立版 TBMQ {{tbmqSuffix}}。
如需集群安装说明，请访问[集群设置页面](/docs/{{docsPrefix}}mqtt-broker/install/cluster/docker-compose-setup/)。

## 前置条件

在单机上运行 TBMQ {{tbmqSuffix}} 至少需要 2GB 内存。

- [Install Docker](https://docs.docker.com/engine/installation/)

{% include templates/install/docker-install-note.md %}

{% if docsPrefix == "pe/" %}
## Get the license key

Before proceeding, make sure you’ve selected your subscription plan or chosen to purchase a perpetual license.
If you haven’t done this yet, please visit the [Pricing page](/pricing/?section=tbmq-options){: target="_blank"} to compare available options 
and obtain your license key.

> **Note:** Throughout this guide, we’ll refer to your license key as **YOUR_LICENSE_KEY_HERE**.

{% endif %}

## 安装

执行以下命令下载安装并启动 TBMQ {{tbmqSuffix}} 的脚本：

{% include templates/mqtt-broker/install/linux-macos/linux-macos-install.md %}

脚本会下载 _docker-compose.yml_ 文件、创建必要的 docker 卷、安装 TBMQ 的数据库并启动 TBMQ。
docker-compose 文件中 TBMQ 的关键配置点：

{% if docsPrefix == "pe/" %}
- `TBMQ_LICENSE_SECRET: YOUR_LICENSE_KEY_HERE` - 此前获取的许可证密钥占位符；
{% endif %}
- `8083:8083` - 将本地端口 8083 映射到内部 HTTP 端口 8083；
- `1883:1883` - 将本地端口 1883 映射到内部 MQTT 端口 1883；
- `8084:8084` - 将本地端口 8084 映射到内部 MQTT over WebSockets 端口 8084；
{% if docsPrefix == null %}
- `tbmq-redis-data:/bitnami/redis/data` - 将 `tbmq-redis-data` 卷映射到 TBMQ Redis 数据库数据目录；
{% else %}
- `tbmq-valkey-data:/data` - 将 `tbmq-valkey-data` 卷映射到 TBMQ Valkey 数据库数据目录；
{% endif %}
- `tbmq-postgres-data:/var/lib/postgresql/data` - 将 `tbmq-postgres-data` 卷映射到 TBMQ Postgres 数据库数据目录；
{% if docsPrefix == null %}
- `tbmq-kafka-data:/bitnami/kafka` - 将 `tbmq-kafka-data` 卷映射到 Kafka 数据目录；
{% else %}
- `tbmq-kafka-data:/var/lib/kafka/data` - 将 `tbmq-kafka-data` 卷映射到 Kafka 数据目录；
{% endif %}
- `tbmq-logs:/var/log/thingsboard-mqtt-broker` - 将 `tbmq-logs` 卷映射到 TBMQ 日志目录；
- `tbmq-data:/data` - 将 `tbmq-data` 卷映射到 TBMQ 数据目录（安装 DB 后包含 _.firstlaunch_ 文件）；
- `tbmq` - 本机友好名称；
- `restart: always` - 系统重启时自动启动 TBMQ，故障时自动重启。

{% if docsPrefix == "pe/" %}

{% capture replace_tbmq_license_secret %}
Update your `docker-compose.yml` file with the license secret you obtained earlier.
Open the file, find the **TBMQ_LICENSE_SECRET** environment variable, 
and replace **YOUR_LICENSE_KEY_HERE** with your actual license secret.
After updating the file, restart TBMQ by running the following command.
{% endcapture %}
{% include templates/warn-banner.md content=replace_tbmq_license_secret %}

```shell
./tbmq-install-and-run.sh
```
{: .copy-code}

{% endif %}

**注意**：若 TBMQ 安装在 ThingsBoard 已运行的同一主机上，可能出现以下错误：

```
Error response from daemon: ... Bind for 0.0.0.0:1883 failed: port is already allocated
```

修复方法：为 TBMQ 容器暴露另一个主机端口，例如将已下载的 docker-compose.yml 中的 `1883:1883` 改为 `1889:1883`，然后重新运行脚本。

```shell
./tbmq-install-and-run.sh
```
{: .copy-code}

安装完成后，可在浏览器中访问 `http://{your-host-ip}:8083`（例如 **http://localhost:8083**）打开 TBMQ UI。

{% include templates/mqtt-broker/login.md %}

## 日志、停止和启动命令

若遇问题，可查看服务日志排查错误。
例如，查看 TBMQ 日志请执行以下命令：

```
docker compose logs -f tbmq
```
{: .copy-code}

停止容器：

```
docker compose stop
```
{: .copy-code}

启动容器：

```
docker compose start
```
{: .copy-code}

## 升级

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### 备份与恢复（可选）

强烈建议备份 PostgreSQL 数据库，但在升级前为可选操作。 
{% if docsPrefix == null %} For further guidance, follow the [next instructions](https://github.com/thingsboard/tbmq/blob/main/msa/tbmq/configs/README.md).
{% else %} For further guidance, follow the [next instructions](https://github.com/thingsboard/tbmq-pe-docker-compose/blob/master/basic/README.md).
{% endif %}

{% if docsPrefix == null %}
### Upgrade to 2.2.0

In this release, the MQTT authentication mechanism was migrated from YAML/env configuration into the database.
During upgrade, TBMQ needs to know which authentication providers are enabled in your deployment. 
This is done using environment variables passed to the **upgrade container**.

The upgrade script therefore requires a file named **`.tbmq-upgrade.env`** in the same directory as `docker-compose.yml`.
This file is **used only during upgrade** to create the default auth providers. 
Make sure the values match what you already run in your `tbmq` service (`docker-compose.yml → environment:`).

**Create the env file**

From the directory containing `docker-compose.yml`:

```bash
cat > .tbmq-upgrade.env <<'EOF'
SECURITY_MQTT_BASIC_ENABLED=true
SECURITY_MQTT_SSL_ENABLED=true
SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT=false
EOF
```
{: .copy-code}

> **Tips**
> If you use only Basic authentication, set `SECURITY_MQTT_SSL_ENABLED=false`. 
> If you use only X.509 authentication, set `SECURITY_MQTT_BASIC_ENABLED=false` and `SECURITY_MQTT_SSL_ENABLED=true`.

**Notes**

* **Required**: If `.tbmq-upgrade.env` is missing, the upgrade script will fail.
* Supported variables:

  * `SECURITY_MQTT_BASIC_ENABLED` (`true|false`)
  * `SECURITY_MQTT_SSL_ENABLED` (`true|false`)
  * `SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT` (`true|false`) — usually `false`.

Once the file is created, continue with the [upgrade process](#run-upgrade).

### Upgrade to 2.1.0

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release.md %}

### Upgrade to 2.0.0

For the TBMQ 2.0.0 release, the installation scripts have been updated to include Redis configuration.

Please update your `docker-compose.yml` file to incorporate the Redis settings. 
You can review the necessary changes by visiting the following [link](https://github.com/thingsboard/tbmq/pull/142/files#diff-18a10097b03fb393429353a8f84ba29498e9b72a21326deb9809865d384e2800).

<br>
<details markdown="1">
<summary>
Here is the complete docker compose file with the Redis configuration prior to the upgrade
</summary>

```yaml
#
# Copyright © 2016-2024 The Thingsboard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

services:
  postgres:
    restart: always
    image: "postgres:15"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: thingsboard_mqtt_broker
      POSTGRES_PASSWORD: postgres
    volumes:
      - tbmq-postgres-data:/var/lib/postgresql/data
  kafka:
    restart: always
    image: "bitnamilegacy/kafka:3.5.1"
    ports:
      - "9092"
    environment:
      KAFKA_CFG_NODE_ID: 0
      KAFKA_CFG_PROCESS_ROLES: controller,broker
      KAFKA_CFG_CONTROLLER_QUORUM_VOTERS: 0@kafka:9093
      KAFKA_CFG_LISTENERS: PLAINTEXT://:9092,CONTROLLER://:9093
      KAFKA_CFG_ADVERTISED_LISTENERS: PLAINTEXT://:9092
      KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
      KAFKA_CFG_CONTROLLER_LISTENER_NAMES: CONTROLLER
      KAFKA_CFG_INTER_BROKER_LISTENER_NAME: PLAINTEXT
    volumes:
      - tbmq-kafka-data:/bitnami/kafka
  redis:
    restart: always
    image: "bitnamilegacy/redis:7.0"
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      ALLOW_EMPTY_PASSWORD: "yes"
    ports:
      - "6379"
    volumes:
      - tbmq-redis-data:/bitnami/redis/data
  tbmq:
    restart: always
    image: "thingsboard/tbmq:1.4.0"
    depends_on:
      - postgres
      - kafka
      - redis
    ports:
      - "8083:8083"
      - "1883:1883"
      - "8084:8084"
    environment:
      TB_SERVICE_ID: tbmq
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/thingsboard_mqtt_broker
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: postgres
      TB_KAFKA_SERVERS: kafka:9092
      REDIS_HOST: redis
      SECURITY_MQTT_BASIC_ENABLED: "true"
      #JAVA_OPTS: "-Xmx2048M -Xms2048M -Xss384k -XX:+AlwaysPreTouch"
    volumes:
      - tbmq-logs:/var/log/thingsboard-mqtt-broker
      - tbmq-data:/data

volumes:
  tbmq-postgres-data:
    external: true
  tbmq-kafka-data:
    external: true
  tbmq-redis-data:
    external: true
  tbmq-logs:
    external: true
  tbmq-data:
    external: true
```
{: .copy-code}

</details>
<br>

Additionally, add the following line to your `tbmq-install-and-run.sh` script (locate `create_volume_if_not_exists` lines) to create a volume for Redis data:

```bash
create_volume_if_not_exists tbmq-redis-data
```
{: .copy-code}

Or simply create it with the following command:

```bash
docker volume create tbmq-redis-data
```
{: .copy-code}

Once this is done, run the script to apply the changes:

```bash
./tbmq-install-and-run.sh
```
{: .copy-code}

This will restart TBMQ with Redis enabled. Afterward, you can proceed with the [upgrade process](#run-upgrade).
Please [contact us](https://github.com/thingsboard/tbmq/issues), so we can answer any questions and provide our help if needed.

{% else %}

### Upgrade from TBMQ CE to TBMQ PE (v2.2.0)

To upgrade your existing **TBMQ Community Edition (CE)** to **TBMQ Professional Edition (PE)**, ensure you are running the latest **TBMQ CE {{site.release.broker_full_ver}}** version before starting the process.
Do not forget to [configure the license key](#get-the-license-key).

The upgrade procedure requires a file named **`.tbmq-upgrade.env`** located in the same directory as your `docker-compose.yml`.
This file is **only used during the upgrade**.

**Create the `.tbmq-upgrade.env` file**

From the directory containing `docker-compose.yml`, run:

```bash
cat > .tbmq-upgrade.env <<'EOF'
JAVA_TOOL_OPTIONS=-Dinstall.upgrade.from_version=ce
EOF
```
{: .copy-code}

**Important Notes**

* **Required:** The upgrade script will fail if `.tbmq-upgrade.env` is missing.
* After creating the file, proceed with the [upgrade process](#run-upgrade).

{% endif %}

### 执行升级

要更新到最新版本，请执行以下命令：

{% if docsPrefix == null %}
```shell
wget -O tbmq-upgrade.sh https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/msa/tbmq/configs/tbmq-upgrade.sh &&
sudo chmod +x tbmq-upgrade.sh && ./tbmq-upgrade.sh
```
{: .copy-code}
{% else %}
```shell
wget -O tbmq-upgrade.sh https://raw.githubusercontent.com/thingsboard/tbmq-pe-docker-compose/{{ site.release.broker_branch }}/basic/tbmq-upgrade.sh &&
sudo chmod +x tbmq-upgrade.sh && ./tbmq-upgrade.sh
```
{: .copy-code}
{% endif %}

**注意**：将脚本中的 `{{cacheUrl}}`、`db_url`、`db_username` 和 `db_password` 变量替换为 DB 初始化时使用的对应值。

{% include templates/mqtt-broker/upgrade/upgrade-to-custom-release.md %}

{% include templates/mqtt-broker/install/ssl/mqtts.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
