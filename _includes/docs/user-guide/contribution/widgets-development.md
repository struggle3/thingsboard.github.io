* TOC
{:toc}

## 简介

**ThingsBoard 部件**为可无缝集成到任意 [IoT Dashboard](/docs/{{docsPrefix}}user-guide/dashboards/) 的额外 UI 模块。提供数据可视化、远程设备控制、告警管理及静态自定义 HTML 等内容展示等终端用户功能。
每个部件定义根据所提供的功能代表特定的 [Widget Type](/docs/{{docsPrefix}}user-guide/ui/widget-library/#widget-types)。

## 创建新部件定义

要创建新部件定义，进入「Widget Library」并打开现有「Widgets Bundle」或新建一个。在「Widgets Bundle」视图中，点击屏幕右上角的「+」按钮，然后点击「Create new widget」按钮。

![image](/images/user-guide/contribution/widgets/create-new-widget-type.png)

将出现 "Select widget type" 窗口，选项对应你要开发的 [部件类型](/docs/{{docsPrefix}}user-guide/ui/widget-library/#widget-types)。

![image](/images/user-guide/contribution/widgets/select-widget-type.png)

随后会打开预填充的 "Widget Editor" 页面，根据所选部件类型提供初始模板。

![image](/images/user-guide/contribution/widgets/widget-editor.png)

### Widget Editor 概览

Widget Editor 视图是用于开发自定义部件定义的迷你 IDE。
包含 [顶部工具栏](#widget-editor-toolbar) 和四个主要区域：

 - [Resources/HTML/CSS](#resourceshtmlcss-section)    
 - [JavaScript](#javascript-section) 
 - [Settings schema](#settings-schema-section) 
 - [Widget preview](#widget-preview-section)

#### Widget Editor 工具栏

![image](/images/user-guide/contribution/widgets/widget-editor-toolbar.png)

工具栏包含以下项：

 - **Widget Title** 字段 - 指定部件定义标题
 - **Widget Type** 选择器 - 指定部件定义的 [类型](/docs/{{docsPrefix}}user-guide/ui/widget-library/#widget-types)
 - **Run** 按钮 - 运行部件代码并在 **Widget preview** 区域查看结果
 - **Undo** 按钮 - 将各编辑区还原到最近保存状态
 - **Save** 按钮 - 保存部件定义
 - **Save as** 按钮 - 指定新部件类型名和目标 **Widgets Bundle** 以保存副本
 
#### Resources/HTML/CSS section（资源/HTML/CSS 区域）

本区域包含三个选项卡：

第一个 **Resources** 选项卡用于指定部件使用的外部 JavaScript/CSS 资源。

![image](/images/user-guide/contribution/widgets/widget-editor-resources.png)

第二个 **HTML** 选项卡包含部件的 HTML 代码*（注：部分部件动态生成 HTML，因此初始 HTML 可能为空）。*

![image](/images/user-guide/contribution/widgets/widget-editor-html.png)

第三个 **CSS** 选项卡包含部件专用的 CSS 样式定义。 

![image](/images/user-guide/contribution/widgets/widget-editor-css.png)

#### JavaScript section（JavaScript 区域）

本区域包含根据 [Widget API](#basic-widget-api) 编写的全部部件相关 JavaScript 代码。  

![image](/images/user-guide/contribution/widgets/widget-editor-javascript.png)

#### Settings schema section（设置 schema 区域）

本区域包含两个选项卡：

第一个 **Settings schema** 选项卡用于指定部件设置的 JSON schema，以通过 react-schema-form [builder](http://networknt.github.io/react-schema-form/) 自动生成 UI 表单。
生成的 UI 表单显示在部件设置 **Appearance** 选项卡的 **Advanced** 模式中。
此 schema 序列化的 Settings 对象用于存储特定部件设置，并可从部件 JavaScript 代码访问。

![image](/images/user-guide/contribution/widgets/widget-editor-settings-schema.png)
 
第二个 **Data key settings schema** 选项卡用于指定 data key 设置的 JSON schema，以通过 react-schema-form [builder](http://networknt.github.io/react-schema-form/) 自动生成 UI 表单。
生成的 UI 表单显示在 **Data key configuration** 对话框的 **Advanced** 选项卡中。
此 schema 序列化的 Settings 对象用于存储部件中定义的数据源各 data key 的特定设置。
这些设置可从部件 JavaScript 代码访问。

![image](/images/user-guide/contribution/widgets/widget-editor-datakey-settings-schema.png)

第三个 **Latest data key settings schema** 选项卡用于指定 Latest data key 的 JSON schema，以通过 react-schema-form [builder](http://networknt.github.io/react-schema-form/) 自动生成 UI 表单。
**Latest data key settings schema** 仅对 **Time series** 部件可用。
生成的 UI 表单显示在 Latest keys 的 **Data key configuration** 对话框的 **Advanced** 选项卡中。
此 schema 序列化的 Settings 对象用于存储部件中定义的数据源各 data key 的特定设置。
这些设置可从部件 JavaScript 代码访问。

![image](/images/user-guide/contribution/widgets/widget-editor-latest-datakey-setting-schema.png)

自 v3.4 起，自动生成的高级部件设置 JSON 表单已由 [Angular components](https://github.com/thingsboard/thingsboard/pull/6545) 替代。
为自定义部件创建新设置 schema 时，别忘了从 **Widget Settings** 选项卡中移除 components。

![image](/images/user-guide/contribution/widgets/widget-editor-widget-settings-selectors.png)

以下是 **settings schema** 的基础示例：

```
   {
      "schema": {
         "type": "object",
         "title": "Settings",
         "properties": {
             "cardType": {
                "title": "Card type",
                "type": "string",
                "default": "Average"
             },
             "cardTitle": {
                "title": "Card title",
                "type": "string",
                "default": "Gateways online"
             }
          },
          "required": ["cardType"]
         },
      "form": [
      {
         "key": "cardType",
         "type": "rc-select",
         "multiple": false,
         "items": [
         {
           "value": "avg",
           "label": "Average"
         },
         {
           "value": "max",
           "label": "Maximum"
         },
         {
           "value": "min",
           "label": "Minimum"
         }]
      },
      "cardTitle"
      ]
   }
```

应用 **settings schema** 后的结果将显示在部件设置的 **Appearance** 选项卡中：

![image](/images/user-guide/contribution/widgets/widget-editor-schema-example.png)


**schema** 属性支持 **Number**、**Boolean**、**String**、**Object** 等类型。
在 **form** 数组中，每个属性可指定为 **input**、**checkbox**、**dropdown**、**functional field**（JS、HTML、CSS）、**image selection**、**color picker** 或 **array of properties**。
字段可按条件显示并分组到逻辑块中。

以下是自定义 **settings schema** 的复杂示例：

```
{
    "schema": {
        "type": "object",
        "properties": {
            "button": {
                "title": "Button settings",
                "type": "object",
                "properties": {
                    "color": {
                        "title": "Primary color",
                        "type": "string",
                        "default": "#545454"
                    },
                    "backgroundColor": {
                        "title": "Background color",
                        "type": "string",
                        "default": null
                    }
                }
            },
            "markerImage": {
                "title": "Custom marker image",
                "type": "string"
            },
            "markerImageSize": {
                "title": "Custom marker image size (px)",
                "type": "number",
                "default": 34
            },
            "useMarkerImageFunction": {
                "title": "Use marker image function",
                "type": "boolean",
                "default": false
            },
            "markerImageFunction": {
                "title": "Marker image function: f(data, images, dsData, dsIndex)",
                "type": "string"
            },
            "markerImages": {
                "title": "Marker images",
                "type": "array",
                "items": {
                    "title": "Marker image",
                    "type": "string"
                }
            }
        },
        "required": []
    },
    "form": [
        [
            {
                "key": "button",
                "items": [
                    {
                        "key": "button.color",
                        "type": "color"
                    },
                    {
                        "key": "button.backgroundColor",
                        "type": "color"
                    }
			    ]
        	}
        ],
        [
            "useMarkerImageFunction",
            {
                "key": "markerImage",
                "type": "image",
                "condition": "model.useMarkerImageFunction !== true"
            },
            {
                "key": "markerImageSize",
                "condition": "model.useMarkerImageFunction !== true"
            },
            {
                "key": "markerImageFunction",
                "type": "javascript",
                "helpId": "widget/lib/map/marker_image_fn",
                "condition": "model.useMarkerImageFunction === true"
            },
            {
                "key": "markerImages",
                "items": [
                    {
                        "key": "markerImages[]",
                        "type": "image"
                    }
                ],
                "condition": "model.useMarkerImageFunction === true"
            }
        ]
    ],
    "groupInfoes": [
        {
            "formIndex": 0,
            "GroupTitle": "Button Style Settings"
        },
        {
            "formIndex": 1,
            "GroupTitle": "Marker Settings"
        }
    ]
}
```

将自定义 **settings schema** 应用到部件后的效果：

![image](/images/user-guide/contribution/widgets/widget-editor-appearence-example.png)


#### Widget preview section（部件预览区域）

本区域用于预览和测试部件定义。
以包含一个从当前部件定义实例化的部件的迷你 dashboard 形式呈现。
具备典型 ThingsBoard dashboard 的大部分功能，但有若干限制。
例如，调试时在部件数据源区域仅能选择「Function」作为 datasource 类型。    

![image](/images/user-guide/contribution/widgets/widget-editor-preview.png)

{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
## 故障排除

### 空 Web 报告
使用报告时，可能遇到以下问题：
在 Web 报告开始生成前，重型部件可能尚未加载完成，导致报告为空（因生成时 dashboard 上尚无数据）：
![image](/images/user-guide/contribution/widgets/web-report-error.png)

为解决此问题，报告服务提供一项特殊功能，用于通知部件已加载。

首先需通知报告服务有待加载的部件，可通过部件 ```self.onInit``` 实现：
```javascript
self.onInit = function () {
   ...
   if (self.ctx.reportService.reportView) {
     self.ctx.$scope.widgetUuid = self.ctx.reportService.onWaitForWidget();
   }
};
```

报告服务将等待部件发送加载状态信息，或直到等待超时。
在 ```self.onDataUpdated``` 中通知报告服务部件已成功加载：
```javascript
self.onDataUpdated = function () {
    ...data is ready
    if (self.ctx.reportService.reportView) {
        self.ctx.reportService.onWidgetLoaded(self.ctx.$scope.widgetUuid);
    }
};
```

仅当 dashboard 上所有标记为 ```onWaitForWidget()``` 的部件均已发送 ```onWidgetLoaded(${widgetUuid})```，或部件等待超时后，报告服务才会开始生成报告。
{% endif %}


## 部件代码调试技巧

最简单的调试方式为使用 Web 控制台输出。
在部件 JavaScript 代码任意位置放入 [**console.log(...)**](https://developer.mozilla.org/en-US/docs/Web/API/Console/log) 函数。
然后点击 **Run** 按钮重启部件代码，在 Web 控制台查看调试信息。

另一种更有效的调试方式为调用浏览器调试器。
在要关注的部件代码处放入 [**debugger;**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger) 语句，然后点击 **Run** 按钮重启部件代码。
浏览器调试器（若已启用）将在 debugger 语句处自动暂停执行，可使用浏览器调试工具分析脚本执行。


### 下一步

{% assign currentGuide = "Contribution" %}{% include templates/multi-project-guides-banner.md %}