---
layout: docwithnav
title: 时间序列数据聚合计算字段
description: 对时间序列数据进行聚合计算，支持sum、avg、min、max等聚合函数。
breadcrumbs: "true"
breadcrumbs-steps: "1"
hidetoc: "true"

expression-simple-calculated-fields-1:
  0:
    image: /images/user-guide/calculated-fields/expression-simple-calculated-fields-1-ce.png
    title: 'In the "Expression" section, enter the mathematical expression for the calculation using the variables defined in the "Arguments" section.'
    
output-simple-1:
  0:
    image: /images/user-guide/calculated-fields/output-simple-1-ce.png
    title: 'Select the output type as "Time series". Set a name to the variable that will store the calculation result. Optionally, specify the number of decimal places.'
  1:
    image: /images/user-guide/calculated-fields/output-simple-2-ce.png
    title: 'Select the output type as "Attribute" and choose its scope: "Server attributes", "Client attributes", or "Shared attributes". Set a name to the variable that will store the calculation result. Optionally, set the number of decimal places.'

---

{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/calculated-fields/time-series-data-aggregation-calculated-field.md %}
