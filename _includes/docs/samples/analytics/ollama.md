* TOC
{:toc}

## Ollama 简介

[Ollama](https://ollama.com/){:target="_blank"} 是一款开源工具，可让您在自己的基础设施上本地运行大语言模型（LLM）。可以理解为将 Llama、Mistral 或 Gemma 等 AI 模型的能力直接部署到您的服务器，而无需向外部云服务发送请求。

与需要通过互联网进行 API 调用的 OpenAI、Anthropic 或 Google Gemini 等基于云的 AI provider 不同，Ollama 完全在您的环境中运行。这一根本差异为希望利用 AI 同时保持对数据和基础设施控制的企业开辟了新可能。

## 为何考虑在 ThingsBoard 部署中使用 Ollama？

若您已有 ThingsBoard 部署并希望探索 AI 集成，Ollama 可解决多项关键顾虑：

**降低成本**：Ollama 消除了云 AI 服务常见的按 token 收费。一旦拥有支持 GPU 的基础设施，您只需支付硬件和运维成本，用量再大成本也可预测。

**数据隐私**：所有数据处理均在您的基础设施内完成。遥测数据和 AI 分析不会离开您的网络，有助于遵守 GDPR、HIPAA 或行业特定法规。

**网络独立性**：Ollama 不依赖外部互联网连接或第三方服务可用性，适合互联网接入受限或可靠性至关重要的关键基础设施。

## 了解 Ollama 部署选项

将 Ollama 与 ThingsBoard 集成的方式很大程度上取决于您当前的部署架构。下面介绍 Ollama 如何适配最常见的 ThingsBoard 部署模式。

### 单机单体部署

若您在单台服务器（如 EC2 实例）上以单一服务运行 ThingsBoard，Ollama 可作为附加服务直接部署在同一台机器上。适用于：

- 服务器具备 GPU 能力（推荐以保证可接受的性能）
- 有足够内存和 CPU 同时运行两个服务
- AI 工作负载适中，无需专用硬件

在此场景中，Ollama 与 ThingsBoard 并行运行，通过 localhost 连接通信，部署简单且集中。

### 单机 Docker Compose 部署

对于在集群模式（微服务）下使用 Docker Compose 的 ThingsBoard 部署，可通过两种方式添加 Ollama：

- **作为 Docker 容器**：在现有的 docker-compose.yml 中添加 Ollama，使其成为容器栈的一部分。注意，此方式可能需要额外配置以通过 Docker 启用 GPU 支持。
- **作为系统服务**：在宿主机上直接安装 Ollama，以常规 Linux 服务运行。此方式在安装时通常会自动配置 GPU 支持，更容易获得硬件加速。

两种方式均适用于此类部署，但系统服务安装通常开箱即可获得 GPU 访问。

### Kubernetes 集群部署

在 Kubernetes 环境中，建议在支持 GPU 的独立节点池上运行 Ollama。此方式具有以下优势：

- **可扩展性**：Kubernetes 可轻松扩展 Ollama 部署以满足需求。随着 AI 工作负载增长，可向节点池添加支持 GPU 的节点，Kubernetes 会自动在可用资源之间分布 Ollama pod。这样可独立于 ThingsBoard 基础设施扩展 AI 能力。
- **安全性**：Kubernetes 提供多种功能保护 Ollama 部署，包括控制 pod 间流量的网络策略、强制最佳实践的安全标准，以及通过 TLS 终止和认证管理外部访问的 ingress 控制器。
- **复杂性**：请注意，Kubernetes 部署的搭建和维护较为复杂。需要配置 Nvidia GPU operator 等组件以访问 GPU，为 pod 调度设置合适的 node selectors 或 taints/tolerations，并管理资源配额和限制。这需要扎实的 Kubernetes 经验。

### 远程 Ollama 部署

或许最灵活的方式是在与 ThingsBoard 部署完全分离的基础设施上运行 Ollama。在此模式中：

- Ollama 运行在针对 AI 工作负载优化的专用支持 GPU 的服务器上
- ThingsBoard 通过 HTTP/HTTPS 向远程 Ollama 实例发起请求

这种职责分离使您能够独立于IoT平台扩展 AI 基础设施，并针对各自工作负载进行优化。

## 了解认证要求

需注意：Ollama 本身不包含内置认证机制。该软件设计追求快速简单，将安全实现交给部署架构负责。

这意味着在无额外安全层的情况下，任何能访问 Ollama 端点的人都可以自由使用。根据部署场景，这会产生不同程度的关注：

**认证至关重要时：**

- Ollama 暴露给不受信任网络或互联网
- 多个团队或项目共享同一 Ollama 实例
- 合规要求规定必须进行访问控制
- 需要追踪或限制使用

**认证可能不那么关键时：**

- Ollama 运行在完全可信的隔离网络中（例如无外部访问 Ollama 的 Docker Compose 或 Kubernetes 集群）
- 仅 ThingsBoard 有网络访问 Ollama 端点的权限
- 您的基础设施已提供网络级安全

即使在可信网络场景中，实施认证也能提供纵深防御，并实现更好的访问控制和审计。

## ThingsBoard 对 Ollama 的认证支持

考虑到对灵活安全选项的需求，ThingsBoard 在连接 Ollama 端点时提供三种认证方式：

### None（无认证）

此选项向 Ollama 端点发出未认证请求。尽管可能看似不安全，但适用于特定场景：

- Ollama 与 ThingsBoard 在同一服务器上运行，仅 localhost 访问
- 网络级安全（防火墙、VPN）已将 Ollama 端点隔离
- 处于开发或测试环境

使用此选项时，您依赖网络架构和基础设施控制来保护 Ollama 的访问。

### Basic Authentication（用户名和密码）

HTTP Basic 认证使用用户名和密码凭据提供简单的安全层。使用此方式时，ThingsBoard 将凭据以 Base64 编码并以 `Basic <encoded-credentials>` 形式放入 Authorization header。

此方式：

- 实现和理解简单
- 适合小团队或单用户场景
- 需要凭据管理（密码轮换、安全存储）

**重要**：使用 Basic 认证时请始终使用 HTTPS，确保凭据在传输中加密，不会以明文在网络中发送。

### Token Authentication（Bearer Token/API Key）

基于 Token 的认证使用 API key（bearer token）进行认证。使用此方式时，ThingsBoard 以 `Bearer <your-token>` 形式在 Authorization header 中传递 token。

此方式：

- 对使用过云 AI 服务的人很熟悉
- 无需更换密码即可轻松进行凭据轮换
- 支持为不同应用或环境使用多个 token
- 与反向代理能力结合可实现细粒度访问控制

**重要**：使用 Token 认证时请始终使用 HTTPS，确保 API key 在传输中加密，不会以明文在网络中发送。

## 为 Ollama 设置认证

若需要为 Ollama 部署实施 Basic 或 Token 认证，我们提供了[使用 Nginx 作为带认证的反向代理的配置指南](/docs/samples/analytics/ollama/nginx)。该指南是认证实现入门的参考，涵盖 Docker Compose 下两种认证方式的配置，可在此基础上根据您的环境进行定制和扩展。

## 选择适合的认证方式

选择何种认证方式取决于您的具体部署场景：

**在以下情况使用「None」：**

- Ollama 和 ThingsBoard 在同一服务器上通过 localhost 通信
- 您的网络架构已提供完全隔离

**在以下情况使用「Basic Authentication」：**

- 希望尽量简化用户管理
- 团队较小或只有单用户访问
- 已正确配置 HTTPS

**在以下情况使用「Token Authentication」：**

- 希望与 AI 行业标准一致
- 多个应用或团队将访问 Ollama
- 需要支持无中断的凭据轮换
- 需要更好的访问审计追踪
- 团队已熟悉 API key 管理

对于大多数生产部署，尤其是远程 Ollama 场景，Token 认证在安全性和可用性之间取得最佳平衡。

## 在 ThingsBoard 中配置 Ollama

Ollama 部署完成并（可选）配置认证后，将其连接到 ThingsBoard 较为直接。您可通过 ThingsBoard 界面将 Ollama 配置为 AI 模型 provider。

### 访问配置表单

按照 [向 ThingsBoard 添加 AI 模型](/docs/{{docsPrefix}}samples/analytics/ai-models/#adding-ai-models-to-thingsboard){:target="_blank"} 的说明，在 ThingsBoard 中进入 AI 模型配置区域。这将打开 AI 模型配置表单，您可在其中添加 Ollama 端点。

### 配置参数

Ollama 配置表单包含以下关键设置：

**Provider**：从 AI provider 下拉框中选择 "Ollama"。

**Base URL**：Ollama 实例的 HTTP/HTTPS 端点地址。示例：

- `http://localhost:11434` - 同一服务器上本地运行的 Ollama
- `http://192.168.1.100:8880` - 您网络中另一台服务器上的 Ollama
- `https://ollama.yourdomain.com` - 带 HTTPS 反向代理后的 Ollama

**Authentication**：从三种选项中选择一种：

- **None**：不使用认证。ThingsBoard 将直接向 Ollama 端点发送未认证请求。

- **Basic**：使用用户名和密码的 HTTP Basic 认证。
    - **Username**：认证用户名
    - **Password**：认证密码

- **Token**：使用 API key 的 Bearer token 认证。
    - **Token**：您的 API key 或 bearer token

**Model ID**：要使用的具体 Ollama 模型（如 `llama3:8b`、`mistral:7b`、`gemma3:1b`）。应与已拉取到 Ollama 实例中的模型完全一致。

**Temperature、Top P、Top K、Maximum Output Tokens**：这些参数控制模型的响应行为，各 AI provider 通用。请根据您的用例要求进行配置。

**Context Length**：该关键设置决定单次请求中模型可处理的上下文（对话历史、系统提示、输入数据）量。

### 理解 Context Length

在使用 Ollama 时，Context length 值得特别关注，因为它会显著影响模型能力和服务器资源利用。

Context length（也称 context window）是模型在单次请求中可处理的 token 总数，包括系统提示、输入数据和模型生成的响应。需将该值设得足够大，以容纳所有输入和预期输出而不丢失数据。

**内存考虑：**
与基础设施自动扩展的云服务不同，使用 Ollama 时您管理的是固定硬件资源。Context length 会显著影响 GPU 内存使用——更大的 context window 需要 substantially 更多内存。确切的对应关系因模型大小和架构而异，但影响相当大。

**确定合适的值：**
最适合您用例的 context length 最好通过实证确定。先根据典型输入大小加预期输出长度做合理估计，再根据以下情况调整：

- 请求是否被截断
- GPU 上的实际内存使用
- 性能和响应时间

若发现数据被截断，增大 context length。若内存使用过高或性能不佳，考虑减小或使用更小模型。

### 测试配置

填写所有必填字段后，点击表单底部的 **Check connectivity** 按钮。测试成功将显示绿色勾选，确认 ThingsBoard 可与 Ollama 端点通信且指定模型可用。

## 在 ThingsBoard 中使用 Ollama

有关在 ThingsBoard 中使用 AI 模型（包括 Ollama）的实战示例，请参阅我们的 [AI 预测性维护指南](https://thingsboard.io/docs/samples/analytics/ai-predictive-maintenance/){:target="_blank"}。该指南展示如何将 AI 用于异常检测和预测性维护场景，展示 IoT 系统中 AI 集成的实际应用。
