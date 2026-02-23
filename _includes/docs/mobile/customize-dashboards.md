{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

* TOC
{:toc}

## 概述

{{appPrefix}}允许配置移动应用主屏幕中仪表板列表的显示方式。
与移动应用相关的所有配置选项均在仪表板详情表单中可用。

## 仪表板图像

您可以在仪表板详情表单中为移动应用配置仪表板图像：

{% if docsPrefix == 'pe/' %}
1. 通过屏幕左侧主菜单进入**仪表板组**；
2. 打开目标仪表板组；
{% else %}
1. 通过屏幕左侧主菜单进入**仪表板**；
{% endif %}
2. 点击要修改的仪表板；
3. 在打开的仪表板详情中点击**编辑**按钮；
4. 在**仪表板图像**字段中上传所需图像；
5. 点击**应用更改**按钮；

{% include images-gallery.html imageCollection="dashboard-image" %}

## 仪表板顺序

您可以配置移动应用主屏幕中的仪表板顺序：

{% if docsPrefix == 'pe/' %}
1. 通过屏幕左侧主菜单进入**仪表板组**；
2. 打开目标仪表板组；
{% else %}
1. 通过屏幕左侧主菜单进入**仪表板**；
{% endif %}
2. 点击要修改的仪表板；
3. 在打开的仪表板详情中点击**编辑**按钮；
4. 在**移动应用中的仪表板顺序**字段中输入所需顺序；
5. 点击**应用更改**按钮；

{% include images-gallery.html imageCollection="dashboard-order" %}

## 在移动应用中隐藏仪表板

您可以隐藏移动应用主屏幕中的特定仪表板：

{% if docsPrefix == 'pe/' %}
1. 通过屏幕左侧主菜单进入**仪表板组**；
2. 打开目标仪表板组；
{% else %}
1. 通过屏幕左侧主菜单进入**仪表板**；
{% endif %}
2. 点击要修改的仪表板；
3. 在打开的仪表板详情中点击**编辑**按钮；
4. 勾选**在移动应用中隐藏仪表板**复选框；
5. 点击**应用更改**按钮；

{% include images-gallery.html imageCollection="hide-dashboard" %}


## 修改导航栏

您可以使用[移动中心](/docs/{{docsPrefix}}mobile-center/mobile-center/#layout)重新排序项目并显示或隐藏导航栏中的选项卡。

{% include images-gallery.html imageCollection="layout-1" %}
