`gp3` EBS 卷类型是 Amazon EKS 的推荐默认选项，相比 `gp2` 具有更好的性能、成本效益和灵活性。

请下载存储类配置文件：

```bash
curl -o gp3-def-sc.yml https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/k8s/helm/aws/gp3-def-sc.yml
```
{: .copy-code}

应用配置：

```bash
kubectl apply -f gp3-def-sc.yml
```
{: .copy-code}

若存在 `gp2` StorageClass，可能与 `gp3` 冲突。可将 `gp2` 存储类设为非默认：

```bash
kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```
{: .copy-code}

或删除 `gp2` StorageClass（若未使用）：

```bash
kubectl delete storageclass gp2
```
{: .copy-code}

检查 `gp3` 存储类是否可用并已标记为默认：

```bash
kubectl get sc
```
{: .copy-code}

输出应类似：

```text
NAME            PROVISIONER       RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
gp3 (default)   ebs.csi.aws.com   Delete          WaitForFirstConsumer   true                   30s
```
