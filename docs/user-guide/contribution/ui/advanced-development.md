---
layout: docwithnav
assignees:
- ikulikov
title: 部件进阶开发
description: ThingsBoard Extensions 与外部库集成

add-js-module:
    0:
        image: /images/user-guide/contribution/extensions/add-js-module-1-ce.png
        title: '进入「JavaScript library」页面，点击「plus」图标。在打开的弹窗中，在「JavaScript type」选择器中选择「Extension」，输入模块标题，拖拽包含已编译组件的文件。然后点击「Add」。'
    1:
        image: /images/user-guide/contribution/extensions/add-js-module-2-ce.png
        title: '恭喜，你的组件已成功添加到 ThingsBoard！'

select-extensions-module:
    0:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-1-ce.png
        title: '进入「Resources」下的「Widgets library」页面，点击窗口右上角的「plus」图标，选择「Create new widget」。然后选择部件类型「Latest value」；'
    1:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-2-ce.png
        title: '输入部件名称。进入「Resources」选项卡，点击「Add」按钮；'
    2:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-3-ce.png
        title: '勾选「Is extension」，从下拉菜单中选择你的 extension 模块；'
    3:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-4-ce.png
        title: '模块已与部件连接。现在可在部件中使用 Angular 组件。进入「HTML」选项卡，添加自定义组件，示例中为「tb-example-table」。'
    4:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-5-ce.png
        title: '清空 self.onInit、self.onDataUpdated、self.onResize、self.onDestroy 的默认内容'
    5:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-6-ce.png
        title: '在「onDataUpdated」函数中添加以下代码：「self.ctx.$scope.exampleTableComponent.onDataUpdated();」'
    6:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-7-ce.png
        title: '根据文档添加新函数'
    7:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-8-ce.png
        title: '点击「Run」按钮预览部件效果。'
    8:
        image: /images/user-guide/contribution/extensions/add-latest-values-widget-9-ce.png
        title: '点击「Save」保存修改。'

---

{% include get-hosts-name.html %}
{% include /docs/user-guide/contribution/ui/advanced-development.md %}