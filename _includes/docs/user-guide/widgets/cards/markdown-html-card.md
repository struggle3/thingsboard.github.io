{% assign widgetName = "Markdown/HTML Card" %}
{% assign widgetBundle = "Cards" %}
* TOC
{:toc}

适用于 ThingsBoard 仪表板静态或动态内容的多用途部件。它支持渲染 **Markdown** 或 **自由格式 HTML**，且可**带或不带数据源**使用。
可用于注释、上下文提示、KPI、横幅，或与图表、表格、地图并列的紧凑信息卡片。

<br><b><font size="3">Markdown vs HTML</font></b>

- **Markdown** 是一种简单的文本格式语法，其优点是**快速易用**——无需了解 HTML 即可实现清晰排版。
- **HTML** —— 当需要精确控制布局、样式或交互元素（表格、图标、嵌入媒体、复杂网格）时选用。

<hr>

## 主要能力

- **动态或静态内容。** 使用 Markdown 或 HTML 编写，可混合文本、列表、表格、链接、图片、图标。
- **可选数据。** 通过 **entity alias** 和 **data keys** 拉取 telemetry/attributes，注入模板或通过 value function 处理。
- **操作与导航。** 处理 HTML 元素（按 *id*）点击，可跳转到 dashboard 状态、打开对话框/弹出框或触发其他操作。
- **样式。** 在 **Markdown/HTML CSS** 专区添加样式（推荐），或在标记中内联样式。
- **快速集成。** 与其它部件（时序、表格、地图）协同良好，适合注释、上下文说明和紧凑信息卡片。

<hr>

## Add the widget

{% include templates/adding-widget.md %}

<hr>

## Data sources (optional)

