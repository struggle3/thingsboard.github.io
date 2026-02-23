* TOC
{:toc}

{% assign sinceVersion = "4.2" %}
{% include templates/since.md %}

<b>AI 模型</b>是能够处理数据、生成预测、检测异常或产生类人响应的机器学习或大语言模型。
在 ThingsBoard 中，AI 模型用于通过高级分析和自动化扩展 IoT 数据处理能力。

通过集成外部 AI 提供方（如 OpenAI、Google Gemini、Azure OpenAI、Amazon Bedrock 等），您可以：
- <b>预测</b>未来值（如能耗或设备温度）。
- <b>检测</b>实时遥测流中的异常。（参见[工业设备故障检测示例](/docs/{{docsPrefix}}samples/analytics/ai-predictive-maintenance/){:target="_blank"}）。
- <b>分类</b>设备状态（如 OK、Warning、Fault）。
- <b>生成</b>面向操作员和最终用户的响应或自然语言洞察。

ThingsBoard 允许您配置并连接不同的 AI 提供方、管理模型设置，并在 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/){:target="_blank"} 中用于自动化与决策。

## 向 ThingsBoard 添加 AI 模型

在 ThingsBoard 中添加 AI 模型，请按以下步骤操作：

- 进入「<b>Settings</b>」页面的「<b>AI models</b>」标签页。
- 点击「<b>Add model</b>」按钮（位于右上角）。
- 将打开可用于配置 AI 模型表单：
  - <b>Name</b> - 为 AI 模型提供有意义的名称。
  - [Provider](#provider-configuration) — 选择 **AI provider**，指定 **base URL**（仅 [OpenAI](#openai) 和 [Ollama](#ollama) 需要），并输入 provider 的 **authentication credentials**。
  - [Model ID](#model-configuration) – 选择要使用的模型（在 **Azure OpenAI** 中为 deployment name）。
  - [Advanced settings](#advanced-model-settings) – 如 provider 支持，可配置可选参数（如 temperature、top P、max tokens）。
- 点击「<b>Save</b>」完成添加。

保存后，模型可在 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/){:target="_blank"} 的 [AI request node](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/nodes/external/ai-request/){:target="_blank"} 中使用。

{% include images-gallery.html imageCollection="adding-ai-model" %}

## Provider 配置

在 <b>Provider</b> 区域选择 <b>AI provider</b>，指定 <b>base URL</b>（仅 [OpenAI](#openai) 和 [Ollama](#ollama) 需要），并输入 <b>authentication credentials</b>（如 API key、key file 等）。

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% capture difference %}
建议使用 [Secrets storage](/docs/{{docsPrefix}}user-guide/secrets-storage/){:target="_blank"} 安全存储凭证。{% endcapture %}
{% include templates/info-banner.md content=difference %}
{% endif %}

<br><b><font size="4">支持的 AI providers</font></b>

ThingsBoard 目前支持与以下 AI providers 集成：

{% include images-gallery.html imageCollection="ai-provider-configuration" %}

#### OpenAI

- <b>Base URL</b>：指定访问 OpenAI API 的地址。
- <b>Authentication</b>：API key。
- 可从 [OpenAI dashboard](https://platform.openai.com/api-keys){:target="_blank"} 获取 API key。

##### 使用 OpenAI 兼容模型

{% assign sinceVersion = "4.2.1" %}
{% include templates/since.md %}

使用兼容 OpenAI API 的模型时，一个重要参数是 **base URL**，它定义了向 API 发送请求所使用的地址。

<b><font size="3">官方 Base URL</font></b>

ThingsBoard 中预配置的标准 OpenAI API 端点。用于访问 OpenAI 托管的模型。

<b><font size="3">自定义 Base URL</font></b>

实现 OpenAI 兼容 API 协议的 provider 的替代端点。 
当没有针对该 provider 的专用集成且其提供 OpenAI 兼容 API 时使用（如 DeepSeek、Qwen、自托管 Ollama）。

{% capture difference %}
使用自定义 base URL 时，**API key 为可选**。这样可支持无需认证的模型，如本地托管模型。但大多数云模型 provider 仍需要有效的 API key。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<b>Base URL 示例：</b>

| Provider                 | Base URL                                                 |
|--------------------------|----------------------------------------------------------|
| DeepSeek                 | `https://api.deepseek.com`                               |
| Alibaba Qwen (Singapore) | `https://dashscope-intl.aliyuncs.com/compatible-mode/v1` |
| Ollama (local)           | `http://localhost:11434/v1`                              |

{% capture ollama_note %}
[Ollama](#ollama) 也作为独立集成提供，具有更多配置选项。
{% endcapture %}
{% include templates/info-banner.md content=ollama_note %}

<hr>

#### Azure OpenAI

- Authentication：<b>API</b> key 和 <b>endpoint</b>。
- 需在 [Azure AI Studio](https://oai.azure.com/){:target="_blank"} 中创建目标模型的 <b>deployment</b>。
  - 从 deployment 页面获取 <b>API</b> key 和 <b>endpoint URL</b>。
  - 可选：可设置 service version。

<hr>

#### Google AI Gemini

- Authentication：<b>API key</b>。
- 可从 [Google AI Studio](https://aistudio.google.com/apikey){:target="_blank"} 获取 API key。

<hr>

#### Google Vertex AI Gemini

- Authentication：<b>Service account key file</b>。
- 必需参数：
  - Google Cloud Project ID。 
  - 目标模型所在区域 (region)。
  - 具有与 Vertex AI 交互权限的 Service account key file。

<hr>

#### Mistral AI

- Authentication：<b>API key</b>。 
- 可从 [Mistral AI portal](https://docs.mistral.ai/getting-started/quickstart/){:target="_blank"} 获取 API key。

<hr>

#### Anthropic

- Authentication：<b>API key</b>。
- 可从 [Anthropic console](https://console.anthropic.com/settings/keys){:target="_blank"} 获取 API key。

<hr>

#### Amazon Bedrock

- Authentication：<b>AWS IAM credentials</b>。
- 必需参数：
  - Access key ID。 
  - Secret access key。 
  - AWS region（推理运行所在区域）。

{% capture bedrock_note %}
不支持使用 Bedrock API keys 进行 Authentication。
{% endcapture %}
{% include templates/info-banner.md content=bedrock_note %}

<hr>

#### GitHub Models

- Authentication：<b>Personal access token</b>。
- Token 需具有 `models:read` 权限。
- 可按照[此指南](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token){:target="_blank"} 创建 token。

<hr>

#### Ollama

{% assign sinceVersion = "4.2.1" %}
{% include templates/since.md %}

[Ollama](https://ollama.com/){:target="_blank"} 让您可以在本机轻松运行 Llama 3、Mistral 等开源大语言模型。支持本地实验、离线使用以及对数据的更好掌控。

要连接 Ollama 服务，需要其 **base URL**（如 *http://localhost:11434*）和 **authentication method**。支持以下选项：

![image](/images/samples/analytics/ai-models/ollama-authentication-method.png)

- <b>None</b>
  - 标准 Ollama 安装的默认方式。 
  - 无需 authentication，请求中不发送 credentials。

- <b>Basic</b>
  - 当 Ollama 位于需要 **HTTP Basic Authentication** 的 reverse proxy 之后时使用。 
  - 提供的 username 和 password 组合为 `username:password` 字符串，进行 Base64 编码后以 header 形式发送：
  ```text
  Authorization: Basic <encoded_credentials>
  ```
- <b>Token</b>
  - 当 Ollama 位于需要 **Bearer Token Authentication** 的 reverse proxy 之后时使用。 
  - 提供的 token 在 header 中发送：
  ```text
  Authorization: Bearer <token>
  ```

{% capture difference %}
**安全建议**：使用 **Basic** 或 **Token** authentication 时，始终通过 `HTTPS` URL 连接。使用明文 `HTTP` 会在网络上明文传输 credentials，不安全。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## Model 配置

选择并完成 AI provider 的 authentication 后，需指定要使用的具体 AI 模型（[Azure OpenAI](#azure-openai) 中为 deployment name）。

对于部分 providers（如 OpenAI），ThingsBoard 提供 <b>autocomplete 选项</b>，包含常用模型。
您<b>不限于</b>该列表 —— 可指定 provider 支持的任意 model ID，包括 <b>model aliases</b> 或 <b>snapshots</b>。
<b>生产环境</b>建议使用 model snapshots 以确保可预测的表现（Model aliases 可能被 provider 更新并指向新 snapshot，从而影响响应质量）。

{% include images-gallery.html imageCollection="ai-model-id" %}

### 高级模型设置

部分模型支持高级配置参数（取决于 provider），例如：
- <b>Temperature</b> – 调整模型输出随机度。值越高越随机，越低越确定。
- <b>Top P</b> – 为模型创建最可能 token 池。值越大池越大、越多样，越小越聚焦。
- <b>Top K</b> - 将模型选择限制在「K」个最可能 token 的固定集合内。
- <b>Presence penalty</b> - 对已出现过的 token 施加固定惩罚。
- <b>Frequency penalty</b> - 根据 token 在文本中的出现频率施加递增惩罚。
- <b>Maximum output tokens</b> – 设置模型单次响应可生成的最大 token 数。
- <b>Context length</b> – 以 token 为单位定义 context window 大小。此值设置模型的总内存限制，包括用户输入和生成响应。

{% capture advanced_settings_tip %}
若 advanced settings 导致错误，可尝试移除其值。此时将应用默认值。这通常可解决与某些模型的兼容性问题。
{% endcapture %}
{% include templates/info-banner.md content=advanced_settings_tip %}

{% include images-gallery.html imageCollection="advanced-model-settings" %}

## Connectivity 测试

点击 <b>Check connectivity</b> 按钮验证配置。
将使用提供的 credentials 和 model 设置向 provider API 发送测试请求。

若响应成功，将显示 ✅ <b>绿色勾选</b>。

{% include images-gallery.html imageCollection="check-connectivity-1" %}

{% capture best_practice %}
配置 provider 后始终使用 connectivity 检查，以确保运行时正常执行。
{% endcapture %}
{% include templates/info-banner.md content=best_practice %}

若发生错误（如无效 API key、不存在的 model），将显示带详情的错误消息 ❌。

{% include images-gallery.html imageCollection="check-connectivity-2" %}

此功能可确保配置有效，并在生产环境中使用模型时避免运行时错误。

{% capture test_cost_note %}
尽管测试请求较简单（如「X 国首都是哪里？」），provider 通常仍会收费。但费用很低。
{% endcapture %}
{% include templates/info-banner.md content=test_cost_note %}

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}
