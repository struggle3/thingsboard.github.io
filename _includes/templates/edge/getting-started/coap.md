安装coap-cli。假设您的Windows/Linux/MacOS设备已安装Node.js和NPM，请执行以下命令：

```bash
npm install coap-cli -g
```
{: .copy-code}

请将$HOST_NAME、$COAP_PORT和$ACCESS_TOKEN替换为对应值。若未指定$COAP_PORT，默认使用**5683**。

```bash
echo -n '{"temperature": 25}' | coap post coap://$HOST_NAME:$COAP_PORT/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

例如，$HOST_NAME指向您本地的ThingsBoard Edge安装，CoAP端口为**5683**，访问令牌为**ABC123**：

```bash
echo -n '{"temperature": 25}' | coap post coap://localhost:5683/api/v1/ABC123/telemetry
```
{: .copy-code}

<br>
