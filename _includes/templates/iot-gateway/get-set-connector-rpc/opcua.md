每个遥测和属性参数开箱即用 **GET** 和 **SET** RPC 方法，无需手动配置。
例如，若有如下遥测参数：
```json
"timeseries": [
  {
    "key": "temperature",
    "path": "${ns=3;i=1001}"
  }
]
```

要获取温度遥测的当前值，请运行以下查询：

```bash
get ns=3;i=1001;
```
{: .copy-code}

响应：
```json
{"result":  25.34}
```

要设置温度遥测值，请运行以下查询：

```bash
set ns=3;i=1001; 23
```
{: .copy-code}

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-rpc-1.png)
{: refdef}
<br>
要为 **"model"** 属性设置新值（T3000），请运行以下查询：

```bash
set ns=3;i=1008; T3000;
```
{: .copy-code}

响应：
```json
{"success":"true","code": 200}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-rpc-2.png)
{: refdef}
