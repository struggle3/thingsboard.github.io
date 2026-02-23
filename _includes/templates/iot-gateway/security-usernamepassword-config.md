一种安全配置方式为使用 clientId、username 和 password。获取方式为：登录 ThingsBoard 平台实例，
进入"设备"标签页，点击加号图标，填写相应信息并勾选"Is gateway（作为网关）"选项，
点击"Next: Credentials（下一步：凭据）"，勾选"Add credentials（添加凭据）"，
选择凭据类型"MQTT Basic"，将默认值替换为您的值。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| clientId                | **clientId**      | 网关在 ThingsBoard 服务器上的 MQTT 客户端 ID     |
| username                | **admin**         | 网关在 ThingsBoard 服务器上的 MQTT 用户名      |
| password                | **admin**         | 网关在 ThingsBoard 服务器上的 MQTT 密码      |
|---


```json
...
"security": {
  "clientId": "YOUR_CLIENT_ID",
  "username": "YOUR_USERNAME",
  "password": "YOUR_PASSWORD"
},
...
```
