以下命令将安装 Apache Cassandra 及其命令行工具：

```bash
# 导入 GPG 密钥
sudo rpm --import https://downloads.apache.org/cassandra/KEYS 
# 添加 Cassandra 软件源
sudo tee /etc/yum.repos.d/cassandra.repo > /dev/null <<EOF
[cassandra]
name=Apache Cassandra
baseurl=https://redhat.cassandra.apache.org/50x/
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://downloads.apache.org/cassandra/KEYS
EOF

# 安装软件包
sudo dnf -y update
sudo dnf -y install cassandra cassandra-tools chkconfig
# 启动服务
sudo systemctl daemon-reexec
sudo systemctl start cassandra.service
# 配置 Cassandra 开机自启
sudo chkconfig cassandra on
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
UN  127.0.0.1  136.29 KiB  16      100.0%            60ae50fd-8914-44a1-a397-b716b7d4b37c  rack1

$ sudo systemctl status cassandra.service 
● cassandra.service - LSB: distributed storage system for structured data
     Loaded: loaded (/etc/rc.d/init.d/cassandra; generated)
     Active: active (running) since Thu 2025-04-24 12:22:11 UTC; 11min ago
       Docs: man:systemd-sysv-generator(8)
    Process: 34716 ExecStart=/etc/rc.d/init.d/cassandra start (code=exited, status=0/SUCCESS)
   Main PID: 34819 (java)
      Tasks: 62 (limit: 50538)
     Memory: 4.3G
        CPU: 17.792s
     CGroup: /system.slice/cassandra.service
             └─34819 /usr/lib/jvm/java-17-openjdk-17.0.14.0.7-2.el9.x86_64/bin/java -ea -da:net.openhft... -XX:+UseThreadPriorities -XX:+HeapDumpOnOutOfMemoryError -Xss256k -XX:+AlwaysPreTo>
...
```

您可以使用 Astra DB Cloud 替代自建 Cassandra。
参见[将 ThingsBoard 连接至 Astra DB](/docs/user-guide/install/pe/cassandra-cloud-astra-db/) 的说明。
