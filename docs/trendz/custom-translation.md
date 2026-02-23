---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 自定义翻译
description: Trendz 自定义翻译配置
---

自 1.12 版本起，Trendz 支持多种语言，以确保不同地区的无缝用户体验。目前开箱即支持以下语言，此列表将随时间扩展：
* 英语
* 西班牙语
* 法语
* 德语

Trendz 使用您在 ThingsBoard 中为用户选择的语言。此设置会自动决定 Trendz 中显示的语言。如果 Trendz 不支持某语言，将默认使用英语。
此外，您可以添加新翻译或自定义现有翻译以满足您的需求。

要修改或为其他语言添加翻译，请按以下步骤操作：
* 从白标菜单打开自定义翻译选项卡。

  ![image](/images/user-guide/custom-translation/main-page-1-pe.png)

* 选择要修改的语言并打开高级选项卡。
* 查看和管理翻译键。Trendz 依赖预定义的翻译键集，可在[此仓库](https://github.com/thingsboard/trendz-localization)中获取。要自定义这些键，请在仓库中找到所需语言的 JSON 文件，
复制它，并追加到自定义翻译菜单下高级选项卡中的翻译中。然后根据需要修改键值以适配您的界面要求。
  ![image](/images/trendz/trendz-custom-translations.png)
* 输入或更新翻译后，保存更改并刷新 Trendz 实例以应用它们。
