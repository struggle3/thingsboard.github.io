{% include /templates/edge/user-guide/starting-edge-on-device.md %}

要在 **{{deviceName}}** 上继续 **Edge 安装**，需建立 **SSH (Secure Shell)** 连接。

{% if page.url contains "raspberry-pi" %}
{% include /templates/edge/devices-library/rpi-enable-ssh.md %}
{% endif %}

要建立到 **{{deviceName}}** 的 **SSH (Secure Shell)** 连接，打开终端并执行以下命令：

```bash
ssh {{userName}}@ip_address #Enter the actual IP address
```
{: .copy-code}

**ip_address** 将 "_ip_address_" 替换为 **{{deviceName}}** 的实际 IP 地址。<br>
**Password** 终端将提示输入密码。{% if page.url contains "raspberry-pi" %}_默认密码为 `raspberry`。_{% endif %}
{% if page.url contains "nvidia" %}_默认密码为 `nvidia`。_{% endif %}

连接成功后，按以下安装说明操作。首先创建新目录：

```bash
mkdir tb_edge
```
{: .copy-code}

进入该目录：

```bash
cd /home/{{userName}}/tb_edge
```
{: .copy-code}

{% include /templates/edge/user-guide/preset-edge-config-for-docker.md %}

要通过 SSH 设置本地端口转发，打开 **另一个终端标签页** 并执行以下命令：

```bash
ssh -N -L 8080:127.0.0.1:8080 {{userName}}@ip_address #Enter the actual IP address
```
{: .copy-code}

您本机对 **localhost:8080** 的任何连接都将转发到 **{{deviceName}}** 上的 **127.0.0.1:8080**。

**ThingsBoard Edge** 实例可通过 [**http://127.0.0.1:8080**](http://127.0.0.1:8080){: target="_blank"} 访问。使用您的凭证登录。
