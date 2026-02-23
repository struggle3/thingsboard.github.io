"attributeUpdates" 配置允许设置将发送到服务器的对应 attribute 数据格式。

| **参数**          | **默认值** | **说明**                                             |
|:-----------------------|:------------------|-------------------------------------------------------------|
| encoding               | **utf-16**        | 将接收到的字符串数据写入存储时使用的编码。 |
| attributeOnThingsBoard | **sharedName**    | Shared attribute 名称                                       |
| ---                    |                   |                                                             |

配置文件中本小节如下所示：

```json
"attributeUpdates": [
  {
    "encoding": "utf-16",
    "attributeOnThingsBoard": "sharedName"
  }
]
```

![image](/images/gateway/socket-connector/socket-subsection-attribute-updates-advanced-1-ce.png)
