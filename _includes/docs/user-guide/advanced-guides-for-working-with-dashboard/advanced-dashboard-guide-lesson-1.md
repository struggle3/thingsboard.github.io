* TOC
{:toc}

{% capture difference %}
在继续本指南前，建议先完成 [Getting Started](/docs/{{docsPrefix}}getting-started-guides/helloworld/){:target="_blank"} 指南，熟悉 ThingsBoard 设备和 dashboards，以便更好地理解下文概念。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

假设您有多栋建筑，每栋内有多个办公空间，配有监控水电气用量、CO2、温湿度的设备。
本课为该系列第一步，通过分步教程帮助您创建用于可视化和监控楼宇集成设备数据的多功能 dashboard。

完成本系列后，您将能够：

- 在地图部件上展示建筑；
- 显示办公空间列表及每个的详细信息；
- 显示所选办公室内的设备列表，并在平面图上展示其布局；
- 为每台设备开发专属面板，展示实时与历史数据；
- 与客户共享 dashboard。

为简化，我们将聚焦 Building A 的一间办公室，配备智能设备监控能耗与环境条件。

从基础开始：添加新实体、建立相互关系，并在 OpenStreet Map 与 Entities table 部件中展示建筑。
完成本指南后，您的 dashboard 将类似如下：

![image](/images/user-guide/advanced-guides-for-working-with-dashboard/lesson-1/lesson-1-pe.png)

{% include templates/prerequisites-pe.md %}

## Adding entities and establishing relationships between them

在添加和配置 dashboard 前，需先添加若干实体，即 assets 和 devices。
Assets 代表建筑和办公室，devices 代表传感器。

### Adding assets

