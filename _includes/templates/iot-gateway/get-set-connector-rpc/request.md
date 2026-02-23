### GET 方法

使用 GET 方法可向外部 API 发送 GET 请求。

```bash
get requestUrlExpression=<requestUrlExpression>;
```

其中：
- `<requestUrlExpression>` - 外部 API 的 URL。

例如，本示例中可从 URL 为 **"http://127.0.0.1:8000/light-level"** 的外部 API 获取房间光照度。
要获取房间光照度值，请运行以下查询：

```bash
get requestUrlExpression=light-level;
```

**响应：**

```json
{"result":"{\"light-level\":30}"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/request-get-set-rpc-1.png)
{: refdef}

### SET 方法

使用 SET 方法可向外部 API 发送 POST 请求。

```bash
get requestUrlExpression=<requestUrlExpression>;value=<value>;HTTPMethod=<HTTPMethod>;
```

其中：
- `<requestUrlExpression>` - 外部 API 的 URL；
- `<value>` - 要发送的值；
- `<HTTPMethod>` - 要使用的 HTTP 方法。

例如，本示例中可将房间光照度设置到 URL 为 **"http://127.0.0.1:8000/light-level"** 的外部 API。
要设置房间光照度值，请运行以下查询：

```bash
set requestUrlExpression=light-level;value=80;httpMethod=POST;
```

**响应：**

```json
{"result":"{\"status\":\"ok\"}"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/request-get-set-rpc-2.png)
{: refdef}

使用 GET 方法查看设置后的光照度。只需运行上述 GET RPC 方法即可：

```bash
get requestUrlExpression=light-level;
```

**响应：**

```json
{"result":  {"light-level":80}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/request-get-set-rpc-3.png)
{: refdef}
