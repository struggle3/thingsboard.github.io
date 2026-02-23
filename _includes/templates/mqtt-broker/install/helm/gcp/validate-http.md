现在可在浏览器中使用负载均衡器的 DNS 名称打开 TBMQ Web 界面。

可使用以下命令获取负载均衡器的 DNS 名称：

```bash
kubectl get ingress
```
{: .copy-code}

输出应类似：

```text
NAME                          CLASS    HOSTS   ADDRESS              PORTS   AGE
my-tbmq-cluster-http-lb       <none>   *       <your-domain-name>   80      3d1h
```

使用 my-tbmq-cluster-http-lb 的 `ADDRESS` 字段连接集群。

{% include templates/mqtt-broker/login.md %}

### 验证 HTTPS 访问（若已配置）

使用 dig 检查域名是否正确配置：

```bash
dig <your-domain-name>
```
{: .copy-code}

示例输出：

```text

; <<>> DiG 9.11.3-1ubuntu1.16-Ubuntu <<>> <your-domain-name>
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12513
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;YOUR_DOMAIN_NAME.	IN	A

;; ANSWER SECTION:
YOUR_DOMAIN_NAME. 36 IN	A	34.111.24.134

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Fri Nov 19 13:00:00 EET 2021
;; MSG SIZE  rcvd: 74

```

分配完成后，等待 Google 托管证书完成配置，可能需要最多 60 分钟。可使用以下命令查看证书状态：

```bash
kubectl describe managedcertificate <your-managed-certificate-resource-name>
```
{: .copy-code}

若域名记录已正确配置，证书最终将完成配置。使用 `<your-domain-name>` 连接集群。
