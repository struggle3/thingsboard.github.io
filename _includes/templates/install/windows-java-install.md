ThingsBoard 服务运行于 Java 17。请按以下说明安装 OpenJDK 17。

 * 访问 [Open JDK 下载页](https://adoptium.net)。进入 "Other platforms and versions"，选择 "Operating System" 为 "Windows"、"Architecture" 为 "x64"、"Version" 为 "17 - LTS"，下载 **JDK .msi** 安装包。
 * 运行下载的 MSI 安装包并按照提示操作。
 确保将 "**Add to PATH**" 和 "**Set JAVA_HOME variable**" 选项设为 "Will be installed on local hard drive"。
 * 访问 [PostgreSQL JDBC 下载页](https://jdbc.postgresql.org/download/) 下载 PostgreSQL JDBC Driver。选择最新可用版本。
 * 创建文件夹 **C:\Program Files\JDBC** 并将下载的文件复制到其中。然后添加新的全局变量——以管理员身份运行 PowerShell 并执行以下命令。请勿忘记将命令中的 "postgresql-42.2.18.jar" 替换为下载的版本名称。
 ```powershell
[System.Environment]::SetEnvironmentVariable("CLASSPATH", '.;"C:\Program Files\JDBC\postgresql-42.2.18.jar"', [System.EnvironmentVariableTarget]::Machine)
```
{: .copy-code}


可使用以下命令（在命令提示符中）检查安装：

```bash
java -version
```
{: .copy-code}

预期命令输出为：

```text
C:\Users\User>java -version
openjdk version "17.x.xx" 
OpenJDK Runtime Environment Temurin-17.x.xx (...)
OpenJDK 64-Bit Server VM Temurin-17.x.xx (...)
```
