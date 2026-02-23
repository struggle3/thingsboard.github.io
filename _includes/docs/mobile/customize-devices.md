{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{{appPrefix}}允许为每种设备类型/配置配置设备图标。
设备图标可在设备配置表单中配置：

1. 通过屏幕左侧主菜单进入**设备配置**；
2. 点击要修改的设备配置；
3. 在打开的设备配置详情中点击**编辑**按钮；
4. 在**设备配置图像**字段中上传所需图像；
5. 点击**应用更改**按钮；

{% include images-gallery.html imageCollection="device-image" %}
