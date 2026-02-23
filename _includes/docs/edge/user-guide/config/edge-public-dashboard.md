* TOC
{:toc}

### 概述

**Public dashboard configuration（公共仪表板配置）** 允许在无需认证的情况下访问仪表板，即任何人拥有 URL 链接即可查看仪表板。

在 **ThingsBoard Edge** 中，**公共仪表板** 与 **ThingsBoard Server** 上的工作方式相同。

**Edge 特定注意事项：**

* **Edge 公共仪表板** 在互联网不可用或受限的情况下，仍可在本地网络中可用。

* **Edge 公共仪表板** 通过 Edge 的 **本地 URL 链接** 访问。公共 URL 通常格式如下：
```bash
http://Edge-IP:8080/dashboards/dashboard-id
```
* 即使与 **ThingsBoard Server** 的连接断开，**公共仪表板** 仍可使用来自 **Edge** 的实时设备数据继续运行。

* 连接恢复后，**Edge** 将与中央 **ThingsBoard Server** 同步任何更新或变更。

请[在此](/docs/{{docsPrefix}}user-guide/db-overview/){: target="_blank"}了解更多关于 **Edge 仪表板创建与管理**。

请[在此](/docs/{{peDocsPrefix}}user-guide/widgets/){: target="_blank"}了解更多关于 **仪表板部件**。

{% if docsPrefix == "pe/edge/" %}
### 将仪表板组设为公开
{% else %}
### 将仪表板设为公开
{% endif %}

{% capture local-deployment %}
要通过公共链接访问设备、资产和实体视图的数据，请同时将这些实体设为公开。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

{% if docsPrefix == "pe/edge/" %}
**Dashboard groups** 在 **ThingsBoard Server** 上管理。仪表板组必须先在 **ThingsBoard Server** 上创建，然后分配给 **ThingsBoard Edge** 实例。
{% endif %}
{% include images-gallery.html imageCollection="makePublic" showListImageTitles="true" %}

{% if docsPrefix == "pe/edge/" %}
#### 将仪表板组设为私有
{% else %}
#### 将仪表板设为私有
{% endif %}

{% include images-gallery.html imageCollection="makePrivate" showListImageTitles="true" %}

### 下一步

{% include templates/edge/guides-banner-edge.md %}
