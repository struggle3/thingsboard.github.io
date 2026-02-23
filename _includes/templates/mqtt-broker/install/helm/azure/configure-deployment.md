### 配置 Azure 工具

安装完成后，需使用以下命令登录 CLI：

```bash
az login
```
{: .copy-code}

### 定义环境变量

{% include templates/mqtt-broker/install/helm/azure/define-env-variables.md %}

### 配置并创建 AKS 集群

{% include templates/mqtt-broker/install/azure/aks-configure-and-create-cluster.md %}

### 更新 kubectl 上下文

{% include templates/mqtt-broker/install/azure/aks-update-kubectl-ctx.md %}
