在**Ubuntu**上安装cURL：

```bash
sudo apt-get install curl
```
{: .copy-code}


在**macOS**上安装cURL：

```bash
brew install curl
```
{: .copy-code}

在**Windows**上安装cURL：

自Windows 10 b17063起，cURL已默认可用。
更多信息请参阅MSDB博客 [文章](https://blogs.msdn.microsoft.com/commandline/2018/01/18/tar-and-curl-come-to-windows/)。
若您使用较旧版本的Windows，可在此处 [官方安装指南](https://curl.haxx.se/) 查找。

<br>

以下命令适用于Windows、Ubuntu和macOS，前提是cURL工具已安装。请将$HOST_NAME和$ACCESS_TOKEN替换为对应值。

```bash
curl -v -X POST -d "{\"temperature\": 25}" $HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

例如，$HOST_NAME指向您本地的ThingsBoard Edge安装，访问令牌为**ABC123**：

```bash
curl -v -X POST -d "{\"temperature\": 25}" http://localhost:8080/api/v1/ABC123/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

<br>
