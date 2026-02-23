编辑 “trendz/trendz-secret.yml” ，将 YOUR_DB_IP_ADDRESS 和 YOUR_DB_PASSWORD 替换后执行 Kubernetes Job：
```text
kubectl apply -f ./trendz/trendz-secret.yml
kubectl apply -f ./trendz/trendz-create-db.yml
```
{: .copy-code}

执行以下命令可查看日志：
```text
kubectl logs job/trendz-create-db -n thingsboard
```
