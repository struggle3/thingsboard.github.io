在 **Ubuntu** 上安装 cURL：

```bash
sudo apt-get install curl
```
{: .copy-code}


在 **macOS** 上安装 cURL：

```bash
brew install curl
```
{: .copy-code}

在 **Windows** 上安装 cURL：

自 Windows 10 b17063 起，cURL 已默认可用。 
更多信息请参阅 MSDB 博客 [文章](https://blogs.msdn.microsoft.com/commandline/2018/01/18/tar-and-curl-come-to-windows/)。
若使用较早版本的 Windows，可在此处查看[官方安装指南](https://curl.haxx.se/)。

<br>

假设已安装 cURL，以下命令适用于 Windows、Ubuntu 和 macOS。 

将 $THINGSBOARD_HOST_NAME_AND_PORT 和$ACCESS_TOKEN替换为对应值。

```bash
curl -v -X POST -d "{\"temperature\": 25}" $THINGSBOARD_HOST_NAME_AND_PORT/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME_AND_PORT 为 ThingsBoard Cloud（北美），$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://thingsboard.cloud/api/v1/ABC123/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME_AND_PORT 为 ThingsBoard Cloud（欧洲），$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://eu.thingsboard.cloud/api/v1/ABC123/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME_AND_PORT 为本地部署，端口 8080，$ACCESS_TOKEN 为 ABC123：

```bash
curl -v -X POST -d "{\"temperature\": 25}" http://localhost:8080/api/v1/ABC123/telemetry --header "Content-Type:application/json"
```
{: .copy-code}
