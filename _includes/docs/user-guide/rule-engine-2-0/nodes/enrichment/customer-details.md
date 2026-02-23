将消息来源实体的**客户**详情（如名称、邮箱、国家）添加到消息 data 或 metadata。

## 配置

节点配置允许选择要获取的客户详情及其在消息中的放置位置。

- **Select details**：要获取的客户详情集合。至少需选择一项。可用选项：
    * *Id*：客户的唯一标识符。
    * *Title*：客户名称。
    * *Country*：客户国家。
    * *State*：州/省。
    * *City*：城市。
    * *Zip*：邮编。
    * *Address*：主要街道地址。
    * *Address2*：次要街道地址。
    * *Email*：联系邮箱地址。
    * *Phone*：联系电话。
    * *Additional Info*：客户 `additionalInfo` JSON 对象中的 `description` 字段。
- **Add selected details to**：确定获取的客户详情的目标位置。
    * *Message*：将详情添加到消息 data 负载。消息 data 必须为 JSON 对象才能成功。
    * *Metadata*：将详情添加到消息 metadata。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGetCustomerDetailsNodeConfiguration",
  "type": "object",
  "properties": {
    "detailsList": {
      "type": "array",
      "description": "A set of customer details to fetch.",
      "items": {
        "type": "string",
        "enum": [
          "ID",
          "TITLE",
          "COUNTRY",
          "STATE",
          "CITY",
          "ZIP",
          "ADDRESS",
          "ADDRESS2",
          "EMAIL",
          "PHONE",
          "ADDITIONAL_INFO"
        ]
      }
    },
    "fetchTo": {
      "type": "string",
      "description": "Destination for the fetched details (message data or metadata).",
      "enum": [
        "DATA",
        "METADATA"
      ]
    }
  },
  "required": [
    "detailsList",
    "fetchTo"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别与入站消息来源实体关联的客户。例如，若来源实体为设备，节点获取该设备所分配到的客户。
2. 读取**Select details**集合以确定要获取的客户详情。
3. 节点异步从客户实体获取所选详情的值。
4. 对每个获取的详情，通过在详情名称前添加 `customer_` 创建新键。例如，选择 `Email` 得到键 `customer_email`，`Title` 得到 `customer_title`。
5. 若客户未设置所选详情，则跳过不添加到消息。
6. 根据**Add selected details to**设置，节点将结果键值对（如 `"customer_email": "info@example.com"`）添加到消息 data 或 metadata。
7. 丰富后的消息经 **Success** 连接转发。若发生错误（如来源实体未分配给客户，或尝试向非 JSON 消息 data 添加详情），原始消息经 **Failure** 连接路由。

## 输出连接

- **Success**：消息已成功使用客户详情丰富。
- **Failure**：处理过程中发生错误。例如，**Add selected details to** 设为 `Message` 但入站消息 data 不是有效 JSON 对象时，或消息来源实体未分配给客户时。

## 示例

### 示例 1：将客户联系信息添加到 metadata

**入站消息**

Metadata: `{}`

**节点配置**

```json
{
  "detailsList": [
    "TITLE",
    "EMAIL"
  ],
  "fetchTo": "METADATA"
}
```

**系统状态**

消息来源实体（如设备）分配给 title 为 `Company A`、邮箱为 `contact@companya.com` 的客户。

**出站消息**

节点将获取的详情添加到 metadata，消息经 `Success` 连接路由。

Metadata:

```json
{
  "customer_title": "Company A",
  "customer_email": "contact@companya.com"
}
```

**说明**：节点从客户获取 `Title` 和 `Email`，并以键 `customer_title` 和 `customer_email` 添加到消息 metadata。

### 示例 2：将客户位置添加到消息 data

**入站消息**：

Data: `{}`

**节点配置**：

```json
{
  "detailsList": [
    "COUNTRY"
  ],
  "fetchTo": "DATA"
}
```

**系统状态**

消息来源实体分配给国家设置为 `United States` 的客户。

**出站消息**

新键值对合并到消息 data 的 JSON 对象中。消息经 `Success` 连接路由。

Data:

```json
{
  "customer_country": "USA"
}
```

**说明**：节点从客户获取 `Country`，并以键 `customer_country` 添加到消息 data。
