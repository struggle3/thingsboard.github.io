* TOC
{:toc}

{% assign sinceVersion = "3.6.2" %}
{% include templates/since.md %}

Image gallery 作为集中存储和管理图片的仓库。
是提升移动应用中部件、仪表板、设备和资产配置文件视觉效果与功能的重要资源。
用户可方便地上传、整理和选择图片以定制界面与体验，确保平台整体风格统一、品牌一致。

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/image-gallery/image-gallery-pe.png)
{% endif %}
{% if docsPrefix == null %}
![image](/images/user-guide/image-gallery/image-gallery-ce.png)
{% endif %}

{% unless docsPrefix contains 'paas/' %}
## 缓存配置

图片 API 使用 *ETags* 优化缓存，仅在图片发生变化时重新下载，从而节省带宽。
默认不设置 Cache-Control 头，依赖 ETags 的效率。
可通过以下环境变量自定义缓存行为： 

- *CACHE_SPECS_IMAGE_ETAGS_TTL* - 图片 ETags 缓存 TTL。默认 44640 分钟，此后缓存将被删除；

- *CACHE_SPECS_IMAGE_ETAGS_MAX_SIZE* - 最大缓存大小（字节）。0 表示禁用缓存；

- *CACHE_SPECS_IMAGE_SYSTEM_BROWSER_TTL* - 系统图片浏览器缓存 TTL（分钟）。默认 0 分钟，表示禁用缓存；

- *CACHE_SPECS_IMAGE_TENANT_BROWSER_TTL* - 租户图片浏览器缓存 TTL（分钟）。默认 0 分钟，表示禁用缓存。

这些配置控制系统和租户图片在用户浏览器缓存中的生存时间 (TTL)。
较长的 TTL 可提高重复访问的加载速度并降低服务器负载，较短的 TTL 可让用户更频繁获得内容更新。
可根据图片更新频率调整。具体方法见[此处](/docs/user-guide/install/{{docsPrefix}}how-to-change-config/)。

此外，系统管理员可通过配置[租户配置文件](/docs/{{docsPrefix}}user-guide/tenant-profiles/#files-limits)限制单张图片最大尺寸及图片总大小。
单位为字节。
{% endunless %}

## 添加图片

可按[图片文件格式](#upload-image)（PNG、JPEG、GIF 等）或 [JSON 文件格式](#import-image-from-json) 将图片添加到 Image gallery。

### 上传图片

以**图片文件格式**上传新图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="upload-image-1" showListImageTitles="true" %}

### 从 JSON 导入图片

以 **JSON 文件格式**导入图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="upload-image-2" showListImageTitles="true" %}

## 系统图片

Image gallery 包含系统图片，也可用于设计仪表板、部件等。默认情况下，图片列表中仅显示您的图片。
要同时显示您和系统图片，请启用 Enable System Images 选项。

{% include images-gallery.html imageCollection="include-system-images" %}

{% capture difference %}
**请注意：**
仅系统管理员可删除、重命名或更新系统图片。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 切换图片视图模式

可在列表或网格两种模式下查看图片。
要切换视图模式，在 Image gallery 窗口左上角选择所需模式即可。

{% include images-gallery.html imageCollection="image-viewing-mode" %}

## 图片操作

可通过图片名称旁对应图标进行[下载](#download-image)、[导出为 JSON](#export-image-to-json)、[编辑](#edit-image)、[嵌入](#embed-image)和[删除](#delete-image)操作。
以下逐项说明。

### 下载图片

根据当前图片查看格式，可通过两种方式下载图片文件：

- 使用列表视图时，点击要导出的图片名称旁的 "Download image" 图标。
- 使用网格视图时，将鼠标悬停在要导出的图片上，点击 "Download image" 图标。

图片将以图片文件格式保存到您的电脑。

{% include images-gallery.html imageCollection="download-image-1" %}

### 导出图片为 JSON

根据当前图片查看格式，可通过两种方式导出为 JSON：

- 使用列表视图时，点击要导出的图片名称旁的 "Export image to JSON" 图标。
- 使用网格视图时，将鼠标悬停在要导出的图片上，点击 "Export image to JSON" 图标。

图片将以 JSON 格式保存到您的电脑。

{% include images-gallery.html imageCollection="export-image-1" %}

### 嵌入图片

将图片添加到 Image gallery 后，可嵌入到 HTML 卡片部件、部件编辑器的 HTML 区域、单元格内容函数、自定义操作等。

系统级图片对所有平台用户可见，租户级图片可能仅对特定租户可见。
ThingsBoard 平台上每张图片都有唯一 URL，支持带认证和不带认证下载。

使用下列代码片段可将图片嵌入基于纯 HTML 的组件，无需认证。例如在 *HTML Card* 部件、单元格内容函数等中：

```java
<img src="relative link to the image" alt="text description of the image" />
```

若要将图片嵌入 Angular HTML 模板，例如在 *Markdown/HTML Card* 部件或部件编辑器的 HTML 区域中，请使用：

```java
<img [src]="'image URL' | image | async" />
```

此方式会在图片请求中自动添加认证头，使同一图片 URL 可为不同用户返回不同图片。

<br>
获取用于嵌入的图片链接，请按以下步骤操作。

- 进入 "Resources" 下的 "Image gallery" 页面；
- 点击要嵌入图片的 "Embed image" 图标（使用网格视图时，将鼠标悬停在图片上后点击 "Embed image" 图标）；
- 选择 Angular HTML 模板或纯 HTML 组件的代码片段，并复制该图片的对应唯一链接。

{% include images-gallery.html imageCollection="embed-image" %}

### 编辑图片

点击要编辑的图片名称旁的 "Edit image" 图标（使用网格视图时，将鼠标悬停在图片上后点击 "Edit image" 图标）可打开编辑窗口。
在窗口中可修改名称、下载、导出为 JSON、嵌入，也可[更新图片](#update-image)。

{% include images-gallery.html imageCollection="edit-image-1" %}

若要修改图片名称，在 "Edit image" 窗口中输入新名称并点击 "Save" 图标。

{% include images-gallery.html imageCollection="edit-image-2" %}

#### 更新图片

更新图片适用于例如一张图片用作多个仪表板背景的场景。
只需修改一次，所有使用该图片的仪表板会自动获得更新，无需逐个编辑。

要更新图片，在编辑窗口中点击 "Update image" 按钮。选择新图片或将其拖拽到 "Update image" 窗口，然后点击 "Update"。

{% include images-gallery.html imageCollection="update-image-1" %}

### 删除图片

从图片列表中删除图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="delete-image-1" showListImageTitles="true" %}

删除以网格显示的图片，请按以下步骤操作：

{% include images-gallery.html imageCollection="delete-image-2" showListImageTitles="true" %}

也可一次删除多张图片（仅可通过列表视图）：

{% include images-gallery.html imageCollection="delete-image-3" showListImageTitles="true" %}

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
