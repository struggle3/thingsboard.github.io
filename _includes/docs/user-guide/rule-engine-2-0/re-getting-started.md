* TOC
{:toc}

## Hello-World 示例

假设您的设备使用 DHT22 传感器采集温度并推送到 ThingsBoard。
DHT22 可测量 -40°C 至 +80°C 的温度。

本教程将配置 ThingsBoard 规则引擎，仅保存 -40 至 80°C 范围内的温度，其余读数记录到系统日志。

### 添加温度校验节点

在 ThingsBoard 界面中进入**规则链**页面并打开**根规则链**。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/initial-root-chain-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/initial-root-chain-pe.png)
{% endif %}

将**脚本过滤**规则节点拖放到链中。将打开节点配置窗口。

{% include templates/tbel-vs-js.md %}

{% capture scriptfunctionfilterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/rule-engine/getting-started/script-function-filter-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/rule-engine/getting-started/script-function-filter-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="scriptfunctionfilterconfig" toggle-spec=scriptfunctionfilterconfig %}

若温度未定义或温度有效，脚本返回 **True**，否则返回 **False**。
脚本返回 **True** 时，入站消息将路由到通过 **True** 关系连接的下游节点。
 
现在令所有**遥测请求**都经过该校验脚本。需删除 **Message Type Switch** 节点与 **Save Telemetry** 节点之间已有的 **Post Telemetry** 关系：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/remove-relation-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/remove-relation-pe.png)
{% endif %}

然后用 **Post Telemetry** 关系将 **Message Type Switch** 节点连接到 **Script Filter** 节点：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/realtion-window-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/realtion-window-pe.png)
{% endif %}

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/connect-script-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/connect-script-pe.png)
{% endif %}


接下来，用 **True** 关系将 **Script Filter** 节点连接到 **Save Telemetry** 节点，使所有有效遥测被保存：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/script-to-save-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/script-to-save-pe.png)
{% endif %}

同时，用 **False** 关系将 **Script Filter** 节点连接到 **Log Other** 节点，使所有无效遥测记录到系统日志：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/false-log-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/false-log-pe.png)
{% endif %}

点击保存以应用更改。

### 验证结果

需先创建设备并向 ThingsBoard 提交遥测以验证结果。进入**设备**部分并创建新设备：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/create-device-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/create-device-pe.png)
{% endif %}

将使用 [Rest API](/docs/{{docsPrefix}}reference/http-api/#telemetry-upload-api) 提交设备遥测。为此需要从设备 **DHT22** 复制设备访问令牌。 

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/copy-access-token-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/copy-access-token-pe.png)
{% endif %}

<br>
在终端发送温度读数为 99 的消息。将 **$ACCESS_TOKEN** 替换为实际设备令牌。

{% if docsPrefix == null or docsPrefix == "pe/" %}
```bash
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-localhost-2.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
curl -v -X POST -d '{"temperature":99}' {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-cloud-2.png)
{% endif %}

将看到遥测**未**出现在设备的**最新遥测**中：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/empty-telemetry-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/empty-telemetry-pe.png)
{% endif %}

<br>

现在发送温度读数为 24 的消息。

{% if docsPrefix == null or docsPrefix == "pe/" %}
```bash
curl -v -X POST -d '{"temperature":24}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-localhost-1.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
curl -v -X POST -d '{"temperature":24}' {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-cloud-1.png)
{% endif %}

将看到遥测已成功保存。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/saved-ok-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/saved-ok-pe.png)
{% endif %}

## 另见

可通过以下链接进一步了解 ThingsBoard 规则引擎：

- [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)
- [调试节点执行](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#debugging)
- [校验入站遥测](/docs/user-guide/rule-engine-2-0/tutorials/validate-incoming-telemetry/)
- [转换入站遥测](/docs/user-guide/rule-engine-2-0/tutorials/transform-incoming-telemetry/)
- [使用先前记录转换遥测](/docs/user-guide/rule-engine-2-0/tutorials/transform-telemetry-using-previous-record/)
- [创建与清除告警](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/)
- [告警时发送邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)
- [设备离线时创建告警](/docs/user-guide/rule-engine-2-0/tutorials/create-inactivity-alarm/)
- [检查实体间关系](/docs/user-guide/rule-engine-2-0/tutorials/check-relation-tutorial/)
- [向关联设备发送 RPC 请求](/docs/user-guide/rule-engine-2-0/tutorials/rpc-request-tutorial/)
- [动态添加与移除设备到组](/docs/user-guide/rule-engine-2-0/tutorials/add-devices-to-group/)
- [聚合入站数据流](/docs/user-guide/rule-engine-2-0/tutorials/aggregate-incoming-data-stream/)

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}
