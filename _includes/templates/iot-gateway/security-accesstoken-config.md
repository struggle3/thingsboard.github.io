
accessToken 是一种安全配置方式。
请登录 ThingsBoard 平台实例，进入"设备"标签页，点击加号图标，
填写相应信息并勾选"Is gateway（作为网关）"选项，
打开该设备并点击"COPY ACCESS TOKEN（复制访问令牌）"按钮，将默认值替换为您的令牌


|**参数**|**默认值**|**说明**|
|:-|:-|-
| accessToken              | **PUT_YOUR_GW_ACCESS_TOKEN_HERE**                     | ThingsBoard 服务器分配给网关的访问令牌。|
|---

配置文件中的 security 配置小节将如下所示：

```json
...
"security": {
  "accessToken": "YOUR_ACCESS_TOKEN"
},
...
```
