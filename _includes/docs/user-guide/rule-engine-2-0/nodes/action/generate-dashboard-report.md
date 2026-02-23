根据指定配置截取仪表板并生成截图。仪表板由运行无头浏览器的独立 reports server 截取。生成的报表保存为 blob 实体，其 ID 添加到消息元数据的 `attachments` 键下。报表生成成功则消息路由到 `Success`，生成出错则路由到 `Failure`。

## 使用方法

生成仪表板报表的典型流程如下：

1. 消息到达「generate dashboard report」节点，消息数据中可包含完整报表配置，或节点使用其预配置的报表设置。

2. 节点请求 reports server（系统默认或自定义端点）生成仪表板报表。reports server 在无头浏览器中打开仪表板并截取截图。

3. 生成的报表以 blob 实体形式保存到 ThingsBoard，其 ID 追加到消息的 `attachments` 元数据字段。

4. 若报表成功生成并保存，消息经 `Success` 连接路由；若生成过程中出错，经 `Failure` 连接路由。

{% capture server_note %}
**需要 Reports server：** 使用此节点前，请确保 reports server 已正确配置且可访问。系统默认 reports server URL 由 `REPORTS_SERVER_ENDPOINT_URL` 环境变量控制（默认：`http://localhost:8383`）。
{% endcapture %}
{% include templates/info-banner.md content=server_note %}

## 配置

配置指定报表如何生成以及使用哪个 reports server。

- **Use system reports server** - 启用时使用 ThingsBoard 中配置的默认 reports server。禁用时需提供自定义 reports server 端点 URL。
- **Reports server endpoint URL** - 要使用的自定义 reports server URL（仅在 **Use system reports server** 禁用时适用）。
- **Use report config from message** - 启用时从传入消息的 `reportConfig` 字段读取报表配置。禁用时使用本节点中指定的报表配置。
- **Report configuration** - 要使用的仪表板报表配置（仅在 **Use report config from message** 禁用时适用）。包含仪表板 ID、时区、输出格式、timewindow 等设置。

### 报表配置结构

提供报表配置（在节点或消息中）时，使用以下字段：

