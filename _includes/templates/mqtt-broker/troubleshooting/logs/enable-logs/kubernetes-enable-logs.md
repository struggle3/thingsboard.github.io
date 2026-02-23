Kubernetes 部署使用 <b>ConfigMap</b> 为 tb-brokers 提供 logback 配置。
修改 **logback.xml** 需编辑 `tb-broker-configmap.yml` 并执行：

 ```bash
kubectl apply -f tb-broker-configmap.yml
 ```
{: .copy-code}

约 10 秒后，日志配置将生效。
