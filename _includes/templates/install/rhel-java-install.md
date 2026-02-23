ThingsBoard 服务运行在 Java 17 上。请按以下说明安装 OpenJDK 17：

```bash
sudo dnf install java-17-openjdk-headless
```
{: .copy-code}

请勿忘记将您的操作系统配置为默认使用 OpenJDK 17。您可以使用以下命令配置默认版本：

```bash
sudo update-alternatives --config java
```
{: .copy-code}

您可以使用以下命令检查安装：

```bash
java -version
```
{: .copy-code}

预期命令输出为：

```text
openjdk version "17.x.xx"
OpenJDK Runtime Environment (...)
OpenJDK 64-Bit Server VM (build ...)
```