[Assets](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"} 为可与其它 assets 和 devices 关联的抽象 IoT 实体。

本教程中，我们将创建两个代表建筑的 assets：**Building A** 与 **Building B**，以及两个代表办公空间的 assets：**Office A** 与 **Office B**。
开始操作。

- 以 [Tenant Administrator](/docs/{{docsPrefix}}user-guide/ui/tenants/){:target="_blank"} 登录 ThingsBoard；
- 进入侧边栏 "Entities" 下的 "Assets" 页面。默认会进入 "All" 设备组，我们先在此组添加 assets；
- 点击表格右上角 "plus" 图标，在下拉菜单中选择 "Add new asset" 开始添加第一个 asset；
- 在 asset 名称字段输入 "Building A"。在 "Asset profile" 区域输入 "building"，点击 "Create a new one!" 为该 asset 新建 profile；
- 点击 "Add" 确认 asset profile 创建；
- 再点击 "Add" 完成 asset 添加。

恭喜，您已添加第一个 asset。

{% include images-gallery.html imageCollection="adding-assets-1" %}

同样添加 asset "Building B"。再添加 asset type 为 "office" 的 "Office A" 和 "Office B"。

{% include images-gallery.html imageCollection="adding-assets-2" %}

### Adding devices

[Devices](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"} 是采集环境数据并上传到 ThingsBoard，同时响应 Remote Procedure Call (RPC) 命令的基础 IoT 对象。

可像 assets 一样手动添加 devices。ThingsBoard 也支持通过 CSV 对 devices（和 assets）进行 [bulk provisioning](/docs/{{docsPrefix}}user-guide/bulk-provisioning/){:target="_blank"}，批量添加实体时非常方便。

本教程需添加四台设备：Indoor Air Quality Sensor、Energy Meter、Water Flow Meter、IAQ Sensor。后续将用模拟器模拟这些设备向 ThingsBoard 发送 telemetry。
开始操作：

- 创建 CSV 文件或 [下载预置文件](/docs/user-guide/advanced-guides-for-working-with-dashboard/files-from-tutorial/devices.csv){:target="_blank"}，每行对应创建一台带指定参数的设备：

| **Name** | **Type**      | **Label**                 |
|:---------|:--------------|---------------------------|
| SD-001   | air-sensor    | Indoor Air Quality Sensor |
| EM-002   | energy-sensor | Energy Meter              |
| WM-003   | water-sensor  | Water Flow Meter          |
| AM-307   | air-sensor    | IAQ Sensor                |
| ---      

CSV 文件应类似如下：

```text
name,type,label
SD-001,air-sensor,Indoor Air Quality Sensor
EM-002,energy-sensor,Energy Meter
WM-003,water-sensor,Water Flow Meter
AM-307,air-sensor,IAQ Sensor
```
{: .copy-code}

- 进入侧边栏 "Entities" 下的 "Devices" 页面。默认会进入 "All" 设备组；
- 点击表格右上角 "plus" 图标，在下拉菜单中选择 "Import device"；
- 将 CSV 文件拖入导入窗口，点击 "Continue"；
- 选择 CSV 分隔符，点击 "Continue"；
- 将上传文件列与 ThingsBoard 数据类型映射，点击 "Continue"，再点击 "OK"。

应成功创建四台新设备："SD-001"（Indoor Air Quality Sensor）、"EM-002"（Energy Meter）、"WM-003"（Water Flow Meter）、"AM-307"（IAQ Sensor）。

{% include images-gallery.html imageCollection="adding-devices-1" %}

### Adding relations between entities

[Relations](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations){:target="_blank"} 为一个实体与一个或多个实体间的有向连接。
为确保 Office A 和 Office B 仅与 Building A 关联，我们建立它们之间的关系。按以下步骤操作：

- 回到 "Assets" 页面，点击 "Building A" 打开详情。进入 "Relations" 选项卡，确认方向为 "From"，点击 "plus" 添加新 relation；
- 选择 type "Assets"，在实体列表中指定 "Office A" 和 "Office B"。点击 "Add"。

Office A 和 Office B 现已仅与 Building A 关联。

{% include images-gallery.html imageCollection="relations-from-building-to-office" %}

现在为设备 "SD-001"（Indoor Air Quality Sensor）、"EM-002"（Energy Meter）、"WM-003"（Water Flow Meter）与 Office A 建立 relations：

- 点击 "Office A"，进入 "Relations" 选项卡。确认方向为 "From"，点击 "plus"；
- 选择 type "Device"，在实体列表中指定 "SD-001"、"EM-002" 和 "WM-003"。点击 "Add"。

指定设备现已与 "Office A" asset 建立 relation。

{% include images-gallery.html imageCollection="relations-from-office-to-device-1" %}

同样，建立 "AM-307"（IAQ Sensor）设备与 "Office B" asset 的关系。

{% include images-gallery.html imageCollection="relations-from-office-to-device-2" %}

## Adding dashboard

[dashboard](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"} 不仅是用于以便利格式展示数据的空间。
创建结构清晰、视觉效果良好的 dashboard 对高效监控与管理 assets 和 devices 至关重要。

添加 dashboard 以开始在其上可视化 assets 和 devices。我们将为 dashboard 单独建组：

- 进入 "Dashboards" 页面，切换到 "Groups" 选项卡。点击 "plus" 创建新 dashboard 组，命名为 "Buildings"，点击 "Add"；
- 打开新建的 dashboard 组；
- 点击屏幕右上角 "plus" 添加新 dashboard；
- 输入 dashboard 标题 "Buildings"，点击 "Add"；
- 点击屏幕右上角 "Save" 保存 dashboard。

首个 dashboard 已成功添加，添加后会自动打开。点击页面右上角 "Save" 保存。

{% include images-gallery.html imageCollection="adding-dashboard" %}

## OpenStreet Map widget

接下来添加第一个 [widget](/docs/{{docsPrefix}}user-guide/widgets/){:target="_blank"} —— OpenStreet Map，用于在地图上展示 Building A 和 Building B。
要在地图上显示建筑，需将其坐标（纬度和经度）设为 attributes。

此外将配置部件：点击建筑标记时显示建筑一般信息，包括地址、邮箱、电话和图片。
这些信息也将作为 attributes 添加。

先从准备着手——添加建筑图片和 attributes。

### Upload building images

建筑图片需上传至 [Image gallery](/docs/{{docsPrefix}}user-guide/image-gallery/#upload-image){:target="_blank"}，作为集中存储和管理图片的仓库。
将用于地图部件的 tooltip。可使用本指南中的 [Building A](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/645-5th-Ave-New-York.png){:target="_blank"} 与 [Building B](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/641-E-54th-St-New-York.png){:target="_blank"} 图片，或上传自己的图片。

{% include images-gallery.html imageCollection="adding-buildings-images" showListImageTitles="true" %}

获取并保存这些图片的链接，以便在建筑 attributes 中使用：

{% include images-gallery.html imageCollection="embed-buildings-images" showListImageTitles="true" %}

### Adding the necessary attributes

接下来添加所需的 attributes：

{% include images-gallery.html imageCollection="adding-building-attributes-1" showListImageTitles="true" %}

本示例中 buildings 使用的坐标：

| **Building** | **latitude**        | **longitude** |
|:-------------|:--------------------|---------------|
| Building A   | 40.75912            | -73.97600     |
| Building B   | 40.75901            | -73.96997     |
| ---

同样添加以下 attributes："**address**"、"**email**"、"**phone**"、**"contactPerson"** 和 "**buildingImage**"，取值见下表。这些 attributes 使用 value type "String"。

{% include images-gallery.html imageCollection="adding-building-attributes-2" %}

本示例中 buildings 的信息：

| **Building** | **Address**                 | **Email**           | **Phone**      | **Contact person** | **Building image**                   |
|:-------------|:----------------------------|:--------------------|:---------------|:-------------------|:-------------------------------------|
| Building A   | 645 5th Ave, New York       | building-a@mail.com | +121 244 55 66 | Thomas Johnson     | Use the link to the Building A image |
| Building B   | 641 Lexington Ave, New York | building-b@mail.com | +121 555 66 77 | Jack Williams      | Use the link to the Building B image |
|---

Building A 的 attributes 列表最终应如下：

{% include images-gallery.html imageCollection="adding-building-attributes-3" %}

Building B 的 attributes 列表应如下：

{% include images-gallery.html imageCollection="adding-building-attributes-4" %}

### Adding OpenStreet Map widget

准备工作已完成，现在可添加 **OpenStreet Map** 部件：

- 打开已创建的 "Buildings" dashboard；
- 点击屏幕顶部的 "Add widget" 或点击中央大图标 "Add new widget"（若为本 dashboard 第一个部件）；
- 在 "Maps" 部件包中找到 "OpenStreet Map" 并点击；
- 需添加 [alias](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"} 以定义数据来源实体。在 "Alias" 字段输入名称 "Buildings"，点击 "Create a new one"；
- 输入 alias 名称，选择 filter type "Asset type"，指定 asset type "building"，点击右下角 "Add"。该 alias 将在部件中显示所有 "building" 类型的 assets；
- 添加以下 attributes 作为 data keys："latitude"、"longitude"、"address"、"email"、"phone"、"buildingImage"。

{% include images-gallery.html imageCollection="adding-maps-widget-1" %}

"Appearance" 选项卡：

- 进入 "Appearance" 选项卡，将 OpenStreet map provider 改为 "CartoDB.Positron"；

{% include images-gallery.html imageCollection="adding-maps-widget-2" %}

- 滚动到 "Label" 区域。标签位于标记上方，可显示实体信息，如名称、类型、telemetry 等。

    从文档中复制并在对应字段添加 label，以显示建筑名称并定制 tooltip 样式；

本示例使用的 label：

```js
<div style="position: relative; white-space: nowrap; text-align: center; font-size: 12px; top: -5px;"><span style="border-radius: 10px; background-color: #fff; padding-left: 12px; padding-right: 12px; padding-top: 4px; padding-bottom: 4px;">${entityName}</span></div>
```
{: .copy-code}

{% include images-gallery.html imageCollection="adding-maps-widget-3" %}

- 向下找到 "Tooltip" 区域。此处配置点击建筑标记时 tooltip 中显示的内容。
  - 开启 "Use tooltip function" 选项；
  - 使用文档中的函数以显示所选建筑的图片和联系方式。

本示例使用的 tooltip 函数：

```js
const address = data.address ? data.address : 'N/A';
const email = data.email ? data.email : 'N/A';
const phone = data.phone ? data.phone : 'N/A';
const buildingImage = data.buildingImage ? data.buildingImage : 'Building image not found';
return '<div style="display:flex;flex-direction:column;font-family:\'Roboto\';font-weight:500;font-size:14px;line-height:24px;letter-spacing:0.25px;color:#29313C;margin-bottom:5px">' +
            `<img style="width: 300px; height: auto" src=${buildingImage}>` +
            '<div style="margin-top:5px;">${entityName}</div>' +
            '<div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;gap:10px">' +
                '<div style="font-size:11px;line-height:16px;font-weight:500;color:rgba(0, 0, 0, 0.38);">Address</div>' +
                '<div style="font-size:12px;line-height:20px;font-weight:500;color:#29313C;letter-spacing:0.25px;text-align:right;">'+ address +'</div>' +
            '</div>' +
            '<div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;gap:10px">' +
                '<div style="font-size:11px;line-height:16px;font-weight:500;color:rgba(0, 0, 0, 0.38);">Email</div>' +
                '<div style="font-size:12px;line-height:20px;font-weight:500;color:#29313C;letter-spacing:0.25px;text-align:right;">'+ email +'</div>' +
            '</div>' +
            '<div style="display:flex;flex-direction:row;align-items:baseline;justify-content:space-between;gap:10px">' +
                '<div style="font-size:11px;line-height:16px;font-weight:500;color:rgba(0, 0, 0, 0.38);">Phone</div>' +
                '<div style="font-size:12px;line-height:20px;font-weight:500;color:#29313C;letter-spacing:0.25px;text-align:right;">'+ phone +'</div>' +
            '</div>'
       '</div>';
```
{:.copy-code.expandable-5}

{% include images-gallery.html imageCollection="adding-maps-widget-4" %}

- 在 "Marker image" 区域关闭 "Use marker image function"，添加自定义 marker 图片。点击 "Browse from gallery" 上传新 marker 图。使用 [提供的自定义 marker 图](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/building-icon.svg){:target="_blank"} 或上传自己的 marker 图。将 marker 大小设为 60 像素；

{% include images-gallery.html imageCollection="adding-maps-widget-5" %}

"Widget card" 选项卡：

- 进入 "Widget card" 选项卡。关闭 "Display widget title"；
- 将 padding 设为 0；
- 打开 "Advanced widget style" 区域。从文档复制 CSS 粘贴到 "Widget CSS"。此 CSS 定义 tooltip 样式；

```css
.leaflet-popup-content {
  width: auto !important;
  margin: 8px;
}
a.leaflet-popup-close-button {
  font-size: 20px;
  color: black;
  backdrop-filter: blur(5px);
  background: rgba(255, 255, 255, 0.35);
  border-radius: 2px;
  top: 17px;
  right: 17px;
}
``` 
{:.copy-code}

- 关闭 "Enable data export"；
- 点击 "Add" 确认添加部件。

{% include images-gallery.html imageCollection="adding-maps-widget-6" %}

恭喜，第一个部件已添加，可展示两栋建筑。将部件拖到 dashboard 右上角，拖动角点调整大小。
调整好后，点击右上角 "Save" 保存 dashboard。

{% include images-gallery.html imageCollection="adding-maps-widget-7" %}

点击任一建筑图片即可在 tooltip 中显示其信息。

{% include images-gallery.html imageCollection="adding-maps-widget-8" %}

## Adding Buildings list widget

已有部件在地图上显示两栋建筑。下面再添加 Entities table 部件，以列表形式展示建筑。

{% include images-gallery.html imageCollection="adding-entities-table-widget-1" showListImageTitles="true" %}

dashboard 现包含两个部件：第一个在地图上显示建筑位置，第二个以列表形式显示建筑及其地址。

{% include images-gallery.html imageCollection="adding-entities-table-widget-2" %}

## Customize the appearance of the dashboard

通过定制外观使 dashboard 更美观。我们将为 "Buildings" 状态设置自定义背景，并为部件应用自定义 CSS。

**设置自定义背景图**

为 "Buildings" 状态添加自定义背景图，可提升视觉效果并与品牌或审美一致。
可使用 [本教程图片](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/district-night-background.png){:target="_blank"} 或自定义图片。

{% include images-gallery.html imageCollection="background-image-building-state" showListImageTitles="true" %}

**用 CSS 定制部件外观**

我们还将用 CSS 修改 dashboard 上所有部件的样式，包括圆角和阴影。

- 点击 dashboard 工具栏的 "Settings"；
- 滚动到 "Advanced settings" 区域，可在此修改影响整个 dashboard 的深度设置；
- 在 "Dashboard CSS" 区域输入以下 CSS 以统一样式：

```text
.tb-widget-container > .tb-widget {
    border-radius: 8px;
    box-shadow: 0px 4px 10px rgba(23, 33, 90, 0.5);
}
.tb-dashboard-page .tb-widget-container > .tb-widget .leaflet-popup a.tb-custom-action {
    font-family: 'Roboto';
    font-weight: 500;
    font-size: 14px;
    line-height: 20px;
    letter-spacing: 0.25px;
    border-bottom: none;
    color: #00695C;
}
```
{: .copy-code}

此 CSS 作用于 `.tb-widget-container` 直接子元素中带有 `.tb-widget` 类的元素。
`border-radius: 8px` 使圆角柔和，`box-shadow: 0px 4px 10px rgba(23, 33, 90, 0.5)` 产生半透明模糊阴影并向下偏移 4 像素，增加层次感；`opacity: 0.9` 使元素略透明，在保持内容可见的前提下透出背景。

- 输入 CSS 后点击 "Save" 应用；
- 点击页面右上角 "Save" 保存 dashboard。

可见部件现已圆角，背景略透明。

{% include images-gallery.html imageCollection="dashboard-settings-css" %}

## Final view of the dashboard for this lesson

本课完成后的 dashboard 效果如下：

{% include images-gallery.html imageCollection="dashboard-final-lesson-1" %}

## Next step

恭喜完成本系列第一课！您已创建可列出建筑并在地图部件上直观展示其位置的 dashboard。
这为后续课程中更进阶的功能打下基础。

在第二部分，我们将继续开发 dashboard。准备就绪后，点击下方按钮继续。

<br>
<p><a href="/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-2/" class="button">Lesson 2. Dashboard states, widget actions, and analogue and digital gauges</a></p>