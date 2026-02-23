ThingsBoard 服务运行在 Java 17 上。请按以下说明安装 OpenJDK 17：

```bash
sudo apt update && sudo apt install openjdk-17-jdk-headless
```
{: .copy-code}

将您的操作系统配置为**默认使用 OpenJDK 17**。您可以通过运行以下命令来配置默认版本：

```bash
sudo update-alternatives --config java
```
{: .copy-code}

要检查系统上已安装的 Java 版本，请使用以下命令：

```bash
java -version
```
{: .copy-code}

预期输出为：

```text
openjdk version "17.x.xx" 
OpenJDK Runtime Environment (...)
OpenJDK 64-Bit Server VM (...)
```
