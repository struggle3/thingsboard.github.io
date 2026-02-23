### 配置 GCP 工具

更多信息请参阅 [开始前准备](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster#before_you_begin) 指南。

创建新的 Google Cloud Platform 项目（推荐）或选择现有项目。执行以下命令确保已选择正确项目：

```bash
gcloud init
```
{: .copy-code}

### 启用 GKE 服务

```bash
gcloud services enable container.googleapis.com
```
{: .copy-code}

### 定义环境变量

{% include templates/mqtt-broker/install/helm/gcp/define-env-variables.md %}

### 配置并创建 GKE 集群

{% include templates/install/gcp/regional-gke-cluster.md %}

### 更新 kubectl 上下文

{% include templates/install/gcp/update-kubectl-zone.md %}
