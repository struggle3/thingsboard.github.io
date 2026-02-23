| **参数** | **默认值**                                                                    | **说明**                                                                                                 |
|:--------------|:-------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| key           | **temperature °C**                                                                   | 将被解释为 ThingsBoard 平台实例 telemetry 的标签。                                   |
| type          | **path**                                                                             | 值的来源（可为 [path](#path-types)、[identifier](#identifier-types) 或 constant）。                  |
| value         | **${Root\\\\.Objects\\\\.Device1\\\\.TemperatureAndHumiditySensor\\\\.Temperature}** | OPC-UA 对象中用于在特定变量中查找值的变量名。** \* ** |
| ---           |                                                                                      |                                                                                                                 |

{% capture difference %}
以下规则同样适用于 attribute 配置。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

** \* ** 此处可输入搜索表达式，例如：
1. 节点完整路径 - **${Root\\\\.Objects\\\\.Device1\\\\.TemperatureAndHumiditySensor\\\\.Temperature}**
2. 设备对象的相对路径 - **${TemperatureAndHumiditySensor\\.Temperature}** 
3. 用于搜索的正则表达式 - **${Root\\\\.Objects\\\\.Device\\\\d\*\\\\.TemperatureAndHumiditySensor\\\\.Temperature}**
4. 命名空间标识符和节点标识符 - **${ns=2;i=5}**

配置的此部分将如下所示：  

```json
        "timeseries": [
          {
            "key": "temperature °C",
            "path": "${Root\\.Objects\\.Device1\\.TemperatureAndHumiditySensor\\.Temperature}"
          }
        ],
```

<br>
**来看一个示例。**

将 "path" 的值替换为 "NodeId" 的值。这是从设备对象或测试服务器 Display Name 标识符得到的相对路径。
<br>

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-simulation-server-4.png)
{: refdef}

在此示例中，**timeseries** 部分如下所示：

```json
        "timeseries": [
          {
            "key": "humidity",
            "path": "${Counter}"
          },
          {
            "key": "pressure",
            "path": "${Root\\.Objects\\.Simulation\\.Triangle}"
          },
          {
            "key": "temperature °C",
            "path": "${ns=3;i=1002}"
          }
        ],
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-connector/opc-ua-subsection-time-series-advanced-1-ce.png)
{: refdef}

您应能在设备 **Latest telemetry**（最新遥测）部分看到已发送到 ThingsBoard 的 telemetry：

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-3.png)
{: refdef}