- `baseUrl`（必填）- reports server 可访问的 ThingsBoard UI 基础 URL（如 "https://thingsboard.cloud"）
- `dashboardId`（必填）- 要截取的仪表板 UUID
- `state` - 报表生成时打开的仪表板状态
- `timezone`（必填）- 仪表板显示时区（如 "America/New_York"）
- `useDashboardTimewindow` - 若为 true，使用仪表板自身配置的 timewindow
- `timewindow` - 报表生成时使用的具体仪表板 timewindow 配置（JSON 对象）
- `namePattern`（必填）- 生成报表的文件名模式。支持在 `%d{}` 占位符内使用 [Java SimpleDateFormat](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/text/SimpleDateFormat.html){:target="_blank"} 语法进行日期格式化（如 "report-%d{yyyy-MM-dd_HH:mm:ss}"）
- `type` - 报表文件格式：PDF、PNG 或 JPEG（默认：PDF）
- `useCurrentUserCredentials` - 若为 true，使用创建报表配置的用户的凭证
- `userId`（必填）- 用于打开仪表板的用户凭证的 UUID

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGenerateReportNodeConfiguration",
  "type": "object",
  "properties": {
    "useSystemReportsServer": {
      "type": "boolean",
      "description": "Whether to use the system-configured reports server.",
      "default": true
    },
    "reportsServerEndpointUrl": {
      "type": "string",
      "format": "uri",
      "description": "Custom reports server endpoint URL (used when 'useSystemReportsServer' is false)."
    },
    "useReportConfigFromMessage": {
      "type": "boolean",
      "description": "Whether to read report configuration from the incoming message.",
      "default": true
    },
    "reportConfig": {
      "type": "object",
      "description": "Dashboard report configuration (used when 'useReportConfigFromMessage' is false).",
      "properties": {
        "baseUrl": {
          "type": "string",
          "format": "uri",
          "description": "Base URL of ThingsBoard UI accessible by the reports server."
        },
        "dashboardId": {
          "type": "string",
          "format": "uuid",
          "description": "UUID of the dashboard to capture."
        },
        "state": {
          "type": "string",
          "description": "Dashboard state to apply during report generation."
        },
        "timezone": {
          "type": "string",
          "description": "Timezone for the dashboard presentation."
        },
        "useDashboardTimewindow": {
          "type": "boolean",
          "description": "Whether to use the dashboard's configured timewindow."
        },
        "timewindow": {
          "type": "object",
          "description": "Specific timewindow configuration for the dashboard."
        },
        "namePattern": {
          "type": "string",
          "description": "File name pattern for the generated report."
        },
        "type": {
          "type": "string",
          "enum": [
            "PDF",
            "PNG",
            "JPEG"
          ],
          "description": "Report file format."
        },
        "useCurrentUserCredentials": {
          "type": "boolean",
          "description": "Whether to use the current user's credentials."
        },
        "userId": {
          "type": "string",
          "format": "uuid",
          "description": "UUID of the user whose credentials will be used."
        }
      },
      "required": [
        "baseUrl",
        "dashboardId",
        "timezone",
        "namePattern",
        "userId"
      ]
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点确定报表配置来源：
    - 若启用 **Use report config from message**，从传入消息数据中提取 `reportConfig`
    - 否则使用节点设置中指定的报表配置

2. 节点确定使用的 reports server：
    - 若启用 **Use system reports server**，使用默认系统 reports server
    - 否则使用自定义 reports server 端点 URL

3. 节点向 reports server 提交报表生成请求，server 将：
    - 在无头浏览器中打开指定仪表板
    - 应用指定仪表板状态和 timewindow
    - 以请求的格式截取截图

4. 生成的报表数据保存为 blob 实体，包含：
    - 二进制报表数据
    - 基于报表格式的 content type
    - 基于 name pattern 的报表名称
    - 与用户所属租户和客户的关联

5. blob 实体 ID 追加到消息元数据：
    - 若 `attachments` 元数据字段已存在，blob ID 以逗号分隔追加
    - 否则创建 `attachments` 字段并写入 blob ID

6. 更新后的消息经相应连接转发。

## 输出连接

- `Success`
    - 报表已成功生成并保存。传出消息在 `attachments` 元数据字段中包含 blob 实体 ID。
- `Failure`
    - 报表生成过程中出错，例如：
        - 消息中的报表配置无效
        - Reports server 不可用或不可达
        - 仪表板截图截取失败
        - blob 实体保存失败
        - 用户未找到

## 示例

### 示例 1 — 使用节点设置生成仪表板报表

**传入消息**

任意消息。

**节点配置**

```json
{
  "useSystemReportsServer": true,
  "reportsServerEndpointUrl": null,
  "useReportConfigFromMessage": false,
  "reportConfig": {
    "baseUrl": "http://localhost:8080",
    "useDashboardTimewindow": true,
    "timewindow": {
      "selectedTab": 1,
      "history": {
        "historyType": 0,
        "interval": 1000,
        "timewindowMs": 86400000
      }
    },
    "type": "pdf",
    "timezone": "America/New_York",
    "dashboardId": "31815190-a35d-11f0-84cf-d3d34cbac472",
    "state": "",
    "namePattern": "report-%d{yyyy-MM-dd_HH:mm:ss}",
    "useCurrentUserCredentials": true,
    "userId": "f5e2b870-a2d7-11f0-b6e3-69416924d372"
  }
}
```

**传出消息**

与传入消息完全相同的消息，并将 blob 实体 ID 添加到 `attachments` 元数据字段：

```json
{
  "attachments": "9f8e7d6c-5b4a-3c2b-1a0f-e9d8c7b6a5f4"
}
```

经 `Success` 连接路由。

**结果**

仪表板的 PDF 报表已生成，保存为 blob 实体，其 ID 已添加到消息元数据。
