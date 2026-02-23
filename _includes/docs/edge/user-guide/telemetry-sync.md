* TOC
{:toc}

> **ThingsBoard Edge** 不会自动同步遥测数据。
而是 **基于规则的过程**。["push to cloud"](/docs/user-guide/rule-engine-2-0/nodes/action/push-to-cloud/){:target="_blank"}
和 ["push to edge"](/docs/user-guide/rule-engine-2-0/nodes/action/push-to-edge/){:target="_blank"} 规则节点负责
同步过程。

### Edge → Cloud 同步

Edge 通过 Edge 规则链中的 **"push to cloud"** 规则节点同步数据（timeseries、attributes 等）。
当遥测或属性消息通过此规则节点时，会先作为 **Cloud Event** 在 Edge 上本地存储，
存储在本地数据库或 Kafka 中（取决于队列类型）。
随后该事件 **异步** 推送到 Cloud。这意味着 Edge 设备不会在继续其他任务前等待 Cloud 的交付确认。
到达 Cloud 后，由 Cloud 上相应的规则链处理。

![edge→cloud diagram](/images/edge/user-guide/edge-cloud-telemetry-sync/edge-cloud-diagram.webp){: style="display: block; margin: auto"}

* 要传播属性变更，请将 **Attributes updated** 和 **Attributes deleted** 关系连接到 **"push to cloud"** 节点。
这可确保 **key–values** 和 **scope** 随事件一起传递。
* **attribute scope type**（_Server attributes、Shared attributes 或 Client attributes_）也将在 **"push to cloud"** 节点内配置。

{% include images-gallery.html imageCollection="edge-rule-chain" %}

#### Cloud 端数据存储

Cloud 端更新的数据库表完全取决于您的 Cloud 端规则链。

* **要同时存储最新遥测和历史遥测**，请将遥测路由到 **"save timeseries"** 规则节点，并将 **Latest values** 设置为 **"On every message"**。这将同时写入并更新 **timeseries** 和 **latest values** 表。

{% include images-gallery.html imageCollection="update-both-tables-cloud" %}

* **若仅存储历史遥测**，请将遥测路由到 **"save timeseries"** 规则节点，并将 **Latest values** 设置为 **"Skip"**。这将仅更新 **timeseries** 表，**latest values** 表保持不变。

{% include images-gallery.html imageCollection="update-only-timeseries-cloud" %}

### Cloud → Edge 同步

同样，Cloud 使用 Cloud 规则链中的 ["push to edge"](/docs/user-guide/rule-engine-2-0/nodes/action/push-to-edge/){:target="_blank"} 规则节点同步数据。

该节点将消息转换为 **Edge Event** 并将其存储在 Cloud 上的 **Edge queue** 中（_本地数据库或 Kafka，取决于队列类型_）。
随后该事件 **异步** 推送到目标 Edge。
到达 Edge 实例后，由 Edge 上相应的规则链处理。

![cloud→edge diagram](/images/edge/user-guide/edge-cloud-telemetry-sync/cloud-edge-diagram.webp){: style="display: block; margin: auto"}

* 要传播属性变更，请将 **Attributes updated** 和 **Attributes deleted** 关系连接到 **"push to edge"** 节点。
  这可确保 **key–values** 和 **scope** 随事件一起传递。
* **attribute scope type**（_Server attributes、Shared attributes 或 Client attributes_）也将在 **"push to edge"** 节点内配置。

{% include images-gallery.html imageCollection="cloud-rule-chain" %}

#### Edge 端数据存储

Edge 始终保留其接收或从 Cloud 接收的本地权威数据副本。这支持离线运行和快速本地响应。

* **当数据从设备发送到 Edge 时：**  
Edge 先将遥测数据写入本地数据库。根据规则链配置，Edge 决定是否将其推送到 Cloud

{% include images-gallery.html imageCollection="push-telemetry-to-cloud" %}

* **当 Cloud 的 Edge 事件到达时：** 

  * **要同时存储最新遥测和历史遥测**，请将遥测路由到 **"save timeseries"** 规则节点，并将 **Latest values** 设置为 **"On every message"**。这将同时写入并更新 **timeseries** 和 **latest values** 表。

{% include images-gallery.html imageCollection="edge-update-both-tables" %}

  * **若仅存储历史遥测**，请将遥测路由到 **"save timeseries"** 规则节点，并将 **Latest values** 设置为 **"Skip"**。这将仅更新 **timeseries** 表，**latest values** 表保持不变。

{% include images-gallery.html imageCollection="edge-update-only-timeseries" %}

### 下一步

{% include templates/edge/guides-banner-edge.md %}
