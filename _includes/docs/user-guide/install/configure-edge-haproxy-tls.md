ThingsBoard支持通过TLS/SSL上的gRPC连接保护平台与Edge实例间的连接。

我们将使用HAProxy作为Edge与平台间TLS连接的终止点。

首先，需将平台Edge连接默认绑定端口改为7071。这样可将HAProxy配置为监听默认7070端口，并将连接转发至平台的7071端口。

请执行以下命令更新平台上的Edge绑定端口：

```bash
sudo sh -c 'cat <<EOL >> /etc/thingsboard/conf/thingsboard.conf

export EDGES_RPC_PORT=7071
EOL'
```
{: .copy-code}

应用变更后需重启ThingsBoard平台：

```bash
sudo systemctl restart thingsboard
```
{: .copy-code}

接下来，执行以下命令将TLS配置添加到HAProxy配置文件：

```bash
sudo sh -c 'cat <<EOL >> /etc/haproxy/haproxy.cfg

# Edge gRPC TLS (optional)
listen grpc_front
    bind *:7070 ssl crt /usr/share/tb-haproxy/default.pem crt /usr/share/tb-haproxy/certs.d/ ciphers ECDHE-RSA-AES256-SHA:RC4-SHA:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM alpn h2,http/1.1
    mode tcp

    option clitcpka
    option tcplog

    default_backend grpc_backend 

backend grpc_backend
    mode tcp
    server grpc 127.0.0.1:7071
EOL'
```
{: .copy-code}
