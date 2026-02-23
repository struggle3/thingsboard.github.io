使用存储为实体属性的**静态**或**半静态数据**。

**示例：**model、maxTemperature、safeZone、buildingId

**配置：**
- **参数类型**：Attribute
- 选择作用域：**Server**、**Client** 或 **Shared**。
- 指定**属性键**。
- 设置**参数名称**，即脚本逻辑中使用的变量名。
- 可选设置属性的**默认值**。

{% assign attributeArgumentTypeCE = '
    ===
        image: /images/user-guide/calculated-fields/argument-attribute-1-ce.png
        title: 选择 **attribute** 参数类型(3)，选择**属性作用域**(4)，指定**属性键**(5)，设置**参数名称**(6)。可选定义默认值(7)。点击 **Add**(8) 添加参数。
'
%}

{% assign attributeArgumentTypePE = '
    ===
        image: /images/user-guide/calculated-fields/argument-attribute-1-pe.png
        title: 选择 **attribute** 参数类型(3)，选择**属性作用域**(4)，指定**属性键**(5)，设置**参数名称**(6)。可选定义默认值(7)。点击 **Add**(8) 添加参数。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=attributeArgumentTypePE %}
{% else %}  
{% include images-gallery.liquid imageCollection=attributeArgumentTypeCE %}
{% endif %}