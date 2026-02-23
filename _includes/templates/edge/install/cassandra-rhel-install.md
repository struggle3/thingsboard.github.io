运行 Cassandra 前需安装 **Java 11**：
```bash
sudo apt install openjdk-11-jdk-headless
```
{: .copy-code}

将 **Java 17** 设为默认版本（ThingsBoard Edge 所需）：
```bash
sudo update-alternatives --config java
```
{: .copy-code}

添加 Cassandra **软件源**：
```bash
sudo nano /etc/yum.repos.d/cassandra.repo
```
{: .copy-code}

加入以下内容：
```ini
[cassandra]
name=Apache Cassandra
baseurl=https://redhat.cassandra.apache.org/50x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.apache.org/cassandra/KEYS
```
{: .copy-code}
* **50x** 对应 Cassandra 5.0 系列。

如需要，更新软件包索引： 
```bash
sudo yum update
```
{: .copy-code}

安装 Cassandra：
```bash
sudo yum install cassandra
```
{: .copy-code}

启动 Cassandra 服务：
```bash
sudo service cassandra start
```
{: .copy-code}
