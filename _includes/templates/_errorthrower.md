### 错误：您必须定义 <span style="font-family: monospace">`{{ include.missing_block }}`</span> 块
{: style="color:red" }

此模板要求您提供文本，该文本应{{ include.purpose }}，并显示在标题 **{{ include.heading }}** 下方。

要消除此消息并正确使用此模板，请定义 `{{ include.missing_block }}`
变量并填入内容。

```liquid
{% raw %}{%{% endraw %} capture {{ include.missing_block }} {% raw %}%}{% endraw %}
应{{ include.purpose }}的文本。
{% raw %}{%{% endraw %} endcapture {% raw %}%}{% endraw %}
```

<!-- TEMPLATE_ERROR -->