Kubernetes 部署使用 <b>ConfigMap</b> 为 tb-nodes 提供 logback 配置。
要更新 <b>logback.xml</b>，请执行以下操作：

 ```bash
edit common/tb-node-configmap.yml
kubectl apply -f common/tb-node-configmap.yml
 ```

约 10 秒后，日志配置更改将生效。