根据报表模板生成报表。通过任务管理器创建「报表生成」任务异步生成报表。生成完成后，报表 ID 会添加到消息元数据的 `reports` 键下，并根据生成成功与否将消息路由到 `Success` 或 `Failure` 连接。

{% capture template_note %}
**需要报表模板：** 使用此节点前，需先在 ThingsBoard 中创建报表模板。报表模板定义生成报表的结构和内容。
{% endcapture %}
{% include templates/info-banner.md content=template_note %}

## 配置

节点支持两种获取报表配置的模式：

1. **从消息获取报表配置** - 节点从传入消息数据中提取所有报表设置。适用于报表参数动态确定的场景。

2. **从节点设置获取报表配置** - 节点使用配置表单中直接指定的报表设置。适用于使用静态、预定义参数生成报表的场景。

通过 **Use report config from message** 复选框控制模式。

### 配置字段

当 **Use report config from message** 禁用时，以下配置字段可用：

#### 通用报表设置

- **Report template**（必填）- 用于生成报表的报表模板。从租户中可用模板中选择。启用 **Use report config from
  message** 时，此值从传入消息的 `reportTemplateId` 字段读取。

- **User**（必填）- 生成报表时使用的用户凭证。决定报表生成时的访问权限和数据可见性。启用 **Use
  report config from message** 时，此值从传入消息的 `userId` 字段读取。

- **Timezone**（必填）- 报表生成时区（如 "America/New_York"）。影响报表中时间戳和基于时间的数据显示。启用 **Use report config from message** 时，此值从传入消息的 `timezone` 字段读取。

#### 接收者

- **Notification targets** - 报表生成时需通知的接收者集合。若不需要发送通知则留空。启用 **Use report config from
  message** 时，此值从传入消息的 `targets` 字段（UUID 数组）读取。

- **Notification template** - 用于发送报表生成通知的模板。仅当指定了 notification targets 时适用。
  启用 **Use report config from message** 时，此值从传入消息的 `notificationTemplateId` 字段读取。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGenerateReportV2NodeConfiguration",
  "type": "object",
  "properties": {
    "useConfigFromMessage": {
      "type": "boolean",
      "description": "Whether to read report configuration from the incoming message.",
      "default": false
    },
    "config": {
      "type": "object",
      "description": "Report configuration (used when 'useConfigFromMessage' is false).",
      "properties": {
        "reportTemplateId": {
          "type": "object",
          "description": "Report template identifier.",
          "properties": {
            "entityType": {
              "type": "string",
              "const": "REPORT_TEMPLATE"
            },
            "id": {
              "type": "string",
              "format": "uuid"
            }
          },
          "required": [
            "entityType",
            "id"
          ]
        },
        "userId": {
          "type": "object",
          "description": "User identifier.",
          "properties": {
            "entityType": {
              "type": "string",
              "const": "USER"
            },
            "id": {
              "type": "string",
              "format": "uuid"
            }
          },
          "required": [
            "entityType",
            "id"
          ]
        },
        "timezone": {
          "type": "string",
          "description": "Timezone for report generation.",
          "example": "Europe/Kiev"
        },
        "targets": {
          "type": "array",
          "items": {
            "type": "string",
            "format": "uuid"
          },
          "description": "Set of notification target UUIDs."
        },
        "notificationTemplateId": {
          "type": "object",
          "description": "Notification template identifier.",
          "properties": {
            "entityType": {
              "type": "string",
              "const": "NOTIFICATION_TEMPLATE"
            },
            "id": {
              "type": "string",
              "format": "uuid"
            }
          },
          "required": [
            "entityType",
            "id"
          ]
        }
      },
      "required": [
        "reportTemplateId",
        "userId",
        "timezone"
      ]
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点确定报表配置来源：
    - 若启用 **Use report config from message**，则从传入消息数据中提取报表配置
    - 否则使用节点设置中指定的报表配置

2. 节点使用第 1 步的配置创建报表生成任务。

3. 报表生成任务提交到任务管理器进行异步处理。

4. 报表生成完成后，将生成的报表 ID 添加到消息元数据：
    - 添加到 `reports` 元数据字段

5. 更新后的消息经相应连接转发：
    - 报表生成成功则走 `Success`
    - 生成过程中出错则走 `Failure`

## 输出连接

- `Success`
    - 报表已成功生成。传出消息在 `reports` 元数据字段中包含生成的报表 ID。
- `Failure`
    - 报表生成过程中出错，例如：
        - 无效或缺失报表配置
        - 报表模板未找到
        - 用户未找到
        - 报表生成失败
        - 任务提交到任务管理器失败

## 示例

### 示例 1 — 使用节点设置生成报表

**传入消息**

任意消息。

**节点配置**

```json
{
  "useConfigFromMessage": false,
  "config": {
    "reportTemplateId": {
      "entityType": "REPORT_TEMPLATE",
      "id": "31815190-a35d-11f0-84cf-d3d34cbac472"
    },
    "userId": {
      "entityType": "USER",
      "id": "f5e2b870-a2d7-11f0-b6e3-69416924d372"
    },
    "timezone": "America/New_York",
    "targets": [
      "9a8b7c6d-5e4f-3a2b-1c0d-e9f8a7b6c5d4"
    ],
    "notificationTemplateId": {
      "entityType": "NOTIFICATION_TEMPLATE",
      "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e"
    }
  }
}
```

**传出消息**

与传入消息完全相同的消息，并将生成的报表 ID 添加到 `reports` 元数据字段：

```json
{
  "reports": "7f8e9d0c-1a2b-3c4d-5e6f-7a8b9c0d1e2f"
}
```

经 `Success` 连接路由。

**结果**

创建报表生成任务并异步处理。完成后，将生成的报表 ID 添加到消息元数据，并向配置的接收者发送通知。

---

### 示例 2 — 使用消息配置生成报表

**传入消息**

```json
{
  "reportTemplateId": {
    "entityType": "REPORT_TEMPLATE",
    "id": "42916201-b46e-22g1-95dg-e4e45dcbd583"
  },
  "userId": {
    "entityType": "USER",
    "id": "06f3c981-b3e8-22g1-c7f4-7a527835e483"
  },
  "timezone": "America/New_York"
}
```

**Node configuration**

```json
{
  "useConfigFromMessage": true,
  "config": null
}
```

**传出消息**

与传入消息完全相同的消息，并将报表作业 ID 添加到 `reports` 元数据字段：

```json
{
  "reports": "8g9f0e1d-2b3c-4d5e-6f7a-8b9c0d1e2f3a"
}
```

经 `Success` 连接路由。

**结果**

根据消息数据中的配置创建报表生成作业。报表将异步生成，且不发送通知（因未指定 targets）。
