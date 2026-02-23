| **参数**          | **默认值**                    | **说明**                                                                                                                                                       |
|:-----------------------|:-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| url                    | **localhost:4840/freeopcua/server/** | OPC-UA 服务器的主机名或 IP 地址。                                                                                                                              |
| timeoutInMillis        | **5000**                             | 连接 OPC-UA 服务器的超时时间（秒）。                                                                                                                   |
| scanPeriodInMillis     | **3600000**                          | 重新扫描服务器的周期（毫秒）。                                                                                                                          |
| pollPeriodInMillis     | **5000**                             | 轮询服务器的周期（毫秒）。                                                                                                                            |
| enableSubscriptions    | **false**                            | 若为 true，网关将订阅相关节点并等待数据更新；若为 false，网关将每 **scanPeriodInMillis** 重新扫描 OPC-UA 服务器。 |
| subCheckPeriodInMillis | **100**                              | 检查 OPC-UA 服务器中 subscription 的周期。                                                                                                               |
| showMap                | **true**                             | 扫描时是否显示节点：**true** 或 **false**。                                                                                                                         |
| security               | **Basic128Rsa15**                    | 安全策略（**Basic128Rsa15**、**Basic256**、**Basic256Sha256**）。                                                                                                |
| ---                    |                                      |                                                                                                                                                                       |

<br>
**示例说明。**
<br>
本例使用 Prosys OPC-UA Simulation Server 演示如何配置 OPC-UA connector。
<br>

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-simulation-server-1.png)
{: refdef}

在"**Status**"主标签页中，复制连接地址（UA TCP）。

要将 OPC-UA 服务器连接到 ThingsBoard，打开 OPC-UA Connector 配置文件（opcua.json），将 "url" 值替换为复制的连接地址。

**server** 部分如下所示：

```json
"server": {
    "name": "OPC-UA Default Server",
    "url": "localhost:53530/OPCUA/SimulationServer",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 5000,
    "disableSubscriptions": false,
    "subCheckPeriodInMillis": 100,
    "showMap": false,
    "security": "Basic128Rsa15",
    ...
},
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-connector/opc-ua-section-application-advanced-anonymous-1-ce.png)
{: refdef}
