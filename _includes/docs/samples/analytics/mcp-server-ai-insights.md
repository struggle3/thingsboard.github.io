* TOC
{:toc}

本文档介绍如何使用 [ThingsBoard MCP Server](https://github.com/thingsboard/thingsboard-mcp){: target="_blank"} 查询平台数据、生成示例遥测以及检测 ThingsBoard 时序数据中的异常。
我们将使用<b>自然语言查询</b>通过 MCP（经由 Claude 或其他 LLM provider）与 ThingsBoard 交互。

借助 ThingsBoard MCP，您可以：
- 在 ThingsBoard 平台中<b>查找</b>符合特定条件的设备。
- <b>模拟或写入遥测</b>（如 AQI 传感器数据）到 ThingsBoard 的指定设备。
- <b>分析设备数据</b>以检测异常。可轻松适配用于查找峰值、数据缺口或其他模式。

## 前置条件

开始前，请确保具备以下条件：

- {% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "paas/" %}[ThingsBoard Cloud](https://thingsboard.cloud/signup){: target="_blank"}{% endif %}{% if docsPrefix == "paas/eu/" %}[EU ThingsBoard Cloud](https://eu.thingsboard.cloud/signup){: target="_blank"}{% endif %} 账户或在自己 {% if docsPrefix == nil %}[基础设施](/docs/user-guide/install/installation-options/){: target="_blank"}{% endif %}{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}[基础设施](/docs/user-guide/install/pe/installation-options/){: target="_blank"}{% endif %}上的自托管 ThingsBoard 安装。
- 具有足够权限的认证凭据（用户名和密码）。
- 能够运行 MCP Server 的<b>LLM Agent</b>（如 Claude Desktop）。

## 步骤 1. 将 MCP Server 连接到 ThingsBoard

首先，使用 ThingsBoard MCP Server 启动您的<b>LLM Agent</b>。
本指南中将使用 [Claude Desktop](https://claude.ai/download){: target="_blank"} 启动<b>ThingsBoard MCP Server</b>并连接 ThingsBoard 实例。
您也可以使用其他支持 MCP 的客户端。

<b>通过 Docker 运行 MCP：</b>

```bash
docker pull thingsboard/mcp
```
{: .copy-code}

<b>Claude Desktop 配置</b>

在您的 `claude_desktop_config.json` 中添加以下配置：

```json
{
  "mcpServers": {
    "thingsboard": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "THINGSBOARD_URL",
        "-e",
        "THINGSBOARD_USERNAME",
        "-e",
        "THINGSBOARD_PASSWORD",
        "-e",
        "LOGGING_PATTERN_CONSOLE",
        "thingsboard/mcp"
      ],
      "env": {
        "THINGSBOARD_URL": "<thingsboard_url>",
        "THINGSBOARD_USERNAME": "<thingsboard_username>",
        "THINGSBOARD_PASSWORD": "<thingsboard_password>",
        "LOGGING_PATTERN_CONSOLE": ""
      }
    }
  }
}
```
{: .copy-code}

启动<b>Claude Desktop</b>后，您将看到可用的<b>thingsboard</b>工具：

{% include images-gallery.html imageCollection="claude-thingsboard-tools" %}

> 高级配置（运行二进制代替 Docker 或本地构建），请参阅 [ThingsBoard MCP GitHub 仓库](https://github.com/thingsboard/thingsboard-mcp){: target="_blank"}。

## 步骤 2. 在 ThingsBoard 中查询设备

以下为 ThingsBoard 平台内的设备列表：

{% include images-gallery.html imageCollection="thingsboard-devices-list" %}

使用<b>Claude Desktop</b>，您可用自然语言发起请求。

<b>示例查询：</b>

```text
Get devices of type 'Air Quality Sensor'
```
{: .copy-code}

ThingsBoard MCP 会将此转换为 ThingsBoard API 查询并返回结构化结果：

{% include images-gallery.html imageCollection="claude-get-devices-query" %}

## 步骤 3. 为 AQI 传感器生成示例数据

根据您的请求，MCP 可为任意设备模拟（生成）遥测。

<b>示例查询：</b>

```text
Generate sample data for Office #1 AQI Sensor for the last 3 days and save it as timeseries data. Use sampling rate as 1 hour
```
{: .copy-code}

{% include images-gallery.html imageCollection="claude-generate-data-query" %}

MCP 会自动将生成的时序数据添加到 ThingsBoard，供仪表板和分析使用。

{% include images-gallery.html imageCollection="thingsboard-generated-data" %}

## 步骤 4. 分析数据以检测异常

遥测就绪后，可请求 MCP 分析异常。

<b>示例查询：</b>

```text
Analyze AQI of Office #1 AQI Sensor for anomalies in the last 3 days and show results in a table.
```
{: .copy-code}

{% include images-gallery.html imageCollection="claude-analyze-anomaly" %}

MCP 将以表格形式返回异常检测结果：

{% include images-gallery.html imageCollection="claude-analyze-result" %}

## 实战场景中 MCP 的适用性

<b>ThingsBoard MCP Server</b>的应用远不止<b>AQI</b>传感器异常检测。可用于多种场景，包括：

- <b>工业 IoT 监控</b> — 检测机械振动、温度或压力的异常变化。
- <b>能源管理</b> — 识别智能电表的消费峰值并优化能耗。
- <b>环境监控</b> — 检测空气或水质突变并触发告警。
- <b>预测性维护</b> — 分析设备性能趋势，在故障发生前预测。
- <b>智慧城市应用</b> — 监控交通流量、路灯或垃圾收集异常。

将 MCP 的自然语言界面与 ThingsBoard 的数据可视化和告警能力相结合，您可快速原型化并部署各行业的 AI 驱动 IoT 解决方案。
