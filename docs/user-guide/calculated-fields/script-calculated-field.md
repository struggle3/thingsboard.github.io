---
layout: docwithnav
title: 脚本计算字段
description: 针对复杂计算使用TBEL。支持条件语句、循环及历史数据访问等高级操作。
breadcrumbs: "true"
breadcrumbs-steps: "1"
hidetoc: "true"

expression-script-calculated-fields-1:
  0:
    image: /images/user-guide/calculated-fields/expression-script-function-1-ce.png
    title: '定义使用「参数」部分变量的计算函数。存储计算结果的变量名在函数内部定义。'
    
output-script-1:
  0:
    image: /images/user-guide/calculated-fields/output-script-1-ce.png
    title: '时间序列：函数必须返回包含计算值的JSON对象或数组，可带或不带时间戳。'
  1:
    image: /images/user-guide/calculated-fields/output-script-2-ce.png
    title: '属性：函数必须返回包含计算值且不含时间戳信息的JSON对象。'

---

{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/calculated-fields/script-calculated-field.md %}