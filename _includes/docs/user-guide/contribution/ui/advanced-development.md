* TOC
{:toc}

## ThingsBoard Extensions

[ThingsBoard extensions](https://github.com/thingsboard/thingsboard-extensions){:target="_blank"} 是我们的附加项目，允许你创建自己的 Angular 组件并在部件和操作中使用它们。
我们强烈建议在解决方案的任何复杂逻辑中使用此功能，因为它让你能够复用代码，并充分利用 TypeScript、RXJS、Angular 等的全部功能。
本文介绍如何在 ThingsBoard 3.6 及更高版本中通过 UI 连接你的 extensions。

{% capture difference %}
**重要说明**：即使你使用的 ThingsBoard 版本早于 3.6，仍可使用 **extensions**。此时需要将 extension 文件手动加载到服务器并重启。相关信息请参阅 extensions 项目对应分支中的 **README** 文件。[此分支](https://github.com/thingsboard/thingsboard-extensions/tree/release-3.1)适用于 ThingsBoard 3.1.0 - 3.4.1 版本，[此分支](https://github.com/thingsboard/thingsboard-extensions/tree/release-3.5)适用于 3.5 - 3.5.1 版本。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

首先需要准备包含已编译组件的文件。默认文件名为 **thingsboard-extension-widgets.js**。创建该文件的说明请参阅 [ThingsBoard extensions](https://github.com/thingsboard/thingsboard-extensions){:target="_blank"} 的 **README** 文件。

准备好包含组件的文件后，将其加载到 ThingsBoard：

- 进入「**Resources**」下的「**JavaScript library**」页面；
- 点击「**Add JavaScript resource**」按钮（窗口右上角的「加号」图标）；
- 在弹出窗口中，在「**JavaScript type**」选择器中选择「**Extension**」（或选择「**Module**」以粘贴代码片段）；
- 输入模块标题；
- 拖拽包含已编译组件的文件；
- 点击「Add」。

你的组件已成功添加到 ThingsBoard。

{% include images-gallery.html imageCollection="add-js-module" %}

<br>
下面介绍如何在部件中使用这些组件。我们将创建一个简单的 Latest value 部件，使用 extensions 中的组件（若对创建新部件有疑问，请参阅 [创建新部件定义](#creating-new-widget-definition)）：

- 进入「**Resources**」下的「**Widgets library**」页面；
- 点击窗口右上角的「**plus**」图标，选择「**Create new widget**」；
- 选择部件类型「**Latest value**」；
- 输入部件名称；
- 进入「**Resources**」选项卡，点击「**Add**」按钮；
- 勾选「**Is extension**」；
- 从下拉菜单中选择你的 extension 模块；

模块已与部件连接。现在可以在部件中使用你的 Angular 组件：

- 进入「**HTML**」选项卡，添加自定义组件。示例中为 **tb-example-table**（别忘了添加 **ctx**）；
- 清空 **self.onInit**、**self.onDataUpdated**、**self.onResize** 的默认内容；
- 在 onDataUpdated 函数中添加如下代码：
  ```javascript
  self.ctx.$scope.exampleTableComponent.onDataUpdated();
  ```
  {: .copy-code}
  当部件收到新数据时，会触发自定义组件中的更新函数；
- 添加以下函数：
  ```javascript
  self.typeParameters = function() {
    return {
        maxDatasources: 1, //最大数据源数量为 1
        singleEntity: true, //仅允许一个实体
        previewWidth: '250px', //预览 X 轴默认尺寸 
        previewHeight: '250px', //预览 Y 轴默认尺寸 
        embedTitlePanel: true, //隐藏标题栏
    };
  };
  ```
  {: .copy-code}
  该函数设置部件的行为规则；
- 点击「Run」按钮预览部件效果；
- 点击「Save」保存修改。

现在部件中已使用你的组件。

{% include images-gallery.html imageCollection="select-extensions-module" %}

[ThingsBoard extensions](https://github.com/thingsboard/thingsboard-extensions){:target="_blank"} 允许你在 ThingsBoard 平台范围内创建任意类型的部件。

祝你开发顺利！


## 集成现有代码创建部件定义

以下示例演示如何复用/集成外部 JavaScript 库或现有代码来创建新部件。

### 使用外部 JavaScript 库

#### Latest Values 示例

本示例使用外部 [gauge.js](http://bernii.github.io/gauge.js/) 库创建 **Latest Values** 仪表类部件。

在 **Widgets Bundle** 视图中，点击屏幕右下角的大 “+” 「+」按钮，然后点击 “Create new widget type” 。
在 **Select widget type** 弹窗中点击 **Latest Values**。
**Widget Editor** 将打开，并预填充默认 **Latest Values** 模板部件的内容。

- 打开 **Resources** 选项卡，点击「Add」，插入以下链接：

```
https://bernii.github.io/gauge.js/dist/gauge.min.js
```

- 清空「Resources」区域中 CSS 选项卡的内容。
- 在「Resources」的 HTML 选项卡中放入以下 HTML 代码：

```html
  {% raw  %}<canvas id="my-gauge"></canvas>{% endraw %}
```

- 在「JavaScript」区域中放入以下 JavaScript 代码：

```javascript
var canvasElement;
var gauge;

self.onInit = function() {
    canvasElement = $('#my-gauge', self.ctx.$container)[0];
    gauge = new Gauge(canvasElement);
    gauge.minValue = -1000; 
    gauge.maxValue = 1000; 
    gauge.animationSpeed = 16; 
    self.onResize();
}

self.onResize = function() {
    canvasElement.width = self.ctx.width;
    canvasElement.height = self.ctx.height;
    gauge.update(true);
    gauge.render();
}

self.onDataUpdated = function() {
    if (self.ctx.defaultSubscription.data[0].data.length) {
        var value = self.ctx.defaultSubscription.data[0].data[0][1];
        gauge.set(value);
    }
}
```

- 点击 **Widget Editor Toolbar** 上的 **Run** 按钮，在 **Widget preview** 区域查看结果。

![image](/images/user-guide/contribution/widgets/external-js-widget-sample.png)

本示例使用了外部 JS 库 API，在 **Resources** 区域注入对应 URL 后即可使用。
显示值来自 [subscription](/docs/{{docsPrefix}}user-guide/contribution/ui/basic-widget-api/#subscription-object) **data** 属性中第一个 dataKey 的数据。

#### Time-Series 示例

本示例使用外部 [Chart.js](https://www.chartjs.org/) 库创建 **Time-Series** 折线图部件。

在 **Widgets Bundle** 视图中，点击屏幕右下角的大 “+” 「+」按钮，然后点击 “Create new widget type” 。
在 **Select widget type** 弹窗中点击 **Time-Series**。
**Widget Editor** 将打开，并预填充默认 **Time-Series** 模板部件的内容。

- 打开 **Resources** 选项卡，点击「Add」，插入以下链接：

```  
https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js
```

- 清空「Resources」区域中 CSS 选项卡的内容。
- 在「Resources」的 HTML 选项卡中放入以下 HTML 代码：

```html
  {% raw  %}<canvas id="myChart"></canvas>{% endraw %}
```

- 在「JavaScript」区域中放入以下 JavaScript 代码：

```javascript
var myChart;

self.onInit = function() {

    var chartData = {
        datasets: []
    };

    for (var i=0; i < self.ctx.data.length; i++) {
        var dataKey = self.ctx.data[i].dataKey;
        var dataset = {
            label: dataKey.label,
            data: [],
            borderColor: dataKey.color,
            fill: false
        };
        chartData.datasets.push(dataset);
    }

    var options = {
        maintainAspectRatio: false,
        legend: {
            display: false
        },
        scales: {
        xAxes: [{
            type: 'time',
            ticks: {
                maxRotation: 0,
                autoSkipPadding: 30
            }
        }]
    }
    };

    var canvasElement = $('#myChart', self.ctx.$container)[0];
    var canvasCtx = canvasElement.getContext('2d');
    myChart = new Chart(canvasCtx, {
        type: 'line',
        data: chartData,
        options: options
    });
    self.onResize();
}

self.onResize = function() {
    myChart.resize();
}

self.onDataUpdated = function() {
    for (var i = 0; i < self.ctx.data.length; i++) {
        var datasourceData = self.ctx.data[i];
        var dataSet = datasourceData.data;
        myChart.data.datasets[i].data.length = 0;
        var data = myChart.data.datasets[i].data;
        for (var d = 0; d < dataSet.length; d++) {
            var tsValuePair = dataSet[d];
            var ts = tsValuePair[0];
            var value = tsValuePair[1];
            data.push({t: ts, y: value});
        }
    }
    myChart.options.scales.xAxes[0].ticks.min = self.ctx.timeWindow.minTime;
    myChart.options.scales.xAxes[0].ticks.max = self.ctx.timeWindow.maxTime;
    myChart.update();
}
```

- 点击 **Widget Editor Toolbar** 上的 **Run** 按钮，在 **Widget preview** 区域查看结果。

![image](/images/user-guide/contribution/widgets/external-js-timeseries-widget-sample.png)

本示例使用了外部 JS 库 API，在 **Resources** 区域注入对应 URL 后即可使用。
图表数据集根据 **ctx** 的 **data** 属性中配置的 dataKeys 进行准备。
在 **onDataUpdated** 函数中，数据源数据被转换为 Chart.js 折线图格式并推入图表数据集。
注意：xAxis（时间轴）限制在 **ctx** 的 **timeWindow** 属性得到的当前 timewindow 范围内。

### 使用现有 JavaScript 代码

另一种创建部件的方式是使用已打包的 JavaScript 代码。
此时可以创建自己的 TypeScript 类或 Angular 组件，并将其打包进 ThingsBoard UI 代码。
要使该代码在部件中可访问，需要注册对应的 Angular 模块或将 TypeScript 类注入到全局变量（例如 window 对象）。
部分 ThingsBoard 部件已采用此方式。可参考 [polyfills.ts](https://github.com/thingsboard/thingsboard/blob/13e6b10b7ab830e64d31b99614a9d95a1a25928a/ui-ngx/src/polyfills.ts#L106)
或 [widget-components.module.ts](https://github.com/thingsboard/thingsboard/blob/13e6b10b7ab830e64d31b99614a9d95a1a25928a/ui-ngx/src/app/modules/home/components/widget/widget-components.module.ts#L44)。
其中说明了如何将 bundled 类或组件注册以供 ThingsBoard 部件使用。
例如「Timeseries - Flot」部件（来自「Charts」Widgets Bundle）使用 [**TbFlot**](https://github.com/thingsboard/thingsboard/blob/13e6b10b7ab830e64d31b99614a9d95a1a25928a/ui-ngx/src/app/modules/home/components/widget/lib/flot-widget.ts#L63) TypeScript 类，该类在 **polyfills.ts** 中作为 window 属性注入：

```typescript
...

import { TbFlot } from '@home/components/widget/lib/flot-widget';
...

    (window as any).TbFlot = TbFlot;
...

```

另一个例子是「Timeseries table」部件（来自「Cards」Widgets Bundle），使用 Angular 组件 [**tb-timeseries-table-widget**](https://github.com/thingsboard/thingsboard/blob/13e6b10b7ab830e64d31b99614a9d95a1a25928a/ui-ngx/src/app/modules/home/components/widget/lib/timeseries-table-widget.component.ts#L99)，该组件在 **widget-components.module.ts** 中注册为 **WidgetComponentsModule** 的依赖。
因此该组件可在部件模板 HTML 中使用。

```typescript
...

import { TimeseriesTableWidgetComponent } from '@home/components/widget/lib/timeseries-table-widget.component';

...

@NgModule({
  declarations:
    [
...
      TimeseriesTableWidgetComponent,
...
    ],
...
  exports: [
...
      TimeseriesTableWidgetComponent,
...
  ],
...
})
export class WidgetComponentsModule { }
```