{{widgetName}} 可在**无数据源**（纯静态内容）或 **一个或多个 [data sources](/docs/{{docsPrefix}}user-guide/widgets/#data-source-types){:target="_blank"}** 下工作。

在 **Data** 选项卡中：

1. 选择数据源类型：[Entity](/docs/{{docsPrefix}}user-guide/widgets/#entity-as-datasource){:target="_blank"}、[Device](/docs/{{docsPrefix}}user-guide/widgets/#device-as-datasource){:target="_blank"}、[Entities count](/docs/{{docsPrefix}}user-guide/widgets/#entities-count){:target="_blank"}、[Alarms count](/docs/{{docsPrefix}}user-guide/widgets/#alarms-count){:target="_blank"} 或 [Function](/docs/{{docsPrefix}}user-guide/widgets/#function-as-datasource){:target="_blank"}。
2. 配置 [filters](/docs/{{docsPrefix}}user-guide/widgets/#filters){:target="_blank"} 和 **data keys**（[attributes](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} / [latest telemetry](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"}）。  
  添加的键将在部件的 content 逻辑中可用。

<hr>

## Configuration

进入部件的 **Appearance** 选项卡管理其内容和样式。
- [Static Markdown/HTML template:](#static-markdownhtml-template) 适用于带少量动态占位符的静态布局。
- [Dynamic Markdown/HTML content:](#dynamic-markdownhtml-content) 适用于条件/循环/计算、合并多键或基于数据切换布局。
- [Markdown/HTML CSS](#content-styling-css) —— 集中添加 CSS 便于维护；内联样式仍支持快速调整。

<hr>

### Static Markdown/HTML template

使用 `${key}` 等变量创建静态布局，其中 `key` 为 data key 的 **label**。

通过 `${key:n}` 支持 data key 值的基本数值格式，`n` 为**小数位数**。例如：
  - `${key}` —— 原样显示键值（无格式）。
  - `${key:0}` —— 以**无小数位**显示键值。
  - `${key:2}` —— 以**两位小数**显示键值。

**示例：**

Smart Device 向 ThingsBoard 发送温度值。在卡片中显示该温度值。

**Datasource：**
- **Type**：Device
- **Device**：Smart Device
- **Data key**：temperature

使用以下 **Markdown/HTML pattern**：

```markdown
### Temperature value card
- **Current entity**: ${entityName}
- **Current temperature**: ${temperature:1} °C
```
{:.copy-code}

**说明**
- `${entityName}` —— 数据源中实体的**系统名称**。
- `${temperature:1}` —— 温度 telemetry 的值，**小数点后一位**。

**效果：**

![image](/images/user-guide/widgets/cards/markdown-html-card/markdown-html-pattern.png)

[下载此部件](/docs/pe/user-guide/widgets/resources/markdown_html_card_temperature_value_card.json){:target="_blank" download="markdown_html_card_temperature_value_card.json"} 并 [导入](/docs/{{docsPrefix}}user-guide/widgets/#import-widget){:target="_blank"} 到您的 dashboard。

<hr>

### Dynamic Markdown/HTML content

适用于条件、计算、合并多键或切换布局。

**使用方法：**
1. 开启 **Markdown/HTML value function**，通过 JavaScript 生成卡片内容。
2. 实现一个接收 data 和部件上下文 `ctx` 的 JavaScript 函数，返回 Markdown 或 HTML **字符串**。

**示例：**

Smart Device 向 ThingsBoard 发送温度值。在卡片中按颜色规则显示温度：
- 温度低于 20 °C 时，值显示为 <span style="color:blue">蓝色</span>。
- 介于 20 °C 与 25 °C 之间时，值为 <span style="color:green">绿色</span>。
- 高于 25 °C 时，值为 <span style="color:red">红色</span>。

**Datasource：**
- **Type**：Device
- **Device**：Smart Device
- **Data key**：temperature

**使用以下 value function**：

```js
const entity = data[0];
const color = entity.temperature > 25 ? "red" : entity.temperature > 20 ? 'green' : 'blue'
const entityName = `### Temperature value card\n - Current entity: <span >${entity.entityName}</span>\n `
const temp = `- Current temperature: <span style="color:${color};">${entity.temperature.toFixed(1)} °C</span>\n `
return entityName + temp;
```
{:.copy-code}

**说明**

1. 使用第一个 **datasource**：entity 为 `data[0]`。
2. 按温度选择 **color**：
- **> 25 →** <span style="color:red">"red"</span>
- **> 20（且 ≤ 25）→** <span style="color:green">"green"</span>
- **≤ 20 →** <span style="color:blue">"blue"</span>
3. **用 Markdown + HTML 构建字符串：**
- `entityName` —— **实体名称**。
- `temp` —— 温度值字符串，**按所选规则着色**。
- `toFixed(1)` —— 将温度四舍五入至**一位小数**。

**效果：**

![image](/images/user-guide/widgets/cards/markdown-html-card/markdown-html-value-function.png)

[下载此部件](/docs/pe/user-guide/widgets/resources/markdown_html_card_temperature_value_card_2.json){:target="_blank" download="markdown_html_card_temperature_value_card.json"} 并 [导入](/docs/{{docsPrefix}}user-guide/widgets/#import-widget){:target="_blank"} 到您的 dashboard。

<hr>

### Content styling (CSS)

<br><b><font size="3">应用默认 Markdown 样式</font></b>

应用 ThingsBoard 的**内置 Markdown 排版**（标题、段落、列表、表格、代码），与当前 dashboard 主题一致。
- **ON（多数情况推荐）：** 获得与 dashboard 风格匹配的默认样式。
- **OFF：** 最小化浏览器默认 —— 需要完全通过自有 CSS 控制视觉效果时选此。

您仍可在 **Markdown/HTML CSS** 中**覆盖**默认样式。

<br><b><font size="3">Markdown/HTML CSS</font></b>

使用 **Markdown/HTML CSS** 区域为卡片定义样式——调整标题、间距、字体、颜色和图标，使卡片符合设计系统。

这些规则仅作用于本部件容器内，不会影响其它部件。

**示例：**

**1.** 将内容包裹在容器类中，并通过该类作用于所有元素。

```markdown
<div class="office-card">
  <h3>${entityName}</h3>
  <p class="blue-box">
    <strong>Current temperature:</strong>
    <span class="temp-value">${temperature:1}</span> °C
  </p>
  <p class="green-box">
    <strong>Current humidity:</strong>
    <span class="hum-value">${humidity:0}</span> %
  </p>
</div>
```
{:.copy-code}

**2.** 在 **Markdown/HTML CSS** 区域使用选择器编写 CSS。

```css
.office-card {
  box-sizing: border-box;
  padding: 16px;
  margin: 6px 0;
  text-align: center;
  font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, "Noto Sans";
}

.office-card h3 {
  margin: 0 0 12px;
  font-size: 24px;
}

.blue-box {
  background: #2196F31A;
  border: 2px solid #2196F3;
  border-radius: 10px;
  padding: 10px;
  margin: 8px 0;
  font-weight: 700;
}

.green-box {
  background: #4CAF501A;
  border: 2px solid #4CAF50;
  border-radius: 10px;
  padding: 10px;
  margin: 6px 0;
  font-weight: 700;
}

.temp-value,
.hum-value {
  font-weight: 700;
  font-variant-numeric: tabular-nums;
}

```
{:.copy-code.expandable-10}

**说明**
- `.office-card { … }` —— **根作用域**。以 .office-card 为前缀的选择器**仅作用于本卡片内部**。
- `h3` 规则 —— 增大**标题尺寸**并在下方留出间距（margin: 0 0 12px）。
- `p` 规则 —— 添加灰色**背景**、**边框**和**圆角**。
- `.temp-value` —— 仅作用于数值：
  - `color: #2e7d32` 将 telemetry 值高亮为 <span style="color:green">绿色</span>。
  - `font-weight: 600` 使数值更突出。

**效果：**

![image](/images/user-guide/widgets/cards/markdown-html-card/content-styling-css.png)

[下载此部件](/docs/pe/user-guide/widgets/resources/markdown_html_card_with_css.json){:target="_blank" download="markdown_html_card_with_css.json"} 并 [导入](/docs/{{docsPrefix}}user-guide/widgets/#import-widget){:target="_blank"} 到您的 dashboard。

<hr>

## Card styling

在 **Widget card** 选项卡中：

- **Title & Icon** —— 设置与 dashboard 一致的描述性标题/图标。
- **Card styles** —— 配置文字颜色、背景、padding、margin、圆角和阴影。
- **Card buttons** —— 纯信息卡片可关闭 **Enable fullscreen** 和 **Enable data export**。

<hr>

## Actions & navigation

{{widgetName}} 部件支持以下操作：
- [Widget header button](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#widget-header-button){:target="_blank"} —— 在部件标题栏添加操作按钮；点击触发已配置的操作。
- [On HTML element click](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#on-html-element-click){:target="_blank"} —— 点击部件内指定 HTML 元素（按其 **id**）时触发已配置的操作。

<hr>

## 示例：办公信息卡片

创建紧凑的办公信息卡片。

{% if docsPrefix == null %}
![image](/images/user-guide/widgets/cards/markdown-html-card/office-information-card-ce.png)
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix contains "paas/" %}
![image](/images/user-guide/widgets/cards/markdown-html-card/office-information-card.png)
{% endif %}

<br><b><font size="4">Step 1. Prepare the entity</font></b>

创建名为 "**Office A**" 的 [Asset](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"}，并设置以下 attributes：
- **address**: 645 5th Ave, New York 
- **officeManager**: Emma Johnson
- **phone**: +1 121 333 4455 
- **email**: office.a@mail.com

（也可从 [CSV](/docs/pe/user-guide/widgets/resources/office_a_asset.csv){:target="_blank" download="office-a-asset.csv"} [导入](/docs/{{docsPrefix}}user-guide/bulk-provisioning/#import-entities){:target="_blank"} 预填 Asset）。

{% include images-gallery.html imageCollection="example-markdown-html-card-1" %}

<br>

<b><font size="4">Step 2.1 Add the widget</font></b>

- 打开或 [create](/docs/{{docsPrefix}}user-guide/dashboards/#create-new-dashboard){:target="_blank"} dashboard，然后 [添加 **Markdown/HTML Card** 部件](#add-the-widget)。

<b><font size="4">Step 2.2 Configure data ("Data" tab)</font></b>

- **定义实体与 data keys 以拉取数据。**
  - 新建 [Entity alias](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}，filter type 选 [Single entity](/docs/{{docsPrefix}}user-guide/ui/aliases/#single-entity){:target="_blank"}，选择 **Office A** asset，点击 "**Add**"。
  - 在 **Data keys** 区域添加：**address**、**officeManager**、**email**、**phone**。

{% include images-gallery.html imageCollection="example-markdown-html-card-2" %}

<b><font size="4">Step 2.3 Enable dynamic content ("Appearance" tab)</font></b>

- 开启 "**Use markdown/HTML value function**" 选项。
- 粘贴下方提供的 **Markdown/HTML value function**：

```js
if (data.length) {
    const buildingAttributes = ['address', 'officeManager', 'phone', 'email'];

    let information = {
        entityName: data[0].entityName ? data[0].entityName : 'Not found',
        buildingAttributesField: {}
    };

    for (let key of buildingAttributes) {
        information.buildingAttributesField[key] = data[0][key] ? data[0][key] : 'Not found';
    }

    const attributesNotFound = Object.values(information.buildingAttributesField).every(value => value === 'Not found');

    if (attributesNotFound) {
        return '<div class="no-data-card">' +
            `<h1 class="card-title">Information on ${information.entityName}</h1>` +
            '<div class="no-data-block">' +
                '<div class="no-data-content">' +
                    '<div><svg xmlns="http://www.w3.org/2000/svg" width="81" height="80" viewBox="0 0 81 80" fill="none"><path d="M14.8203 46.1166C16.6985 46.0291 18.2877 45.3003 19.588 43.9301C20.8883 42.56 21.5529 40.9274 21.5529 39.0325C21.5529 40.9274 22.1886 42.56 23.4889 43.9301C24.7892 45.3003 26.3784 46.0291 28.2566 46.1166C26.3784 46.204 24.7892 46.9328 23.4889 48.303C22.8602 48.9489 22.3653 49.7146 22.0329 50.5555C21.7005 51.3963 21.5374 52.2955 21.5529 53.2006C21.5529 51.3057 20.9172 49.6732 19.588 48.303C18.2877 46.9328 16.6985 46.204 14.8203 46.1166ZM21.5529 25.1267C25.1937 24.9518 28.2855 23.5234 30.8283 20.8413C33.371 18.1593 34.6424 14.9817 34.6424 11.2793C34.6424 14.9817 35.9138 18.1593 38.4566 20.8413C40.9994 23.5234 44.0912 24.9227 47.7609 25.1267C45.3626 25.2434 43.1665 25.9139 41.1439 27.1966C39.1501 28.4501 37.5608 30.141 36.3761 32.24C35.2203 34.3389 34.6424 36.5837 34.6424 39.0325C34.6424 35.3301 33.371 32.1234 30.8283 29.4413C28.2855 26.7301 25.1937 25.3017 21.5529 25.1267ZM31.1461 56.524C33.8912 56.4074 36.2317 55.3288 38.1387 53.3172C40.0458 51.3057 40.9994 48.9152 40.9994 46.1166C40.9994 48.9152 41.9529 51.3057 43.86 53.3172C45.7671 55.3288 48.0787 56.4074 50.8237 56.524C48.0787 56.6406 45.7671 57.7193 43.86 59.7308C41.9529 61.7423 40.9994 64.1328 40.9994 66.9315C40.9994 64.1328 40.0458 61.7423 38.1387 59.7308C36.316 57.7765 33.8041 56.6245 31.1461 56.524ZM50.8237 42.7057C53.5688 42.5891 55.8804 41.5105 57.7875 39.4989C59.6946 37.4874 60.6192 35.0969 60.6192 32.2691C60.6192 35.0678 61.5728 37.4583 63.4799 39.4698C65.3869 41.4813 67.7274 42.56 70.4725 42.6766C67.7274 42.7932 65.3869 43.8718 63.4799 45.8834C61.5728 47.8949 60.6192 50.2854 60.6192 53.084C60.6192 50.2854 59.6657 47.8949 57.7875 45.8834C55.8804 43.901 53.5688 42.8223 50.8237 42.7057Z" fill="#00695C" fill-opacity="0.4"/></svg></div>' +
                    '<p class="no-data-title">There is no information about the building</p>' +
                '</div>' +
            '</div>' +
        '</div>';
    } else {
        return '<div class="card">' +
            `<h1 class="card-title">Information on ${information.entityName}</h1>` +
            '<div class="attributes">' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>place</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.address}</p>` +
                        '<span class="attribute_label">Address</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>person</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.officeManager}</p>` +
                        '<span class="attribute_label">Contact person</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>call</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.phone}</p>` +
                        '<span class="attribute_label">Phone</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>mail_outline</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.email}</p>` +
                        '<span class="attribute_label">Email</span>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>';
    }
}
```
{:.copy-code.expandable-10}

- 滚动到 **Markdown/HTML CSS** 并粘贴下方提供的 CSS：

```css
.card, .no-data-card {
    padding: 0px;
    height: 100%;
}

.card-title {
    position: sticky;
    top: 0;
    z-index: 2;
    font-size: 16px;
    letter-spacing: 0.25px;
    padding: 16px;
}
.attribute_container {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 16px;
    border-bottom: 1px solid #0000000d;
}

.icon {
    z-index: 1;
}

.icon_wrapper {
    display: flex;
    position: relative;
    align-items: center;
    padding: 8px;
    border: 1px solid var(--tb-primary-100, #305680);
    border-radius: 4px;
}

.icon_wrapper:before {
    content: '';
    z-index: 0;
    position: absolute;
    opacity: 0.1;
    background-color: var(--tb-primary-200, #305680);
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
}

.attribute, .attribute_label {
    font-size: 14px;
    line-height: 20px;
}

.attribute_label {
    color: #00000061;
}

.no-data-card {
    display: flex;
    flex-direction: column;
}

.no-data-block {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 100%;
    max-width: 345px;
    padding: 0 15px;
    margin: 0 auto;
    text-align: center;
}

.no-data-content {
    transform: translateY(-30%);
}

.no-data-block p {
    font-weight: 500;
}

.no-data-title {
    color: rgba(0, 0, 0, 0.54);
}

.no-data-subtitle {
    font-size: 13px;
    color: rgba(0, 0, 0, 0.38);
}
```
{:.copy-code.expandable-10}

{% include images-gallery.html imageCollection="example-markdown-html-card-3" %}

<b><font size="4">Step 2.4 Card settings ("Widget card" tab)</font></b>

- 若卡片仅作信息展示，可关闭 "**Enable fullscreen**" 和 "**Enable data export**"。
- 点击 "**Add**"。

<b><font size="4">Step 2.5 Save</font></b>

- 在 dashboard 布局中**自由调整**卡片大小，然后**保存 dashboard**。

<b><font size="4">预期效果</font></b>

dashboard 上将显示紧凑、清晰的办公联系卡片。缺失的 attributes 显示为 "Not found"。可在 dashboard 布局中自由调整卡片大小。

{% include images-gallery.html imageCollection="example-markdown-html-card-4" %}

<br><b><font size="4">Download the configured widget</font></b>

可下载已配置的 [Office information card](/docs/pe/user-guide/widgets/resources/markdown_html_card_office_information_card.json){:target="_blank" download="markdown_html_card_office_information_card.json"} 并在 dashboards 上复用。

**重要：** 导入后，请在 **entity alias** 中更新 **target entity** 和 **data keys**。
