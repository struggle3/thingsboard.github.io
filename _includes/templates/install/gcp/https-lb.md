使用 Google 托管 SSL 证书配置负载均衡器的过程在官方[文档页面](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs)中有描述。
以下说明摘自官方文档。请务必在继续之前仔细阅读[先决条件](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#prerequisites)。

```bash
gcloud compute addresses create {{staticIP}} --global
```
{: .copy-code}

在 *https-load-balancer.yml* 文件中将 *PUT_YOUR_DOMAIN_HERE* 替换为有效域名：

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

执行以下命令部署安全 HTTP 负载均衡器：

```bash
 kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

负载均衡器预置可能需要一些时间。您可以使用以下命令定期检查负载均衡器状态：

```bash
kubectl get ingress
```
{: .copy-code}

预置完成后，您应看到类似输出：

```text
NAME                   CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-https-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```

现在，**将您使用的域名**分配给负载均衡器 IP 地址（命令输出中代替 34.111.24.134 的地址）。

使用 dig 检查域名是否正确配置：

```bash
dig YOUR_DOMAIN_NAME
```
{: .copy-code}

示例输出：

```text

; <<>> DiG 9.11.3-1ubuntu1.16-Ubuntu <<>> YOUR_DOMAIN_NAME
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

分配后，等待 Google 托管证书完成预置。这可能需要长达 60 分钟。您可以使用以下命令检查证书状态：

```bash
kubectl describe managedcertificate managed-cert
```
{: .copy-code}

如果您正确配置了域名记录，证书最终将完成预置。
