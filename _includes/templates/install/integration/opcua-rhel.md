下载安装包：

```bash
wget https://dist.thingsboard.io/tb-opc-ua-integration-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

安装集成作为服务：

```bash
sudo rpm -Uvh tb-opc-ua-integration-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/tb-opc-ua-integration/conf/tb-opc-ua-integration.conf
``` 
{: .copy-code}

找到以下配置块：

```bash
# UNCOMMENT NEXT LINES AND PUT YOUR CONNECTION PARAMETERS:
# export RPC_HOST=thingsboard.cloud
# export RPC_PORT=9090
# export INTEGRATION_ROUTING_KEY=YOUR_INTEGRATION_KEY
# export INTEGRATION_SECRET=YOUR_INTEGRATION_SECRET
```

填入您的配置参数。请不要忘记取消 export 语句的注释。参见以下示例：

```bash
# UNCOMMENT NEXT LINES AND PUT YOUR CONNECTION PARAMETERS:
export RPC_HOST=thingsboard.cloud
export RPC_PORT=9090
export INTEGRATION_ROUTING_KEY=b75**************************34d
export INTEGRATION_SECRET=vna**************mik
```

执行以下命令以启动 ThingsBoard：

```bash
sudo service tb-opc-ua-integration start
```
{: .copy-code}

 - **高级配置**

可在 yml 配置文件中查找其他配置参数。

使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/tb-opc-ua-integration/conf/tb-opc-ua-integration.conf
``` 
{: .copy-code} 

执行此命令后可在以下位置查看日志 `/var/log/tb-opc-ua-integration/`. 
您应能看到来自服务器的部分 INFO 日志信息，其中包含最新的集成配置。
