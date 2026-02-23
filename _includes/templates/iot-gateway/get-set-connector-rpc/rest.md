### GET 方法

使用 GET 方法可向 REST API 发送 GET 请求。

```bash
get requestUrlExpression=<requestUrlExpression>;value=<value>;
```

其中：
- `<requestUrlExpression>` - REST API 的 URL；
- `<value>` - 要发送的值。

例如，本示例中可从 URL 为 **"http://127.0.0.1:8000/light-level"** 的 REST API 获取房间光照度。
要获取房间光照度值，请运行以下查询：

```bash
get requestUrlExpression=http://127.0.0.1:8000/light-level;value=${params};
```

**Response:**

```json
{"result":  {"light-level":30}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/rest-get-set-rpc-1.png)
{: refdef}

### SET 方法

使用 SET 方法可向 REST API 发送 POST 请求。

```bash
set requestUrlExpression=<requestUrlExpression>;value=<value>;HTTPMethod=<HTTPMethod>;
```

其中：
- `<requestUrlExpression>` - REST API 的 URL；
- `<value>` - 要发送的值；
- `<HTTPMethod>` - 要使用的 HTTP 方法。

例如，本示例中可将房间光照度设置到 URL 为 **"http://127.0.0.1:8000/light-level"** 的 REST API。
要设置房间光照度值，请运行以下查询：

```bash
set requestUrlExpression=http://127.0.0.1:8000/light-level;value=80;HTTPMethod=POST;
```

**Response:**

```json
{"result":  {"status":"ok"}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/rest-get-set-rpc-2.png)
{: refdef}

使用 GET 方法查看设置后的光照度。只需运行上述 GET RPC 方法即可：

```bash
get requestUrlExpression=http://127.0.0.1:8000/light-level;value=${params};
```

**Response:**

```json
{"result":  {"light-level":80}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/rest-get-set-rpc-3.png)
{: refdef}
