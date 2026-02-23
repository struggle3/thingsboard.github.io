* TOC
{:toc}

"**移动中心**"中的"**应用**"选项卡用作[移动应用](/docs/{{docsPrefix}}mobile/){:target="_blank"}的控制中心。它允许您：

- **添加新应用**：创建与ThingsBoard集成的新移动应用配置。
- **编辑现有应用**：更新应用详情，如包名、状态、版本或应用商店信息。
- **删除应用**：从ThingsBoard平台移除过时或未使用的应用配置。

## 添加应用

要添加新的移动应用，请遵循以下步骤：

- 进入"**移动中心**"页面的"**应用**"选项卡，并点击窗口右上角的"**+ 添加应用**"按钮。
- 输入**应用包**名称。
- 选择**平台类型**：Android或iOS。
- **应用密钥**将自动生成。请记住或替换为您自己的。
- 设置**应用状态**：
  - **草稿**：适用于仍在开发中的应用。您可以在应用创建并发布后添加应用商店信息（如Google Play Store或App Store链接、SHA256证书指纹或App ID）。
  - **已发布**：适用于已准备好发布供最终用户使用的应用。
  - **已弃用**：适用于不再积极支持但仍可用的旧版应用。
  - **已暂停**：适用于暂时禁用或限制使用的应用。
- （可选）指定最低/最新应用版本及发布说明。
- 添加**应用商店信息**：
  - **Android**：**Google Play Store链接**和**SHA256证书指纹**。
  - **iOS**：**App Store链接**和**App ID**。
- 点击"**添加**"保存应用并完成流程。

{% include images-gallery.html imageCollection="add-application" %}

## 编辑应用

您几乎可以编辑移动应用的所有字段，平台类型除外。
要编辑移动应用，请打开其详情并点击大型橙色"铅笔"按钮进入编辑模式。进行必要的更改，然后保存。

{% include images-gallery.html imageCollection="edit-application" %}

## 删除应用

要删除应用，请点击"垃圾桶"图标，然后确认删除。

{% include images-gallery.html imageCollection="delete-application" %}
