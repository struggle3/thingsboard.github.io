{% if overview %}

{{ overview }}

{% else %}

{% include templates/_errorthrower.md missing_block='overview' heading='概述' purpose='用一两句话说明本文档的目的' %}

{% endif %}


* TOC
{: toc}


{% if prerequisites %}

### 开始前准备

{{ prerequisites }}

{% else %}

{% include templates/_errorthrower.md missing_block='prerequisites' heading='开始前准备' purpose='列出操作前置条件和知识前置条件' %}

{% endif %}


{% if steps %}

{{ steps }}

{% else %}

{% include templates/_errorthrower.md missing_block='steps' heading='步骤' purpose='列出完成任务所需的一系列编号步骤' %}

{% endif %}


{% if discussion %}

{{ discussion }}

{% else %}

{% endif %}


{% if whatsnext %}

### 下一步

{{ whatsnext }}

{% endif %}
