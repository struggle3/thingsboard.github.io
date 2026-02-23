
* TOC
{:toc}

## 概述

实体表（Entity Table）部件显示与所选别名和筛选器匹配的实体列表及其最新值，支持附加全文搜索和分页选项。
可通过[部件样式](/docs/{{docsPrefix}}user-guide/ui/entity-table-widget/#settings)、[数据源键](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/)和
[部件操作](/docs/{{docsPrefix}}user-guide/ui/widget-actions/)进行高度自定义。

## 配置实体表部件

要开始使用实体表部件，需先创建仪表板并向其添加部件。

### 创建仪表板

首先[创建仪表板](/docs/{{docsPrefix}}user-guide/dashboards/#adding-a-dashboard)以可视化我们的遥测数据。
可使用现有仪表板或为新用例创建新仪表板。本示例中，我们为教程创建了名为“Entity Table”的新仪表板。

### 向仪表板添加部件

下一步是可视化遥测数据。要向仪表板添加实体表部件，请执行：

{% include images-gallery.html imageCollection="add-widget" showListImageTitles="true" %}

学习如何向部件[添加别名](/docs/{{docsPrefix}}user-guide/ui/aliases/)。

## 设置

要开始自定义部件，应在仪表板编辑模式下点击部件右上角的铅笔图标进入部件编辑模式。

{% include images-gallery.html imageCollection="entity-edit" %}

### 1. 标题样式

可更改部件标题 tooltip 和标题样式。标题本身需通过[高级标题设置](/docs/{{docsPrefix}}user-guide/ui/entity-table-widget/#1-entities-table-title)修改。
还可为标题添加图标并调整其颜色、不透明度和大小。下方为配置及对应效果。

{% include images-gallery.html imageCollection="entity-title" showListImageTitles="true" %}

复选框负责显示/隐藏部件标题、部件阴影及启用/禁用全屏模式。

### 2. 部件样式

可使用 CSS 属性为部件自定义样式。
该样式将应用于部件的主 div 元素。
还可更改背景色、文字颜色、内边距和外边距。下方为配置及对应效果。

请注意，样式和背景色仅为示例，并非我们的指导规范。

```json
{
  "border": "3px solid #2E86C1",
  "cursor": "pointer"
}
```
{: .copy-code}

{% include images-gallery.html imageCollection="entity-style" showListImageTitles="true" %}

### 3. 特殊符号和浮点数位数

可为部件实体值添加将显示在旁的特殊符号。还可自定义值浮点数后显示的位数。
下方为配置及对应效果。

{% include images-gallery.html imageCollection="entity-digits" showListImageTitles="true" %}

### 4. 图例设置

图例设置仅在默认启用此选项的时序部件中有意义。此处了解更多[图例设置](/docs/{{docsPrefix}}user-guide/dashboards/#3-legend-settings)。

## 高级设置

实体表部件的高级设置允许[调整部件标题](#1-entities-table-title)、[更改部件上对象的可见性](#2-checkbox-settings)、
[自定义列](#3-the-columns-settings)、[设置分页](#4-the-pagination)、
[表格数据排序](#5-sorting-data-in-the-table-widget)以及[更改部件行样式](#6-row-style-function)。

要进入高级模式并开始调整上述设置，请执行：

{% include images-gallery.html imageCollection="enter-advanced-mode" showListImageTitles="true" %}


### 1. 实体表标题

ThingsBoard 对名称无符号或字符数量限制。但若标题过长，在实体表部件中将无法完整显示，会以省略号截断。不过，应用更改并全屏打开部件后，将能看到完整标题。例如，为标题使用简单内容如“The New Widget Title”：


{% include images-gallery.html imageCollection="entities-table-title" showListImageTitles="true" %}

### 2. 复选框设置

{% include images-gallery.html imageCollection="checkboxes" %}

- 启用实体搜索

勾选此复选框后，部件右上角的放大镜可用于搜索部件实体。

{% include images-gallery.html imageCollection="entities-search" %}

- 启用选择要显示的列

勾选此复选框后，部件右上角的黑条可用于选择隐藏和显示哪些列。

{% include images-gallery.html imageCollection="columns-to-display" %}

- 始终显示表头

勾选此复选框后，滚动实体列表时部件表头始终可见。若不勾选，表头将停留在顶部。

{% include images-gallery.html imageCollection="display-header" %}

- 始终显示操作列

勾选此复选框后，滚动部件遥测数据时行操作单元格始终可见。若不勾选，行操作单元格将停留在行末。

{% include images-gallery.html imageCollection="actions-column" %}

- 显示实体名称列

勾选此复选框后，实体名称列可见。若不勾选，将隐藏。

{% include images-gallery.html imageCollection="entity-name-column" %}

### 3. 列设置

#### 3.1. 实体列标题

要更改列标题，请执行：

{% include images-gallery.html imageCollection="entity-column-title" showListImageTitles="true" %}

#### 3.2. 显示实体标签列

勾选“显示实体标签列”复选框后，可添加标签列并命名。
点击右上角的橙色勾选标记后，将出现带自定义名称的标签列。

{% include images-gallery.html imageCollection="entity-label-column" %}

#### 3.3. 显示实体类型列

“显示实体类型列”复选框负责在部件上显示实体类型（如“device”）。默认显示实体类型列，取消勾选可隐藏。

### 4. 分页

默认情况下，部件显示每页可见条数及总页数。显示该信息为可选。
通过勾选/取消“显示分页”复选框可更改。禁用该复选框后，将不显示每页条数和页数信息。
要应用更改，请点击右上角的橙色勾选标记。

{% include images-gallery.html imageCollection="paggination-off" %}

**请注意：**要理解以下设置，需启用“显示分页”复选框以查看每页条数。

默认**每页大小**为 10 条。若要更改该数值，请执行：

{% include images-gallery.html imageCollection="page-size" %}

### 5. 表格部件中的数据排序

默认情况下，表格部件中的数据按升序排序。
若列中的值非数值（如名称和类型），则按字母顺序规则排序。

{% include images-gallery.html imageCollection="sortingorder-name" %}

若要按遥测数据键类型（temperature、humidity 等）排序，可在默认排序顺序行中输入值的名称。
示例中使用 temperature。
若需改为降序排序，请执行：

{% include images-gallery.html imageCollection="sorting-data" showListImageTitles="true" %}

### 6. 行样式函数

自 3.2.2 版本起，可根据条件更改部件行样式。通过简单示例说明：
假设需要观察哪些设备处于活跃状态、哪些不活跃。为简化任务，应使用行样式函数。

示例及对应效果：

```ruby
result = {background:"white"};
if (entity.active == "false") {
   result.background = '#FF0000';
} else {
   result.background = '#00FF00';
}
return result;
```

{% include images-gallery.html imageCollection="style-function" %}


## 保存更改

要使更改生效并保存，需点击仪表板右下角的橙色勾选标记。

即可确认表格部件的更改已正确应用并保存。

{% include images-gallery.html imageCollection="saving-changes" %}

