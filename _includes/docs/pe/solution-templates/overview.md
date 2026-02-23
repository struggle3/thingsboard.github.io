
* TOC 
{:toc}

ThingsBoard提供IoT解决方案模板，可显著缩短物联网产品的上市时间。
每个解决方案模板代表一个可即用的PoC或MVP，包含：
- 预配置的交互式仪表板
- 数据处理与业务逻辑
- 示例设备和用户
- 所需平台[实体](/docs/{{docsPrefix}}user-guide/entities-and-relations/)及关系

解决方案模板可助您快速评估用例、演示功能，或作为进一步定制的基础。

{% include templates/solution-templates.md %}

通过导航至“<b>Solution templates</b>”菜单项浏览可用解决方案模板。

{% include images-gallery.html imageCollection="open-solution-templates-page" %}

## 管理解决方案模板

> 仅租户管理员可管理解决方案模板。

每个解决方案模板提供以下操作：

### 查看详情

使用**Details**按钮打开模板说明。

{% include images-gallery.html imageCollection="view-details" %}

### 安装解决方案

使用**Install**按钮安装模板。

安装完成后，将自动跳转至对应模板的主仪表板，并弹出说明对话框。
浏览说明后点击**Close**按钮开始使用解决方案。

{% include images-gallery.html imageCollection="install-solution" %}

### 查看说明

解决方案安装后会自动生成说明文档，可通过**Instructions**按钮打开。

{% include images-gallery.html imageCollection="view-instructions" %}

### 删除解决方案

使用**Delete**按钮可移除已安装的解决方案以及安装过程中创建的所有[实体](/docs/{{docsPrefix}}user-guide/entities-and-relations/){:target="_blank"}。

> 请注意，您可能通过解决方案仪表板创建的用户、设备等实体不会自动删除。

{% include images-gallery.html imageCollection="delete-solution" %}

## 连接真实设备

每个解决方案模板均包含详细说明，描述：
- 预期的遥测与属性负载格式
- 必需的键与数据结构
- 向平台发送数据的示例命令

所提供示例使用**模板安装时自动生成的设备和凭据**。
建议先使用这些示例了解解决方案的工作方式。

随后，请参考[如何连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/){:target="_blank"}指南，使用生产环境凭据连接真实设备。
