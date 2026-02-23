* TOC
{:toc}

ThingsBoard 中的 **Customer（客户）** 代表独立业务实体——个人或组织——购买或使用租户的设备/资产。客户也可表示租户组织内的部门或分支机构。

客户可小到单点，大到包含众多用户、子客户及大量设备和资产的大型生态。

**谁可管理客户？**

[租户管理员](/docs/{{docsPrefix}}user-guide/ui/tenants/){:target="_blank"} 可创建和管理客户组及单个客户。

**客户可执行哪些操作？**

创建后，客户可管理其自身环境，包括：

- 创建和管理 **客户用户**；
- 添加和编辑 **设备、资产、仪表板** 及其他实体。

<hr>

## 创建新客户

租户管理员可按以下步骤添加新客户。

{% include images-gallery.html imageCollection="customer-add-new-pe" showListImageTitles="true" %}

{% capture difference %}
**注意：** 默认情况下，新客户会放入 "All" 客户组。可在创建流程中选择或创建不同组。更多关于实体组的信息见[此处](/docs/{{docsPrefix}}user-guide/groups/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<br><b>再创建一个客户并为其新建单独的客户组。</b>

{% include images-gallery.html imageCollection="customer-add-new-2-pe" showListImageTitles="true" %}

<hr>

## 创建客户用户

{% include images-gallery.html imageCollection="add-customer-user" showListImageTitles="true" %}

{% capture difference %}
在 "**All**" 组中创建的客户用户初始拥有 **受限权限**。之后可通过分配 **角色** 调整权限。[参见本文](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## 编辑客户或客户用户

租户管理员可编辑客户标题、指定首页仪表板并修改其他字段。
操作步骤如下：

{% include images-gallery.html imageCollection="edit-customer-pe" showListImageTitles="true" %}

也可编辑客户用户信息。

步骤与编辑客户类似：

{% include images-gallery.html imageCollection="edit-customer-user" showListImageTitles="true" %}

<hr>

## 删除客户或客户用户

租户管理员可通过以下任一方式删除客户及其所有客户用户：

第一种方式：

{% include images-gallery.html imageCollection="delete-customer-pe" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-customer-2-pe" showListImageTitles="true" %}

也可一次删除多个客户。

{% include images-gallery.html imageCollection="delete-customer-3-pe" showListImageTitles="true" %}

也可删除客户下的任意客户用户。步骤与删除客户相同。

{% include images-gallery.html imageCollection="delete-customer-user-1" showListImageTitles="true" %}

<hr>

## 客户详情

点击客户可打开详情窗口，查看并管理该客户相关的全部信息。

{% include images-gallery.html imageCollection="customer-details-page" %}

<b><font size="3">复制客户 ID</font></b>   
可快速获取客户唯一 UUID。点击 Copy customer Id 可复制到剪贴板。该 ID 用于 API 调用、integration 和自动化脚本。

<b><font size="3">属性</font></b>

该标签显示与客户关联的客户端、服务端和共享[属性](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"}。包括联系人、地区、账户参数或自定义元数据等静态或半静态键值对。

<b><font size="3">最新遥测</font></b>

显示与客户关联的[最新遥测](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"}值。遥测可由客户相关设备、服务生成或为分析与建模手动添加。
- **添加遥测：** 点击 "**+**" 图标，然后定义键、值类型和值。
- **删除遥测：** 点击垃圾桶图标，选择删除模式（全部数据、最新值、除最新外全部或按时间范围），并确认操作。

<b><font size="3">计算字段</font></b>   
显示使用公式根据现有属性或遥测计算得出的字段值。用于在客户级别派生额外业务指标。更多关于计算字段见[此处](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}。

<b><font size="3">告警规则</font></b>   
包含为客户配置的告警规则。这些规则定义如何根据客户级数据或关联资产/设备生成告警。配置告警规则见[此处](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}。

<b><font size="3">告警</font></b>  
显示与该客户相关的所有活动及历史[告警](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"}。便于跟踪影响客户或其基础设施的运行问题、警告和关键事件。

<b><font size="3">事件</font></b>   
显示与客户相关的系统事件——日志、警告、错误及生命周期活动。便于诊断和监控客户相关操作。

<b><font size="3">关系</font></b>   
显示客户与其他实体（如资产、设备、仪表板或 Rule Chain）之间的有向[关系](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations){:target="_blank"}。提供客户在系统中的结构化视图。

<b><font size="3">审计日志</font></b>   
提供与客户相关的[用户操作记录](/docs/{{docsPrefix}}user-guide/audit-log/){:target="_blank"}——创建、更新、配置变更及删除。支持安全审计与变更追踪。

<b><font size="3">版本控制</font></b>   
支持使用基于 Git 的[版本控制](/docs/{{docsPrefix}}user-guide/version-control/){:target="_blank"}服务导出和恢复客户相关实体。用于备份、协作工作流及配置版本管理。

<hr>

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 您的反馈

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星，帮助我们推广。
如有疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。
