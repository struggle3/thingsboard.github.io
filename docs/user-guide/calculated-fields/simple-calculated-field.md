---
layout: docwithnav
title: 简单计算字段
description: 简单计算字段使用基本算术运算（+、-、*、/）及标准函数，如sqrt（平方根）、pow（幂）、abs（绝对值）等。
breadcrumbs: "true"
breadcrumbs-steps: "1"
hidetoc: "true"

expression-simple-calculated-fields-1:
  0:
    image: /images/user-guide/calculated-fields/expression-simple-calculated-fields-1-ce.png
    title: '在「表达式」部分，使用「参数」部分定义的变量输入用于计算的数学表达式。'
    
output-simple-1:
  0:
    image: /images/user-guide/calculated-fields/output-simple-1-ce.png
    title: '将输出类型选为「时间序列」。为存储计算结果的变量设置名称。可选指定小数位数。'
  1:
    image: /images/user-guide/calculated-fields/output-simple-2-ce.png
    title: '将输出类型选为「属性」并选择其作用域：「服务器属性」「客户端属性」或「共享属性」。为存储计算结果的变量设置名称。可选指定小数位数。'

---

{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/calculated-fields/simple-calculated-field.md %}