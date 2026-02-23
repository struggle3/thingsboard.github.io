{% if overview %}

{{ overview }}

{% else %}

{% include templates/_errorthrower.md missing_block='overview' heading='概述' purpose='用一两句话说明本文档的目的' %}

{% endif %}


* TOC
{: toc}


{% if objectives %}

### 目标

{{ objectives }}

{% else %}

{% include templates/_errorthrower.md missing_block='objectives' heading='目标' purpose='列出本教程的目标' %}

{% endif %}


{% if prerequisites %}

### 开始前准备

{{ prerequisites }}

{% else %}

{% include templates/_errorthrower.md missing_block='prerequisites' heading='开始前准备' purpose='列出操作前置条件和知识前置条件' %}

{% endif %}


{% if lessoncontent %}

{{ lessoncontent }}

{% else %}

{% include templates/_errorthrower.md missing_block='lessoncontent' heading='课程内容' purpose='提供本教程的课程内容' %}

{% endif %}


{% if cleanup %}

### 清理

{{ cleanup }}

{% endif %}


{% if whatsnext %}

### 下一步

{{ whatsnext }}

{% endif %}
