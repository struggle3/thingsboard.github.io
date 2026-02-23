{% assign feature = "Image gallery" %}{% include templates/mqtt-broker/pe-tbmq-feature-banner.md %}

* TOC
{:toc}

图库作为 TBMQ 应用中管理图片的集中仓库。
为[应用](/docs/pe/mqtt-broker/white-labeling/#customize-tbmq-web-interface)和[登录](/docs/pe/mqtt-broker/white-labeling/#customize-the-login-page)页面的**白标**功能提供徽标和网站图标来源。

![image](/images/pe/mqtt-broker/user-guide/white-labeling/image-gallery.png)

## 添加图片

可通过[图片格式](#upload-image)（PNG、JPEG、GIF 等）或[JSON 格式](#import-image-from-json)将图片添加到图库。

### 上传图片

以**图片格式**上传新图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="upload-image-1" showListImageTitles="true" %}

### 从 JSON 导入图片

以 **JSON 格式**导入图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="upload-image-2" showListImageTitles="true" %}

## 切换图片查看模式

支持列表和网格两种查看模式。
在图库窗口左上角选择所需模式即可切换。

{% include images-gallery.html imageCollection="image-viewing-mode" %}

## 图片操作

可通过图片名称旁的对应图标进行[下载](#download-image)、[导出为 JSON](#export-image-to-json)、[编辑](#edit-image)和[删除](#delete-image)操作。
以下分别说明各操作。

### 下载图片

以图片格式下载可通过以下两种方式（取决于当前查看模式）：

- 列表视图：点击要导出图片名称旁的“下载图片”图标。
- 网格视图：将鼠标悬停在要导出的图片上，点击“下载图片”图标。

图片将以图片格式保存到本地。

{% include images-gallery.html imageCollection="download-image-1" %}

### 导出为 JSON

导出为 JSON 可通过以下两种方式（取决于当前查看模式）：

- 列表视图：点击要导出图片名称旁的“导出为 JSON”图标。
- 网格视图：将鼠标悬停在要导出的图片上，点击“导出为 JSON”图标。

图片将以 JSON 格式保存到本地。

{% include images-gallery.html imageCollection="export-image-1" %}

### 编辑图片

点击要编辑图片名称旁的“编辑图片”图标打开编辑窗口（网格视图下，先悬停在图片上再点击）。
在编辑窗口中可修改名称、下载、导出为 JSON，以及[更新图片](#update-image)。

修改图片名称时，输入新名称并在“编辑图片”窗口中点击“保存”图标。

{% include images-gallery.html imageCollection="edit-image-1" %}

#### 更新图片

当同一张图片被多处用作背景时，更新功能非常实用。
只需修改一次，所有引用该图片的位置都会自动更新，无需逐处编辑。

更新图片时，在编辑窗口中点击“更新图片”按钮，选择新图片或将其拖入“更新图片”窗口后点击“更新”。 

{% include images-gallery.html imageCollection="update-image-1" %}

### 删除图片

从图片列表中删除图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="delete-image-1" showListImageTitles="true" %}

删除以网格显示的图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="delete-image-2" showListImageTitles="true" %}

也可批量删除多张图片（仅支持列表视图）：

{% include images-gallery.html imageCollection="delete-image-3" showListImageTitles="true" %}
