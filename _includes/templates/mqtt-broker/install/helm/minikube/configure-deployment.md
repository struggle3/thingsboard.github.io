### 启动 Minikube

```bash
minikube start
```
{: .copy-code}

### 安装 NGINX Ingress Controller

在 Minikube 等通用 Kubernetes 环境中暴露 HTTP(S) 服务，需安装 NGINX Ingress Controller。
本示例使用 Helm 安装并配置为 LoadBalancer 服务类型：

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install nginx-ingress ingress-nginx/ingress-nginx \
  --set controller.admissionWebhooks.enabled=false \
  --set controller.service.type=LoadBalancer
```
{: .copy-code}

这将在 default 命名空间部署 NGINX ingress controller，并配置为通过 LoadBalancer 服务对外暴露流量。
继续前，请确保 ingress controller pod 已运行且就绪：

```bash
kubectl get pods -n default
```
{: .copy-code}

输出应类似：

```text
NAME                                                     READY   STATUS    RESTARTS   AGE
nginx-ingress-ingress-nginx-controller-xxxxx             1/1     Running   0          1m
```

### 启动 Minikube Tunnel

由于 Minikube 本身不支持外部 LoadBalancer 服务，需创建 tunnel 以在集群外暴露这些服务。
这是访问 NGINX Ingress Controller 和 TBMQ 的 MQTT LoadBalancer 等服务的必要条件。

在单独终端中运行以下命令：

```bash
minikube tunnel
```
{: .copy-code}

此命令需要管理员权限，可能会提示输入密码。
它将在您的机器上创建网络路由并为 NGINX LoadBalancer 服务分配外部 IP。

启动 tunnel 后，验证 NGINX Ingress Controller 是否已获得 EXTERNAL-IP：

```shell
kubectl get svc -n default
```
{: .copy-code}

示例输出：

```text
NAME                                     TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                      AGE
nginx-ingress-ingress-nginx-controller   LoadBalancer   10.101.102.99    192.168.49.2     80:32023/TCP,443:32144/TCP   2m
```
