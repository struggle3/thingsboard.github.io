* TOC
{:toc}

Access Token 认证是 ThingsBoard 中设备的默认认证方式。
设备创建时，ThingsBoard 会自动生成唯一的 access token。该 token 可随后在设备详情中 [更新](/docs/{{docsPrefix}}user-guide/ui/devices/#manage-device-credentials){:target="_blank"}。

要通过 HTTP 认证设备，客户端必须在 HTTP 请求 URL 中包含 access token。

有关支持的端点、请求格式和 payload，请参阅 [HTTP API](/docs/{{docsPrefix}}reference/http-api/){:target="_blank"} 文档。
