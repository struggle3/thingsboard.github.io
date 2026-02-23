* TOC
{:toc}

[n8n](https://n8n.io/){: target="_blank"} 是一款工作流自动化平台，可让您将 ThingsBoard 与数百种其他服务连接起来。

[ThingsBoard n8n Node](https://github.com/thingsboard/thingsboard-n8n-node){: target="_blank"} 使您能够从 n8n 工作流中直接访问 IoT 实体、遥测和告警。

- 直接从 n8n 工作流中**管理 IoT 设备、资产和客户**
- 通过属性和时序操作**实时访问和操作遥测数据**
- **监控告警**并根据告警严重程度和类型创建自动化响应
- **浏览实体关系**以了解 IoT 基础设施拓扑
- 使用 n8n AI Agents 的**自然语言命令构建 AI 驱动的 IoT 自动化**

## 快速入门：您的第一个工作流

以下为 5 分钟内即可搭建的内容——将 IoT 遥测导出到云存储的实战数据管道。

**场景**：每天午夜自动将过去 24 小时的设备遥测导出为 JSON 文件到 AWS S3，用于数据仓库、分析或合规归档。

**工作流**：
```
Schedule (Daily at 00:00 UTC)
    ↓
Code node (calculate last 24h time range in MS)
    ↓
ThingsBoard: Get device by a name
    ↓
ThingsBoard: Get timeseries data for device
    ↓
Convert to File (JSON format)
    ↓
Upload to AWS S3
```

{% assign quickExample = '
    ===
        image: /images/samples/analytics/n8n-node/quick-example.png
        title: The complete workflow showing all nodes: Schedule trigger → Code (time calc) → Get device → Get timeseries → Convert to file → AWS S3 upload.
    ===
        image: /images/samples/analytics/n8n-node/quick-example-result.png
        title: Successful execution result showing the telemetry data exported to S3 as a JSON file.
'
%}

{% include images-gallery.liquid imageCollection=quickExample %}

这是用于 IoT 数据归档、分析管道和合规日志的生产级模式。

想查看完整的分步演练和代码细节？安装后跳转到 [示例 2：每日遥测导出到 AWS S3](#example-2-daily-telemetry-export-to-aws-s3)。

## 何时将 n8n 与 ThingsBoard 配合使用

ThingsBoard 的规则引擎非常适合 IoT 专项自动化。但当您需要连接到 ThingsBoard 未原生集成的外部系统时，n8n 可以填补这一空白。

**在以下情况使用 n8n**：
- 将遥测归档到 **AWS S3**、**Google Cloud Storage** 或 **Azure Blob** 用于数据仓库
- 将数据导出到 **数据库**（PostgreSQL、Snowflake、ClickHouse）用于分析
- 在 **Jira**、**ServiceNow** 或其他工单系统中创建工单
- 将设备数据与 **CRM**（Salesforce、HubSpot）或 **ERP** 同步
- 让非技术人员通过 **AI 聊天**编写查询

## 前置条件

开始前，请确保满足以下条件：

{% if docsPrefix == nil or docsPrefix == "pe/" %}
- **ThingsBoard 实例**：
    - **本地/私有部署实例**：在您自己的[基础设施](/docs/{{docsPrefix}}user-guide/install/installation-options/){: target="_blank"}上自托管的 ThingsBoard 安装，或
{% endif %}
{% if docsPrefix == nil or docsPrefix == "pe/" %}
    - **ThingsBoard Cloud**：完全托管的云服务，可在[此处](https://thingsboard.io/installations/choose-region/){: target="_blank"}获取
{% endif %}
{% if docsPrefix == "paas/" %}
- **ThingsBoard Cloud**：完全托管的云服务，可在 [thingsboard.cloud](https://thingsboard.cloud/signup){: target="_blank"} 获取
{% endif %}
{% if docsPrefix == "paas/eu/" %}
- **EU ThingsBoard Cloud**：完全托管的云服务，可在 [eu.thingsboard.cloud](https://eu.thingsboard.cloud/signup){: target="_blank"} 获取
{% endif %}
- **认证凭据**：ThingsBoard 实例上具有适当权限的有效用户名和密码
- **n8n 实例**：
    - **本地 n8n 安装**：在您的基础设施上自托管的 n8n，或
    - **基于 Docker 的 n8n 部署**：在 Docker 容器中运行的 n8n
    - **n8n Cloud**：ThingsBoard 节点需通过官方验证才能列入 n8n Cloud 目录

## 安装

开始前，请确保 n8n 已运行。如需安装，请参阅[官方 n8n 文档](https://docs.n8n.io/){: target="_blank"}。

### 安装 ThingsBoard 节点

{% capture difference %}
**注意：** 社区节点要求在 n8n 环境中设置 `N8N_COMMUNITY_PACKAGES_ENABLED=true`。大多数 n8n 安装默认已启用。若在设置中看不到 Community Nodes 区域，需在启动 n8n 前设置该变量。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**推荐：使用 n8n GUI**（用于自托管实例）：

1. 在浏览器中打开 n8n
2. 点击左下角**三个点** → **Settings** → **Community Nodes**
3. 点击 **Install a community node**
4. 输入：`@thingsboard/n8n-nodes-thingsboard` 并点击 **Install**
5. 刷新浏览器

{% assign n8nGuiInstallation = '
    ===
        image: /images/samples/analytics/n8n-node/n8n-gui-installation-1.png
        title: Open **n8n** in your browser. In the bottom-left corner, click the **three dots** button and select **Settings** from the dropdown menu.
   ===
        image: /images/samples/analytics/n8n-node/n8n-gui-installation-2.png
        title: Go to the **Community Nodes** tab and click **Install a community node**.
   ===
        image: /images/samples/analytics/n8n-node/n8n-gui-installation-3.png
        title: Enter the package name: `@thingsboard/n8n-nodes-thingsboard` and click **Install**.
    ===
        image: /images/samples/analytics/n8n-node/n8n-gui-installation-4.png
        title: Wait for the installation to complete. Then, refresh the browser page.
'
%}

{% include images-gallery.liquid imageCollection=n8nGuiInstallation %}

### 配置 AI Agent 支持（可选）

若仅在常规工作流中使用该节点（不与 AI agents 配合），可跳过此步骤。

若要让 AI agents 将 ThingsBoard 用作工具，在启动 n8n 前添加以下**额外**环境变量：

```text
N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
```
{: .copy-code}

**如何设置**：
- **Docker**：添加到 `docker-compose.yml` 的 environment 部分（与 `N8N_COMMUNITY_PACKAGES_ENABLED=true` 一并）
- **npm/本地**：在 shell 中导出：`N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true n8n start`

### 配置凭据

将 n8n 连接到 ThingsBoard 实例：

1. 点击左上角 **+** → **Credentials**
2. 搜索 **ThingsBoard API** → **Continue**
3. 填写 ThingsBoard 信息：
   - **Base URL**：您的实例 URL（例如 {% if docsPrefix == "paas/eu/" %}`https://eu.thingsboard.cloud`{% else %}`https://thingsboard.cloud`{% endif %}）
   - **Username**：您的邮箱
   - **Password**：您的密码
4. 点击 **Save**

这些凭据可在工作流中所有 ThingsBoard 节点间共用。


{% assign n8nGuiInstallation = '
    ===
        image: /images/samples/analytics/n8n-node/credentials-configuration-1.png
        title: In the top-left corner, click **+** and select **Credentials** from the dropdown menu.
    ===
        image: /images/samples/analytics/n8n-node/credentials-configuration-2.png
        title: Search and select **ThingsBoard API** to connect to and click **Continue**.
    ===
        image: /images/samples/analytics/n8n-node/credentials-configuration-3.png
        title: Fill in the required fields:<br>- **Base URL** — your ThingsBoard instance URL (without a trailing slash)<br>- **Username** — your ThingsBoard account username<br>- **Password** — your ThingsBoard account password.<br>Click **Save** to store the credentials.
    ===
        image: /images/samples/analytics/n8n-node/credentials-configuration-4.png
        title: The credentials are encrypted and stored securely by n8n. You can reuse the same credentials across multiple ThingsBoard nodes in different workflows.
'
%}

{% include images-gallery.liquid imageCollection=n8nGuiInstallation %}

### 验证安装

安装节点并重启 n8n 后，验证 ThingsBoard 节点是否可用：

1. 在浏览器中**打开 n8n**（通常是 [http://localhost:5678](http://localhost:5678){:target="_blank"})
2. **创建新工作流** - 点击右上角 **Create Workflow**
3. **添加节点** - 点击工作流画布上的 **+** 按钮
4. **搜索 ThingsBoard** - 在搜索框输入 "ThingsBoard"
5. **验证节点出现** - 应看到 ThingsBoard 节点及其可用操作

{% assign installationVerification = '
    ===
        image: /images/samples/analytics/n8n-node/installation-verification-1.png
        title: In the top-right corner of the interface, click Create Workflow.
    ===
        image: /images/samples/analytics/n8n-node/installation-verification-2.png
        title: On the workflow canvas, click the **+** button to open the list of available nodes.
    ===
        image: /images/samples/analytics/n8n-node/installation-verification-3.png
        title: In the node search field, type **ThingsBoard**. The **ThingsBoard node** should appear in the search results. Click on it.
    ===
        image: /images/samples/analytics/n8n-node/installation-verification-4.png
        title: A list of available **actions** will be displayed.
'
%}

{% include images-gallery.liquid imageCollection=installationVerification %}

**注意**：社区版和专业版的操作数量可能不同。

**若看不到节点**：
- 确认已设置 `N8N_COMMUNITY_PACKAGES_ENABLED=true`
- 检查 npm 安装是否无错误完成
- 安装后重启 n8n
- 在 n8n 日志中查看加载错误

## 如何使用节点

{% assign n8nUsageNode = '
    ===
        image: /images/samples/analytics/n8n-node/thingsboard-n8n-node.png
        title: A ThingsBoard Node and a ThingsBoard Tool for AI Agent.
'
%}

{% include images-gallery.html imageCollection=n8nUsageNode %}



使用 ThingsBoard 节点有两种方式：

### 1. 常规工作流节点

将 ThingsBoard 节点拖到画布上，配置要执行的操作（获取设备、保存遥测、创建告警等）。

适用于：
- 定时任务（每日报告、健康检查）
- Webhook（传入传感器数据、外部触发）
- 多步骤工作流（获取设备 → 拉取遥测 → 发送到 Slack）

### 2. AI Agent 工具

为 AI agent 提供 ThingsBoard 操作访问权限。用户随后可用自然语言提问，而无需构建工作流。

适用于：
- 非技术人员查询实体、数据等
- 支持团队排查问题

**配置要求**：参见上方 [AI Agent 配置](#configure-ai-agent-support-optional)。

查看下方 [示例](#usage-examples) 了解两种方式的实战用法。

## 常见工作流模式

**将遥测归档到云存储**：Schedule（每日）→ Code（计算时间范围）→ Get timeseries → Convert to file → S3/GCS 上传

**根据告警创建工单**：Webhook（告警）→ 检查严重程度 → 创建 Jira/ServiceNow 工单

**客户入职自动化**：CRM webhook（新客户）→ 创建设备和仪表板 → 分配给客户

**AI 驱动的查询**：Chat → AI Agent → ThingsBoard 操作 → 自然语言响应

## 使用示例

本节提供演示 ThingsBoard n8n 节点三种使用模式的实用示例。

### 示例 1：AI Agent

**实战场景**：用纯文本提问，检查实体、状态、查询数据、更新配置等。

**意义**：
- 只需提出需求（「哪些设备离线？」、「显示今日温度」），节点会处理技术细节。
- 减少 IoT 运营中的瓶颈

**配置**：将 ThingsBoard 节点用作 **AI Agents 的工具**，实现对话式 IoT 控制

{% assign example1 = '
    ===
        image: /images/samples/analytics/n8n-node/example-1-1-0.png
        title: Create a new workflow with AI Agent node. Choose your AI Model (Gemini, Anthropic, ChatGPT, etc.) and configure memory settings.
    ===
        image: /images/samples/analytics/n8n-node/example-1-1-1.png
        title: Select ThingsBoard from the Tools list. Add **Get devices** and **Get timeseries** operations.
    ===
        image: /images/samples/analytics/n8n-node/ai-agent-define-parameter.png
        title: For tools with required or optional fields, the AI model intelligently determines parameter values based on conversation context. The model decides which values to pass automatically.
    ===
        image: /images/samples/analytics/n8n-node/example-1-2.png
        title: Open the chat interface and write your natural language query.
'
%}

{% include images-gallery.liquid imageCollection=example1 %}

**工作流程**：
1. 用户提问：*「仓库中哪些冰柜温度高于 -10°C？」*
2. AI Agent（基于 Google Gemini、Anthropic 或 OpenAI）自动：
   - 调用 `Get devices` 查找所有冰柜设备
   - 调用 `Get timeseries` 获取温度读数
   - 过滤结果并以自然语言回复
3. 无需代码或 API 知识

**团队可问的实际查询**：
- *「显示过去 24 小时内未发送数据的设备」*
- *「冰柜 3 当前温度是多少？」*
- *「Building A 中有哪些传感器？」*
- *「获取所有仓库传感器过去一周的湿度数据」*

这将使 IoT 访问民主化——任何人都可在不了解 ThingsBoard API 的情况下查询基础设施。

---

### 示例 2：每日遥测导出到 AWS S3

**实战场景**：每晚将设备遥测导出到 S3，同时用 CRM 中的设备元数据丰富数据，转换为 Parquet 格式供 Athena 使用，并触发 Lambda 函数更新数据仓库。一个工作流，多种输出。

**为何用 n8n 而非 ThingsBoard 原生导出**：
- **多目的地** - 在同一工作流中将相同数据发送到 S3 + Snowflake + 邮件报告
- **数据转换** - 用业务上下文丰富遥测（客户名称、CRM 中的位置）
- **自定义格式** - 转换为 Parquet、Avro 或 CSV，并为分析工具提供特定 schema
- **条件逻辑** - 仅导出特定设备、按客户层级过滤或存储前聚合
- **集成链** - S3 上传后 → 触发 AWS Lambda → 更新追踪数据库 → 发送 Slack 通知

---

<b><font size="4">构建工作流</font></b>

<b><font size="3">步骤 1：创建新工作流并添加 Schedule Trigger</font></b>

创建新工作流并添加 Schedule Trigger，在 UTC 午夜每日执行导出。

**配置**：
- 点击 **Add first step…** → 选择 **Schedule Trigger**
- 设置 **Trigger Interval**：每天 00:00（午夜）
- 确保导出每 24 小时自动运行

{% assign example21 = '
    ===
        image: /images/samples/analytics/n8n-node/example-2-1.png
        title: Create a new workflow and select **Schedule Trigger** to run the export daily.
    ===
        image: /images/samples/analytics/n8n-node/example-2-2.png
        title: Configure the trigger to run every day at 00:00 UTC (midnight).
'
%}

{% include images-gallery.liquid imageCollection=example21 %}

<br>**您已完成**：设置 UTC 午夜每日自动执行。

---

<b><font size="3">步骤 2：添加 Code 节点计算时间范围</font></b>

ThingsBoard API 需要毫秒时间戳。添加 Code 节点计算精确的 24 小时时间范围。

**配置**：
- 在 Schedule 节点后点击 **+** → 选择 **Code**
- 粘贴以下代码：

```javascript
const DAY_MS = 24 * 60 * 60 * 1000;  // 24 hours in milliseconds
const endTsMs = new Date($input.first().json.timestamp).getTime()  // Current time in MS
const startTsMs = endTsMs - DAY_MS;  // 24 hours ago in MS

return [{ startTsMs, endTsMs }];  // Pass to next node
```
{: .copy-code}

- 点击 **Execute node** 进行测试

{% assign example22 = '
    ===
        image: /images/samples/analytics/n8n-node/example-2-3.png
        title: Add a **Code** node after the Schedule Trigger.
    ===
        image: /images/samples/analytics/n8n-node/example-2-4.png
        title: Paste the time calculation code and click **Execute node** to test it.
'
%}

{% include images-gallery.liquid imageCollection=example22 %}

<br>**您将得到**：表示精确 24 小时数据的两个时间戳（startTsMs 和 endTsMs）。

---

<b><font size="3">步骤 3：从 ThingsBoard 按名称获取设备</font></b>

现在获取要导出遥测的目标设备。

**配置**：
- 点击 **+** → **ThingsBoard** → **Get a device by name**
- **Device Name**：输入设备名称（如 "Temperature Sensor 1"）
- 点击 **Execute node**

{% assign example23 = '
    ===
        image: /images/samples/analytics/n8n-node/example-2-5.png
        title: Add ThingsBoard node and select **Get a device by name**.
    ===
        image: /images/samples/analytics/n8n-node/example-2-6.png
        title: Enter the device name and execute to retrieve the device object.
'
%}

{% include images-gallery.liquid imageCollection=example23 %}

<br>**您将得到**：完整设备对象，包括下一步所需的 ID、类型和元数据。

---

<b><font size="3">步骤 4：获取设备的时序数据</font></b>

使用 Code 节点计算的时间范围拉取遥测数据。

**配置**：
- 点击 **+** → **ThingsBoard** → **Get timeseries**
- 从 **INPUT 面板**（左侧）拖入值：
  - **Entity ID**：来自 "Get a device by name" → id → id
  - **Entity Type**：来自 "Get a device by name" → id → entityType
  - **Start timestamp**：来自 Code 节点 → startTsMs
  - **End timestamp**：来自 Code 节点 → endTsMs
  - **Keys**：输入需要的遥测键（如 "temperature,humidity"）
- 点击 **Execute node**

{% assign example24 = '
    ===
        image: /images/samples/analytics/n8n-node/example-2-7.png
        title: Add ThingsBoard **Get timeseries** node.
    ===
        image: /images/samples/analytics/n8n-node/example-2-8.png
        title: Configure with device ID, entity type, and time range from previous nodes. Execute to fetch telemetry data.
'
%}

{% include images-gallery.liquid imageCollection=example24 %}

<br>**您将得到**：设备过去 24 小时遥测数据的 JSON 格式。

---

<b><font size="3">步骤 5：构建逻辑并上传到 AWS S3</font></b>

最后，将文件上传到 S3 存储桶。

**配置**：
- 点击 **+** → **AWS S3**
- **Operation**：Upload
- **Bucket Name**：您的 S3 存储桶名称
- **File Name**：使用表达式生成带日期的文件名（如 `telemetry-{{ $now.format('yyyy-MM-dd') }}.json`）
- 配置 AWS 凭据
- 点击 **Execute node**

{% assign example26 = '
    ===
        image: /images/samples/analytics/n8n-node/example-2-10.png
        title: Add **AWS S3** node and configure upload settings with your bucket name and credentials.
    ===
        image: /images/samples/analytics/n8n-node/example-2-11.png
        title: Execute the workflow to see the file successfully uploaded to S3.
'
%}

{% include images-gallery.liquid imageCollection=example26 %}

<br>**您将得到**：遥测数据已成功上传到 S3，文件名带有日期戳。

---

<b><font size="4">最终结果</font></b>

您已构建完整的自动化数据管道：
1. 每夜 UTC 午夜运行
2. 计算精确的 24 小时时间窗口
3. 从 ThingsBoard 拉取设备遥测
4. 转换为文件格式
5. 以可预测命名上传到 AWS S3

**您将获得**：
- S3 中的每日 JSON 文件：`s3://my-bucket/telemetry-2024-12-23.json`
- 无需人工干预的自动备份
- 可直接用于 AWS Athena 查询或数据管道摄入的数据
- 每日导出的完整审计追踪

**强大之处**：
n8n 作为 ThingsBoard 与数据生态系统之间的编排层。您不仅是在导出数据——而是在构建包含转换、丰富和多系统集成的完整数据管道，这些是 ThingsBoard 单独无法完成的。

**下一步 - 扩展此工作流**：
- **添加多目的地**：在 "Convert to File" 后分流，同时发送到 Snowflake、Google Sheets 或邮件
- **丰富数据**：在 S3 上传前与 CRM 数据合并或添加业务上下文
- **条件路由**：将高价值客户路由到高级存储，其他到标准存储
- **触发下游操作**：S3 上传后 → 触发 AWS Lambda → 更新库存系统 → 通知团队

---

### 示例 3：Webhook 触发的设备查询

**实战场景**：客户门户有「获取设备状态」按钮。点击后需要获取客户所拥有设备的实时遥测——您事先不知道具体设备。

**为何需要该模式？** 大多数实战工作流是动态的：
- 按名称（而非硬编码 ID）查询设备的移动应用
- 响应「检查 Room 405 温度」的聊天机器人
- 为特定资产触发报告的外部系统
- 按用户过滤的客户仪表板

**您将学到**：如何将 ThingsBoard 操作串联，在节点间传递数据（设备名称 → 设备 ID → 遥测键 → 实际数据）。

---

<b><font size="4">构建工作流</font></b>

<b><font size="3">步骤 1：设置触发器（模拟 webhook）</font></b>

我们将使用手动触发器模拟通常来自客户门户的 webhook。

**配置**：
- 点击 **Add first step…** → **Trigger manually**
- 点击触发器节点 → 点击右上角**铅笔图标**
- 粘贴以下 JSON（模拟传入 webhook 数据）：

```json
{
  "deviceName": "Refrigerator"
}
```
{:.copy-code}

- 保存更改
- **返回画布**

{% assign example31 = '
    ===
        image: /images/samples/analytics/n8n-node/example-3-1-1.png
        title: Click **Add first step…** and select **Trigger manually**.
    ===
        image: /images/samples/analytics/n8n-node/example-3-1-2.png
        title: Click on the trigger node to open its configuration.
    ===
        image: /images/samples/analytics/n8n-node/example-3-1-3.png
        title: In the top-right corner, click the **pencil** icon.
    ===
        image: /images/samples/analytics/n8n-node/example-3-1-4.png
        title: Paste the following JSON into the input field. **Save** the changes and **back to canvas**.
'
%}

{% include images-gallery.liquid imageCollection=example31 %}

<br>**您已完成**：创建工作流输入，接受设备名称。在生产环境中，这将来自 webhook、API 调用或聊天消息。

---

<b><font size="3">步骤 2：在 ThingsBoard 中查找设备</font></b>

现在需要按名称查找设备以获取其 ID（因为大多数 ThingsBoard 操作需要设备 ID，而非名称）。

**配置**：
- 在触发器节点旁点击 **+** → **ThingsBoard** → **Get device by name**
- 从 **INPUT 面板**（左侧）将 `deviceName` 拖入 **Name** 字段

  *这将创建动态链接——节点将使用触发器中出现的设备名称*

- 点击 **Execute step** 进行测试
- **返回画布**

{% assign example32 = '
    ===
        image: /images/samples/analytics/n8n-node/example-3-2-1.png
        title: Click the **+** button to the right of the **trigger node**.
    ===
        image: /images/samples/analytics/n8n-node/example-3-2-2.png
        title: Find and select **ThingsBoard**
    ===
        image: /images/samples/analytics/n8n-node/example-3-2-3.png
        title: Choose **Get a device by name** action.
    ===
        image: /images/samples/analytics/n8n-node/example-3-2-4.png
        title: Drag **deviceName** from the **INPUT** panel (left side) into the **Name** field. This creates a dynamic reference to the trigger input.
    ===
        image: /images/samples/analytics/n8n-node/example-3-2-5.png
        title: Click **Execute step**
    ===
        image: /images/samples/analytics/n8n-node/example-3-2-6.png
        title: The node returns the full device object, including:<br>- device ID<br>- <span class="code-light">type</span><br>- additional metadata<br>**Back to canvas**.
'
%}

{% include images-gallery.liquid imageCollection=example32 %}

<br>**您将得到**：完整设备对象——包括下一步所需的 ID。

---

<b><font size="3">步骤 3：发现该设备的遥测键</font></b>

在拉取遥测前，需要了解有哪些可用键（温度？湿度？电量？）。此步骤将查明这一点。

**配置**：
- 点击 **+** → **ThingsBoard** → **Get timeseries keys**
- 从 **INPUT 面板**（左侧）拖入 **Entity ID** 和 **Entity Type**

  *我们自动使用步骤 2 中的设备信息*

- 点击 **Execute step**
- **返回画布**

{% assign example33 = '
    ===
        image: /images/samples/analytics/n8n-node/example-3-3-1.png
        title: - Click the **+** button to the right of the **Get a device by name** node.<br>- Select **ThingsBoard**<br>- Choose **Get timeseries keys** action.
    ===
        image: /images/samples/analytics/n8n-node/example-3-3-2.png
        title: - Set parameters dynamically:<br>- Entity ID<br>- Entity Type<br>You can drag these values directly from the **INPUT** panel (left side).<br>- Click **Execute step**<br>- **Back to canvas**
'
%}

{% include images-gallery.liquid imageCollection=example33 %}

<br>**您将得到**：可用遥测键列表（如 `temperature`、`humidity` 等）

---

<b><font size="3">步骤 4：拉取实际遥测数据</font></b>

最后，使用刚发现的键获取实际传感器读数。

**配置**：
- 在 Get timeseries keys 节点右侧点击 **+** 按钮。
- 选择 **ThingsBoard**
- 选择 **Get timeseries** 操作
- 配置参数：
  - Get a device by name -> id -> **id** 到 **Entity ID**
  - Get a device by name -> id -> **entityType** 到 **Entity Type**
  - Get timeseries keys -> **timeseriesKeys** 到 **Keys (Comma Separated)**

  **注意**：Keys 字段需要逗号分隔的值。由于步骤 3 返回数组，需要拼接：`{{ $json.timeseriesKeys.join(',') }}`

- 点击 **Execute step**
- **返回画布**

{% assign example34 = '
    ===
        image: /images/samples/analytics/n8n-node/example-3-4-1.png
        title: Click the **+** button to the right of the trigger node.<br>Select **ThingsBoard**.<br>Choose **Get timeseries action**.
    ===
        image: /images/samples/analytics/n8n-node/example-3-4-2.png
        title: Configure parameters:<br>- **Entity ID**<br>- **Entity Type**<br>- **Keys (Comma Separated)**<br>You can drag these values directly from the **INPUT** panel (left side).<br>- Click **Execute step**.<br>- **Back to canvas**.
'
%}

{% include images-gallery.liquid imageCollection=example34 %}

<br>**您将得到**：真实遥测数据！温度、湿度或该设备拥有的任意传感器数据。

---

<b><font size="4">意义</font></b>

您已构建完全可复用的工作流。将输入从 "Refrigerator" 改为 "Freezer 3" 即可自动生效。无需硬编码 ID，也无需任何修改。

**该模式支持**：
1. 客户门户 - 每位用户看到自己的设备
2. 聊天机器人 -「检查 Room 405 的空调」即可工作
3. 移动应用 - 按名称查询任意设备
4. 多租户系统 - 相同工作流，不同数据

{% assign ruleChainUseCase = '
    ===
        image: /images/samples/analytics/n8n-node/example-3-final-1.png
        title: Accepts a device name as input. Finds the corresponding device in ThingsBoard.
    ===
        image: /images/samples/analytics/n8n-node/example-3-final-2.png
        title: Discovers available telemetry keys.
    ===
        image: /images/samples/analytics/n8n-node/example-3-final-3.png
        title: Retrieves telemetry values for the specified time window.
'
%}

{% include images-gallery.liquid imageCollection=ruleChainUseCase %}

<b><font size="4">下一步</font></b>

- 用 **Webhook** 替换手动触发器，连接客户门户
- 在末尾添加 **Slack** 或 **Email** 节点发送遥测数据
- 使用 **Schedule** 触发器每小时运行以进行监控
- 连接到 **AI Agent**，让用户可在聊天中询问「检查设备 X」

## API 参考

ThingsBoard n8n 节点基于 ThingsBoard REST API 构建。有关 API 端点、请求/响应格式和附加参数的详细信息，请参阅 [ThingsBoard REST API 文档](https://thingsboard.io/docs/{{docsPrefix}}reference/rest-api/){: target="_blank"}。

## 链接

- **npm 包**：[@thingsboard/n8n-nodes-thingsboard](https://www.npmjs.com/package/@thingsboard/n8n-nodes-thingsboard){: target="_blank"}
- **GitHub 仓库**：[thingsboard/thingsboard-n8n-node](https://github.com/thingsboard/thingsboard-n8n-node){: target="_blank"}
- **n8n 文档**：[docs.n8n.io](https://docs.n8n.io/){: target="_blank"}
- **n8n 社区**：[community.n8n.io](https://community.n8n.io/){: target="_blank"}
- **ThingsBoard REST API**：[REST API 参考](/docs/{{docsPrefix}}reference/rest-api/){: target="_blank"}

## 支持

若遇到问题或对 ThingsBoard n8n 节点有疑问：

- **GitHub Issues**：[报告错误或请求功能](https://github.com/thingsboard/thingsboard-n8n-node/issues){: target="_blank"}
- **ThingsBoard 社区**：[从社区获取帮助](https://thingsboard.io/community/){: target="_blank"}
- **n8n 社区**：[n8n 社区](https://community.n8n.io/){: target="_blank"}

## 许可证

MIT 许可证 - 详见 [LICENSE 文件](https://github.com/thingsboard/thingsboard-n8n-node/blob/master/LICENSE.md){: target="_blank"}。

---
