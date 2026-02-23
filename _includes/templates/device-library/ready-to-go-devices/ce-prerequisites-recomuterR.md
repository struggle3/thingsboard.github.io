### 前置条件

{% include /templates/edge/devices-library/prerequisites-ce.md %}

### 在 {{deviceName}} 上启动 Edge

{% include /templates/edge/user-guide/starting-edge-on-device.md %}

继续在 **{{deviceName}}** 上安装 **Edge 实例**：

* 要建立与 **{{deviceName}}** 的 **SSH（Secure Shell）** 连接，请打开终端并执行以下命令：

```bash
ssh recomputer@ip_address #输入实际 IP 地址
```
{: .copy-code}

**ip_address：** {{deviceName}} 的 IP 地址。请将 _ip_address_ 替换为实际 IP 地址。<br>
**密码：** 终端会请求密码。_{{deviceName}} 的**默认密码**为：12345678_

* 连接成功后，可按以下安装说明操作。首先创建新目录：

```bash
mkdir tb_edge
```
{: .copy-code}

* 打开该目录：

```bash
cd /home/recomputer/tb_edge
```
{: .copy-code}

{% include /templates/edge/user-guide/preset-edge-config-for-docker.md %}

* 要设置通过 SSH 的本地端口转发，请打开**另一个终端标签页**并执行以下命令：

```bash
ssh -N -L 8080:127.0.0.1:8080 recomputer@ip_address #输入实际 IP 地址
```
{: .copy-code}

您本地计算机上对 **localhost:8080** 的任何连接将被转发到 **{{deviceName}}** 上的 **127.0.0.1:8080**。

* **ThingsBoard Edge** 实例可通过 [**http://127.0.0.1:8080**](http://127.0.0.1:8080){: target="_blank"} 访问。请使用您的凭据登录。

### 在 Edge 上预配置 ThingsBoard IoT Gateway

{% include /templates/edge/user-guide/deploying-gw.md %}
