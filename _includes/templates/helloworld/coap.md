安装 coap-cli。若已在 Windows/Linux/MacOS 上安装 Node.js 和 NPM，执行以下命令：

```bash
npm install coap-cli -g
```
{: .copy-code}

Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.

```bash
echo -n '{"temperature": 25}' | coap post coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为 ThingsBoard Cloud（北美），$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://coap.thingsboard.cloud/api/v1/ABC123/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为 ThingsBoard Cloud（欧洲），$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://coap.eu.thingsboard.cloud/api/v1/ABC123/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为本地部署，$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://localhost/api/v1/ABC123/telemetry
```
{: .copy-code}

<br>
<br>
