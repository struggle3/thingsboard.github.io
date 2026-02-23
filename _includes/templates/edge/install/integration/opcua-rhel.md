下载安装包：

```bash
wget https://dist.thingsboard.io/tb-opc-ua-integration-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

以服务方式安装集成：

```bash
sudo rpm -Uvh tb-opc-ua-integration-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

打开配置文件进行编辑：

```bash 
sudo nano /etc/tb-opc-ua-integration/conf/tb-opc-ua-integration.conf
``` 
{: .copy-code}

找到如下配置块：

```bash
# UNCOMMENT NEXT LINES AND PUT YOUR CONNECTION PARAMETERS:
# export RPC_HOST=thingsboard.cloud
# export RPC_PORT=9090
# export INTEGRATION_ROUTING_KEY=YOUR_INTEGRATION_KEY
# export INTEGRATION_SECRET=YOUR_INTEGRATION_SECRET
```
填入配置参数：
- **RPC_HOST：** 使用 Edge 实例的 IP 地址，若在同一台机器运行则使用 **localhost**。
- **9090：** 集成端口，由 tb-edge.yml 中的 INTEGRATIONS_RPC_PORT 环境变量配置。
- **YOUR_ROUTING_KEY：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的 **集成路由密钥**。
- **YOUR_SECRET：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的 **集成密钥**。

请**取消注释** export 语句。示例：

```bash
# UNCOMMENT NEXT LINES AND PUT YOUR CONNECTION PARAMETERS:
export RPC_HOST=127.0.0.1 # THE IP ADDRESS OF YOUR EDGE INSTANCE
export RPC_PORT=9090
export INTEGRATION_ROUTING_KEY=b75**************************34d
export INTEGRATION_SECRET=vna**************mik
```

启动 ThingsBoard 集成：

```bash
sudo service tb-opc-ua-integration start
```
{: .copy-code}

#### 高级配置

可在 **tb-opc-ua-integration.conf** 中查看并修改更多配置参数。

使用以下命令编辑文件：

```bash 
sudo nano /etc/tb-opc-ua-integration/conf/tb-opc-ua-integration.conf
``` 
{: .copy-code} 

修改配置后，可在 **/var/log/tb-opc-ua-integration/** 下查看日志以验证集成是否正常运行。
可查找 **INFO** 级别日志，确认已收到服务器下发的集成配置。
