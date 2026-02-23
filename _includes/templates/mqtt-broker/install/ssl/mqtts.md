## 启用 MQTTS（基于 SSL/TLS 的 MQTT）

要在TBMQ中启用 **MQTT over SSL/TLS (MQTTS)**，需提供有效的SSL证书并配置TBMQ使用这些证书。

支持的格式及配置选项详见 [MQTT over SSL](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/) 指南。

**准备 SSL 证书**

获取有效的SSL证书和私钥。例如：

* `mqttserver.pem` – 公钥证书（可包含完整证书链）
* `mqttserver_key.pem` – 私钥

> 测试时可使用自签名证书，但生产环境建议使用受信任证书颁发机构颁发的证书。

**将证书挂载到容器**

在 `docker-compose.yml` 中挂载包含证书的目录：

```yaml
volumes:
  - PATH_TO_CERTS:/config/certificates
```
{: .copy-code}

将 `PATH_TO_CERTS` 替换为证书文件路径。确保TBMQ对这些文件具有读权限。

**配置环境变量**

在 `docker-compose.yml` 中添加以下变量以启用SSL：

```yaml
LISTENER_SSL_ENABLED: "true"
LISTENER_SSL_PEM_CERT: "/config/certificates/mqttserver.pem"
LISTENER_SSL_PEM_KEY: "/config/certificates/mqttserver_key.pem"
LISTENER_SSL_PEM_KEY_PASSWORD: "server_key_password"
```
{: .copy-code}

> 若私钥未设置密码保护，请将 `LISTENER_SSL_PEM_KEY_PASSWORD` 留空。

**暴露 MQTTS 端口**

在 `docker-compose.yml` 中：

```yaml
ports:
  - "8883:8883"
```
{: .copy-code}

**重启 TBMQ**

通过重启TBMQ使更改生效：

```bash
./tbmq-install-and-run.sh
```
{: .copy-code}

重启后，MQTT客户端可通过 **8883** 端口使用 TLS/SSL 安全连接。
