## 集群删除

执行以下命令删除所有 ThingsBoard Pod：

```bash
./k8s-delete-resources.sh
```
{: .copy-code}

执行以下命令删除所有 ThingsBoard Pod 和 ConfigMap：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令删除 EKS 集群（您需要修改集群名称和可用区）：

```bash
eksctl delete cluster -r us-east-1 -n thingsboard -w
```
{: .copy-code}
