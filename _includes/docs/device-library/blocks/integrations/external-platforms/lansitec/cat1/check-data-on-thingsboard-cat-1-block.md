## 在 ThingsBoard 上检查数据

设备已添加后，若其发送了数据，应会显示在[设备](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}中。
要检查数据，您可以在**实体**部分打开**设备**页面。设备应出现在设备列表中。您可以通过点击设备，然后打开**属性**或**最新遥测数据**选项卡来查看数据。

{% assign cat1Beacon1 = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-beacon1.png,
        title: 此时您应能看到来自设备的数据。
'
%}

{% include images-gallery.liquid imageCollection=cat1Beacon1 %}

为了获得更友好的视图，您可以使用[仪表板](/docs/{{docsPrefix}}user-guide/dashboards){:target="_blank"}。
您可以为此设备下载简单仪表板，其已配置为显示名称为「*Devices*」的设备的「latitude」和「longitude」遥测键数据。

ThingsBoard 支持创建和自定义用于监控和管理数据与设备的交互式可视化（仪表板）。
通过 ThingsBoard 仪表板，您可以高效地管理和监控 IoT 设备及数据。接下来，我们将为设备创建仪表板。

要将仪表板添加到 ThingsBoard，需要导入它。导入仪表板请按以下步骤操作：

- 首先下载[检查和控制设备数据仪表板](/docs/devices-library/resources/dashboards/lansitec-lorawan/cat1_check_and_control_device_data_dashboard.json){:target="_blank"}文件。

{% assign cat1Show = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-show-1.png,
        title: 进入「**仪表板**」页面。默认会进入仪表板组「全部」。点击右上角的「**加号**」图标。选择「**导入仪表板**」。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-show-2.png,
        title: 在仪表板导入窗口中，上传 JSON 文件并点击「**导入**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-show-3.png,
        title: 仪表板已导入。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=cat1Show %}

要打开已导入的仪表板，请点击它。然后需要在仪表板的实体别名中指定您的设备。

请按以下步骤操作：

{% assign cat1Show = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-edit-1.png,
        title: 打开仪表板并进入编辑模式。点击「**实体别名**」图标，在弹出窗口中点击别名旁的「**编辑别名**」图标。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-edit-2.png,
        title: 在编辑别名窗口中从下拉列表选择您的设备并保存实体别名。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-edit-3.png,
        title: 应用所有更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=cat1Show %}

此时您应能看到来自设备的数据。

带数据的仪表板示例：

{% assign cat1Beacon3 = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/cat1-beacon-3.png,
        title: 此时您应能看到来自设备的数据。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=cat1Beacon3 %}
