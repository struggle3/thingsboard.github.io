## 将 PEM 证书和私钥转换为 PKCS12 keystore

确保具备以下文件：

* `server.pem` – 公钥证书（可含链）；
* `server_key.pem` – 私钥；
*（可选）`ca.pem` – root 或 intermediate CA 证书。

执行以下命令创建 PKCS12 keystore 文件 (`keystore.p12`)：

```bash
openssl pkcs12 -export \
  -in server.pem \
  -inkey server_key.pem \
  -certfile ca.pem \
  -out keystore.p12 \
  -name tbmq \
  -passout pass:changeit
```
{: .copy-code}

> `-certfile ca.pem \` 行为可选，若有 CA 证书链则包含。
>
> 将 `changeit` 替换为所需 keystore 密码。该密码会在环境变量中引用。

### 提示与最佳实践

* 生产环境**建议**使用 PKCS12 (`.p12`) 格式，比 JKS 更具互操作性。
* 导出时确保证书链完整（含 intermediates）。
