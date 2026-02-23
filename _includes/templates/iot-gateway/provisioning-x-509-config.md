使用以下配置，可将 Gateway 设置为使用 X.509 证书 provisioning 策略：

| **参数**         | **默认值**        | **说明**                                                                |
|:----------------------|:-------------------------|--------------------------------------------------------------------------------
| type                  | **X509_CERTIFICATE**     | Provisioning 策略类型。                                                 |
| provisionDeviceKey    | **DEVICE_KEY**           | Provisioning 设备密钥，需从已配置的 device profile 中获取。    |
| provisionDeviceSecret | **DEVICE_SECRET**        | Provisioning 设备密文，需从已配置的 device profile 中获取。 |
| caCert                | **ca-root.pem**  | ThingsBoard 中设备的 X509 公钥。                                     |
| ---                   

配置文件中的 provisioning 配置小节将如下所示：
```yaml
...
"provisioning": {
  "type": "X509_CERTIFICATE",
  "provisionDeviceKey": "PUT_YOUR_DEVICE_KEY_HERE",
  "provisionDeviceSecret": "PUT_YOUR_DEVICE_SECRET_HERE",
  "caCert": "/etc/thingsboard-gateway/ca.pem"
},
...
```
