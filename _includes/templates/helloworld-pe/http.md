为 **Ubuntu** 安装 cURL：

```bash
sudo apt-get install curl
```
{: .copy-code}


为 **macOS** 安装 cURL：

```bash
brew install curl
```
{: .copy-code}

为 **Windows** 安装 cURL：

自 Windows 10 b17063 起，cURL 已默认可用。
更多信息请参阅 MSDN 博客[文章](https://blogs.msdn.microsoft.com/commandline/2018/01/18/tar-and-curl-come-to-windows/){:target="_blank"}。
如使用更早版本的 Windows，可参阅[官方安装指南](https://curl.haxx.se/){:target="_blank"}。

<br>

以下命令适用于已安装 cURL 的 Windows、Ubuntu 和 macOS。 

{% if docsPrefix contains 'paas/' %}

请将$ACCESS_TOKEN替换为实际值。

```bash
curl -v -X POST -d "{\"temperature\": 25}" {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

例如，若$ACCESS_TOKEN为 ABC123：

```bash
curl -v -X POST -d "{\"temperature\": 25}" {{httpsUrl}}/api/v1/ABC123/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% else %}

请将 $THINGSBOARD_HOST_NAME_AND_PORT 和$ACCESS_TOKEN替换为实际值。

```bash
curl -v -X POST -d "{\"temperature\": 25}" http://$THINGSBOARD_HOST_NAME_AND_PORT/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME_AND_PORT 指向本地安装（端口 8080），$ACCESS_TOKEN 为 ABC123：

```bash
curl -v -X POST -d "{\"temperature\": 25}" http://localhost:8080/api/v1/ABC123/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
