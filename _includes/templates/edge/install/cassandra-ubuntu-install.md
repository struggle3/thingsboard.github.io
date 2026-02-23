以下说明将帮助您安装 **Cassandra**。

```bash
# 添加 cassandra 仓库
echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee /etc/apt/sources.list.d/cassandra.sources.list
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
## 安装 Cassandra
sudo apt-get install cassandra
## 安装工具
sudo apt-get install cassandra-tools
```

要运行 Cassandra，请安装 **Java 11**。

```bash
sudo apt install openjdk-11-jdk-headless
```
{: .copy-code}

将 **Java 17** 设为默认版本（**ThingsBoard Edge** 需要）：
```bash
sudo update-alternatives --config java
```
{: .copy-code}

编辑 Cassandra **配置文件**：
```
sudo sed -i 's|#JAVA_HOME=/usr/local/jdk6|JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64|' /usr/share/cassandra/cassandra.in.sh
```
{: .copy-code}

然后重启 **Cassandra**：
```bash
sudo service cassandra stop && sudo service cassandra start
```
{: .copy-code}


