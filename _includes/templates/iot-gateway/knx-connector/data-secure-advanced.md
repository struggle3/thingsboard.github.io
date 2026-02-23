保护任意介质（如 TP、RF 或 IP）上的敏感 KNX 消息。

这些参数可在 "**security**" 子节中配置：

| **参数**     | **说明**                                            |
|:------------------|------------------------------------------------------------|
| knxkeys_file_path | knxkeys 文件的完整路径（包含文件名）。     |
| knxkeys_password  | 用于解密 knxkeys 文件的密码。                      |
| :--------------   | ---------------------------------------------------------- |

配置文件中此子节如下所示：

```json
"security": {
    "knxkeys_file_path": "/path/to/knxkeys.knxkeys",
    "knxkeys_password": "password"
}
```
