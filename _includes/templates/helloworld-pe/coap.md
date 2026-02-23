安装 coap-cli。若已在 Windows/Linux/macOS 上安装 Node.js 和 NPM，请执行以下命令：

```bash
npm install coap-cli -g
```
{: .copy-code}

{% if docsPrefix contains 'paas/' %}

请将$ACCESS_TOKEN替换为实际值。

```bash
echo -n '{"temperature": 25}' | coap post coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

例如，若$ACCESS_TOKEN为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://{{coapHostName}}/api/v1/ABC123/telemetry
```
{: .copy-code}

{% else %}

请将$THINGSBOARD_HOST_NAME和$ACCESS_TOKEN替换为实际值。

```bash
echo -n '{"temperature": 25}' | coap post coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 指向本地安装，$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://localhost/api/v1/ABC123/telemetry
```
{: .copy-code}

{% endif %}

<br>
<br>
