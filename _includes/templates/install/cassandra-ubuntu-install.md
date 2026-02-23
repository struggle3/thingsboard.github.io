以下命令将安装 Apache Cassandra 及其命令行工具：

```bash
# 添加 Cassandra 软件源
echo "deb [signed-by=/etc/apt/keyrings/apache-cassandra.asc] https://debian.cassandra.apache.org 50x main" | sudo tee /etc/apt/sources.list.d/cassandra.sources.list
sudo curl -o /etc/apt/keyrings/apache-cassandra.asc https://downloads.apache.org/cassandra/KEYS
sudo apt-get update
# 安装 Cassandra
sudo apt-get install -y cassandra cassandra-tools
```
{: .copy-code}

要验证 Cassandra 是否正常运行，请使用以下命令检查节点状态和系统服务状态：

```bash
nodetool status
sudo systemctl status cassandra.service 
```
{: .copy-code}

输出中的 status 列应显示 `UN`（表示 "Up/Normal"）；您可能需要等待片刻让 Cassandra 完成初始化。示例输出：

```
$ nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  127.0.0.1  114.67 KiB  16      100.0%            b8e1bd83-5280-4e48-8b17-a4548eec583b  rack1

$ sudo systemctl status cassandra.service 
● cassandra.service - LSB: distributed storage system for structured data
     Loaded: loaded (/etc/init.d/cassandra; generated)
     Active: active (running) since Thu 2025-04-24 14:04:35 UTC; 43s ago
       Docs: man:systemd-sysv-generator(8)
    Process: 9415 ExecStart=/etc/init.d/cassandra start (code=exited, status=0/SUCCESS)
      Tasks: 61 (limit: 9439)
     Memory: 4.3G (peak: 4.3G)
        CPU: 14.470s
     CGroup: /system.slice/cassandra.service
             └─9553 /usr/bin/java -ea -da:net.openhft... -XX:+UseThreadPriorities -XX:+HeapDumpOnOutOfMemoryError -Xss256k -XX:+AlwaysPreTouch -XX:+UseTLAB -XX:+ResizeTLAB -XX:+UseNUMA -XX:>
...
```

您可以使用 Astra DB Cloud 替代自建 Cassandra。
参见[将 ThingsBoard 连接至 Astra DB](/docs/user-guide/install/pe/cassandra-cloud-astra-db/) 的说明。
