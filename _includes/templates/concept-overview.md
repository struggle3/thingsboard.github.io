{% if concept %}<!-- check for this before going any further; if not present, skip to else at bottom -->

## {{concept}} 概述

{% if what_is %}

### 什么是 {{ concept }}？

{{ what_is }}

{% else %}

{% include templates/_errorthrower.md missing_block='what_is' heading='什么是 (概念)？' purpose='解释此概念及其用途' %}

{% endif %}


{% if when_to_use %}

### 何时使用 {{ concept }}

{{ when_to_use }}

{% else %}

{% include templates/_errorthrower.md missing_block='when_to_use' heading='何时使用 (概念)' purpose='解释何时使用此对象' %}

{% endif %}


{% if when_not_to_use %}

### 何时不使用 {{ concept }}

{{ when_not_to_use }}

{% else %}

{% include templates/_errorthrower.md missing_block='when_not_to_use' heading='何时不使用 (概念)' purpose='解释何时不使用此对象' %}

{% endif %}


{% if status %}

### {{ concept }} 状态

{{ status }}

{% else %}

{% include templates/_errorthrower.md missing_block='status' heading='(概念) 状态获取' purpose='解释如何获取此对象的状态描述' %}

{% endif %}


{% if usage %}

#### 用法

{{ usage }}

{% else %}

{% include templates/_errorthrower.md missing_block='usage' heading='用法' purpose='以代码示例、命令等形式展示最基本、最常用的使用场景，可使用选项卡展示多种方式' %}

{% endif %}

<!-- continuing the "if concept" if/then: -->

{% else %}

### 错误：您必须定义「concept」变量
{: style="color:red" }

此模板需要一个名为 `concept` 的变量，即您要概述的概念名称。该名称将显示在文档标题中。

要消除此消息并正确使用此模板，请定义 `concept`：

```liquid
{% raw %}{% assign concept="Replication Controller" %}{% endraw %}
```

完成此操作后，我们将指导您完成文档其余部分的准备。

{% endif %}
