---
layout: docwithnav-paas
assignees:
- stitenko
title: 应用
description: 应用

add-application:
    0:
        image: /images/mobile-center/applications/add-application-1-pe.png
        title: '进入"移动中心"页面的"应用"选项卡，并点击窗口右上角的"+ 添加应用"按钮。'
    1:
        image: /images/mobile-center/applications/add-application-2-pe.png
        title: '输入应用包名并选择平台类型：Android或iOS。记住自动生成的"应用密钥"或输入您自己的。指定应用状态。可选：提供最低和最新应用版本及其发布说明。'
    2:
        image: /images/mobile-center/applications/add-application-3-pe.png
        title: '添加应用商店信息，点击"添加"完成。'
    3:
        image: /images/mobile-center/applications/add-application-4-pe.png
        title: ''

edit-application:
    0:
        image: /images/mobile-center/applications/edit-application-1-pe.png
        title: '要编辑移动应用，打开其详情并通过点击大型橙色"铅笔"按钮进入编辑模式；'
    1:
        image: /images/mobile-center/applications/edit-application-2-pe.png
        title: '进行必要的更改，然后保存；'
    2:
        image: /images/mobile-center/applications/edit-application-3-pe.png
        title: ''

delete-application:
    0:
        image: /images/mobile-center/applications/delete-application-1-pe.png
        title: '要删除应用，点击"垃圾桶"图标；'
    1:
        image: /images/mobile-center/applications/delete-application-2-pe.png
        title: '确认删除'

---

{% assign docsPrefix = "paas/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/mobile-center/applications.md %}
