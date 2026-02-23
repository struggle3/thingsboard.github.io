GRPC - 提供 GRPC 配置：
- Server port（服务器端口）- GRPC 服务器监听传入连接的网络端口。
- Keep alive permit without calls（无调用时允许保活）- 允许服务器在没有活动 RPC 调用时仍保持 GRPC 连接。
- Keep alive（保活）- 无活动 RPC 调用时，两次连续 keepalive ping 之间的时长（毫秒）。
- Max pings without data（无数据时最大 ping 数）- 服务器在认为连接失效前，可发送且未收到任何数据的 keepalive ping 最大数量。
- Keep alive timeout（保活超时）- 服务器在认为连接失效前等待 keepalive ping 响应的最长时间（毫秒）。
- Min time between pings（ping 最小间隔）- 服务器在两次 keepalive ping 之间应等待的最短时间（毫秒）。
- Min ping interval without data（无数据时最小 ping 间隔）- 在无数据收发时，服务器在两次 keepalive ping 之间应等待的最短时间（毫秒）。

![](/images/gateway/dashboard/gateway-dashboard-grpc-conf.png)
