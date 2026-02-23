* TOC
{:toc}

## 概述

{% capture white-labeling-note %}
**白标（White Labeling）** 功能仅在 **Professional Edition** 中支持。
{% endcapture %}
{% include templates/info-banner.md content=white-labeling-note %}

**ThingsBoard** 的 **白标（White Labeling）** 使企业能够自定义平台的外观和品牌，以匹配自身的企业形象。
请参阅 **ThingsBoard 白标** [文档](/docs/pe/user-guide/white-labeling/){: target="_blank"}，其中包含如何自定义 **ThingsBoard 徽标** 和 Web **界面** 的分步说明。

**白标** 功能支持特定的 **层级结构**。
租户可以覆盖系统管理员设置，租户设置又可被客户覆盖，以此类推。

 ![hierarchy_scheme](/images/edge/user-guide/white-labeling/hierarchy.webp){: style="display: block; margin: auto; max-height: 400px"}

同样，**白标** 配置会传播到 **Edge 实例**：

* **租户所属 Edge：** 若 Edge 归 **租户** 所有，则白标设置从 **租户层级** 获取，并与系统管理员的设置合并。

![tenant-owned-edge](/images/edge/user-guide/white-labeling/hierarchy-edge-tenant.webp){: style="display: block; margin: auto; max-height: 280px"}

* **客户所属 Edge：** 若 Edge 归 **客户** 所有，则白标设置从 Edge 的 **客户** 获取，并与租户和系统管理员的设置合并。
 
![customer-owned-edge](/images/edge/user-guide/white-labeling/hierarchy-edge-customer.webp){: style="display: block; margin: auto; max-height: 390px"}

不过，显示界面取决于用于登录 **Edge** 实例的 **账户**。

_**例如：** 当用户使用 **租户账户** 登录 **客户所属 Edge** 时，该用户将看到 **租户** 的界面。_

![interface](/images/edge/user-guide/white-labeling/interface.webp){: style="display: block; margin: auto; max-height: 400px"}

## Edge 登录页

**ThingsBoard** 还允许自定义登录页。在 **多租户环境** 中，基于域名的品牌定义在登录时应用的配置，即不同租户可有不同的品牌配置。请参阅 **登录页配置** [文档](/docs/pe/user-guide/white-labeling/#customize-the-login-page){: target="_blank"}。

_**例如：** 若用户从特定域名（companyA.com）登录，ThingsBoard 将应用与该域名关联的白标设置。若未设置自定义域名，则使用默认设置。_

在 **Edge** 端，域名 **不以任何方式使用**。

{% capture edge-login %}
**Edge 登录页** 的外观仅取决于 **归属关系**。
{% endcapture %}
{% include templates/info-banner.md content=edge-login %}

_**例如：** 当用户登录 **客户所属 Edge** 时，将应用 **客户** 的白标登录配置。_

![edge-login-page](/images/edge/user-guide/white-labeling/edge-login-page.webp){: style="display: block; margin: auto; max-height: 450px"}

## 其他配置

**Edge** 的 **白标** 配置与 **平台（Server 或 Cloud）** 设计方式相同。详细配置说明请参阅 **平台白标文档**：
* [自定义翻译](/docs/pe/user-guide/custom-translation/){: target="_blank"}
* [自定义菜单](/docs/pe/user-guide/custom-menu/){: target="_blank"}

## 下一步

{% include templates/edge/guides-banner-edge.md %}
