对数值数据执行数学运算和函数。参数可从多种来源获取（常量、消息数据、消息元数据、属性或时序数据），结果可保存到消息或直接写入数据库作为属性或时序。

## 配置

### 支持函数

<style>

  div.mathFunctionsTable + table tr th:nth-child(1) {
     width: 10%
  }

  div.mathFunctionsTable + table tr th:nth-child(2) {
     width: 10%
  }

  div.mathFunctionsTable + table tr th:nth-child(3) {
     width: 65%
  }

  div.mathFunctionsTable + table tr th:nth-child(4) {
     width: 15%
  }

</style>

<div class="mathFunctionsTable"></div>

| Function  | Number of arguments | Description                                                                                                                                                                                                           | Reference                                                                                                                |
|-----------|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| ADD       | 2                   | x + y                                                                                                                                                                                                                 |                                                                                                                          |
| SUB       | 2                   | x - y                                                                                                                                                                                                                 |                                                                                                                          |
| MULT      | 2                   | x * y                                                                                                                                                                                                                 |                                                                                                                          |
| DIV       | 2                   | x / y                                                                                                                                                                                                                 |                                                                                                                          |
| SIN       | 1                   | Returns the trigonometric sine of an angle.                                                                                                                                                                           | [Math.sin](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#sin(double))                 |
| SINH      | 1                   | Returns the hyperbolic sine of a double value. The hyperbolic sine of x is defined to be (*e*<sup>x</sup> - *e*<sup>-x</sup>)/2 where *e* is Euler's number.                                                          | [Math.sinh](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#sinh(double))               |
| COS       | 1                   | Returns the trigonometric cosine of an angle.                                                                                                                                                                         | [Math.cos](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#cos(double))                 |
| COSH      | 1                   | Returns the hyperbolic cosine of a double value. The hyperbolic cosine of x is defined to be (*e*<sup>x</sup> + *e*<sup>-x</sup>)/2 where *e* is Euler's number.                                                      | [Math.cosh](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#cosh(double))               |
| TAN       | 1                   | Returns the trigonometric tangent of an angle.                                                                                                                                                                        | [Math.tan](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#tan(double))                 |
| TANH      | 1                   | Returns the hyperbolic tangent of a double value.                                                                                                                                                                     | [Math.tanh](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#tanh(double))               |
| ACOS      | 1                   | Returns the arc cosine of a value; the returned angle is in the range *0.0* through *pi*.                                                                                                                             | [Math.acos](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#acos(double))               |
| ASIN      | 1                   | Returns the arc sine of a value; the returned angle is in the range *-pi/2* through *pi/2*.                                                                                                                           | [Math.asin](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#asin(double))               |
| ATAN      | 1                   | Returns the arc tangent of a value; the returned angle is in the range -pi/2 through pi/2.                                                                                                                            | [Math.atan](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#atan(double))               |
| ATAN2     | 2                   | Returns the angle theta from the conversion of rectangular coordinates (x, y) to polar coordinates (r, theta). First argument is Y (ordinate coordinate), second argument is X (abscissa coordinate).                 | [Math.atan2](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#atan2(double,double))      |
| EXP       | 1                   | Returns the value *e*<sup>x</sup>, where *e* is the base of the natural logarithms.                                                                                                                                   | [Math.exp](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#exp(double))                 |
| EXPM1     | 1                   | Returns *e*<sup>x</sup>-1. Note that for values of x near 0, the exact sum of expm1(x) + 1 is much closer to the true result of *e*<sup>x</sup> than exp(x).                                                          | [Math.expm1](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#expm1(double))             |
| SQRT      | 1                   | Returns the correctly rounded positive square root of a double value.                                                                                                                                                 | [Math.sqrt](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#sqrt(double))               |
| CBRT      | 1                   | Returns the cube root of a double value.                                                                                                                                                                              | [Math.cbrt](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#cbrt(double))               | 
| GET_EXP   | 1                   | Returns the unbiased exponent used in the representation of a double.                                                                                                                                                 | [Math.getExponent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#getExponent(double)) |
| HYPOT     | 2                   | Returns √(x² + y²) without intermediate overflow or underflow.                                                                                                                                                        | [Math.hypot](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#hypot(double,double))      |
| LOG       | 1                   | Returns the natural logarithm (base e) of a double value.                                                                                                                                                             | [Math.log](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#log(double))                 |
| LOG10     | 1                   | Returns the base 10 logarithm of a double value.                                                                                                                                                                      | [Math.log10](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#log10(double))             |
| LOG1P     | 1                   | Returns the natural logarithm of the sum of the argument and 1. Note that for small values x, the result of log1p(x) is much closer to the true result of ln(1 + x) than the floating-point evaluation of log(1.0+x). | [Math.log1p](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#log1p(double))             |
| CEIL      | 1                   | Returns the smallest (closest to negative infinity) double value that is greater than or equal to the argument and is equal to a mathematical integer.                                                                | [Math.ceil](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#ceil(double))               |
| FLOOR     | 1                   | Returns the largest (closest to positive infinity) double value that is less than or equal to the argument and is equal to a mathematical integer.                                                                    | [Math.floor](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#floor(double))             |
| FLOOR_DIV | 2                   | Returns the largest (closest to positive infinity) long value that is less than or equal to the algebraic quotient.                                                                                                   | [Math.floorDiv](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#floorDiv(long,long))    |
| FLOOR_MOD | 2                   | Returns the floor modulus of the long arguments.                                                                                                                                                                      | [Math.floorMod](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#floorMod(long,long))    |
| ABS       | 1                   | Returns the absolute value of a double value.                                                                                                                                                                         | [Math.abs](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#abs(double))                 |
| MIN       | 2                   | Returns the smaller of two double values.                                                                                                                                                                             | [Math.min](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#min(double,double))          |
| MAX       | 2                   | Returns the greater of two double values.                                                                                                                                                                             | [Math.max](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#max(double,double))          |
| POW       | 2                   | Returns the value of the first argument raised to the power of the second argument.                                                                                                                                   | [Math.pow](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#pow(double,double))          |
| SIGNUM    | 1                   | Returns the signum function of the argument; zero if the argument is zero, 1.0 if the argument is greater than zero, -1.0 if the argument is less than zero.                                                          | [Math.signum](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#signum(double))           |
| RAD       | 1                   | Converts an angle measured in degrees to an approximately equivalent angle measured in radians.                                                                                                                       | [Math.toRadians](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#toRadians(double))     |
| DEG       | 1                   | Converts an angle measured in radians to an approximately equivalent angle measured in degrees.                                                                                                                       | [Math.toDegrees](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html#toDegrees(double))     |
| CUSTOM    | 0-16                | Use this function to specify complex math expressions. For example, transform Fahrenheit to Celsius using (x - 32) / 1.8)                                                                                             | [exp4j](https://www.objecthunter.net/exp4j)                                                                              |

### 使用 CUSTOM 函数

选择 CUSTOM 操作时，可编写自定义数学表达式替代预定义运算，从而在单个节点中执行多步复杂计算。

**要点：**

- 最多可使用 16 个具预定义名称的参数（在配置表单中显示）
- 在表达式中直接使用这些预定义参数名
- 表达式通过 [exp4j 库](https://www.objecthunter.net/exp4j/) 求值，详细语法请参考其文档
- 支持标准数学运算符：`+`、`-`、`*`、`/`、`^`（幂）及括号
- 支持标准函数（`sin()`、`cos()`、`sqrt()`、`abs()` 等）及自定义函数：`ln(x)`（自然对数）、`lg(x)`（以 10 为底对数）、`logab(a, b)`（以 a 为底的 b 的对数）
- 可用内置常量：`π` 或 `pi`（3.14159265358979323846）、`e`（2.7182818284590452354）、`φ`（1.61803398874）

**表达式示例：**

| 使用场景              | 表达式             | 说明                                     |
|-----------------------|-------------------|-------------------------------------------------|
| 华氏转摄氏            | `(x - 32) / 1.8`  | 将温度从 °F 转换为 °C               |
| 勾股定理              | `sqrt(x^2 + y^2)` | 使用平方根计算斜边 |
| 圆面积                | `pi * r^2`        | 使用内置 π 常量计算面积    |

### 参数

数学运算的参数可从以下来源获取：

- **Constant** - 在配置中直接指定的固定数值
- **Message** - 从 JSON 消息负载的字段读取
- **Metadata** - 从消息元数据读取
- **Attribute** - 从数据库获取消息发起者的属性值
- **Time series** - 从数据库获取消息发起者的最新时序值

每个参数可指定默认值，当来源值缺失时使用。

{% capture template_support_note %}
**注意**：指定用于获取或提取值的 key 时，可使用[模板化](/docs/{{docsPrefix}}user-guide/templatization/)（如 `${metadataKey}` 或
`$[dataKey]`）根据消息内容动态构造 key 名。
{% endcapture %}
{% include templates/info-banner.md content=template_support_note %}

{% capture numeric_values_note %}
**注意**：所有参数值必须为数值或可解析为数字的字符串。若值为数组、对象或非数字字符串，节点将失败，除非指定了默认值。
{% endcapture %}
{% include templates/info-banner.md content=numeric_values_note %}

### 结果

计算结果可保存到一个或多个目标：

- **Message** - 保存到消息数据的指定 key
- **Metadata** - 保存到元数据的指定 key
- **Attribute** - 作为发起者属性保存（可配置 scope：Server 或 Shared）
- **Time series** - 作为带当前时间戳的时序数据点保存

保存到属性或时序时，也可选择将结果同时加入消息数据和/或元数据，供后续规则节点使用。

可指定结果的小数位数。值将按四舍五入到指定精度（向最近邻居舍入，若两侧等距则向上舍入）。

{% capture synchronization_note %}
**注意**：对给定发起者的处理在服务器节点范围内顺序执行，避免读写数据库时的竞态条件。
{% endcapture %}
{% include templates/info-banner.md content=synchronization_note %}

{% capture performance_note %}
**性能提示**：此节点针对数学计算优化，比脚本节点性能更好，无需脚本编译与执行开销。数值运算请尽量使用此节点。
{% endcapture %}
{% include templates/info-banner.md content=performance_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMathNodeConfiguration",
  "type": "object",
  "properties": {
    "operation": {
      "type": "string",
      "enum": [
        "ADD",
        "SUB",
        "MULT",
        "DIV",
        "SIN",
        "SINH",
        "COS",
        "COSH",
        "TAN",
        "TANH",
        "ACOS",
        "ASIN",
        "ATAN",
        "ATAN2",
        "EXP",
        "EXPM1",
        "SQRT",
        "CBRT",
        "GET_EXP",
        "HYPOT",
        "LOG",
        "LOG10",
        "LOG1P",
        "CEIL",
        "FLOOR",
        "FLOOR_DIV",
        "FLOOR_MOD",
        "ABS",
        "MIN",
        "MAX",
        "POW",
        "SIGNUM",
        "RAD",
        "DEG",
        "CUSTOM"
      ],
      "description": "The mathematical operation to perform."
    },
    "customFunction": {
      "type": "string",
      "description": "Custom mathematical expression (required when operation is CUSTOM)."
    },
    "arguments": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Predefined variable name for the argument (displayed in configuration form)."
          },
          "type": {
            "type": "string",
            "enum": [
              "CONSTANT",
              "MESSAGE_BODY",
              "MESSAGE_METADATA",
              "ATTRIBUTE",
              "TIME_SERIES"
            ],
            "description": "Source type for the argument value."
          },
          "key": {
            "type": "string",
            "description": "Key name to retrieve the value from (supports template patterns)."
          },
          "attributeScope": {
            "type": "string",
            "description": "Attribute scope (required only for ATTRIBUTE type)."
          },
          "defaultValue": {
            "type": "number",
            "description": "Default value if the source is missing or invalid."
          }
        },
        "required": [
          "name",
          "type",
          "key"
        ]
      },
      "description": "List of input arguments for the mathematical operation."
    },
    "result": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "enum": [
            "MESSAGE_BODY",
            "MESSAGE_METADATA",
            "ATTRIBUTE",
            "TIME_SERIES"
          ],
          "description": "Destination type for the calculation result."
        },
        "key": {
          "type": "string",
          "description": "Key name for storing the result (supports template patterns)."
        },
        "attributeScope": {
          "type": "string",
          "description": "Attribute scope (required only for ATTRIBUTE type)."
        },
        "resultValuePrecision": {
          "type": "integer",
          "description": "Number of decimal places for rounding (0 for integer)."
        },
        "addToBody": {
          "type": "boolean",
          "description": "Also add the result to message data (for ATTRIBUTE/TIME_SERIES types)."
        },
        "addToMetadata": {
          "type": "boolean",
          "description": "Also add the result to message metadata (for ATTRIBUTE/TIME_SERIES types)."
        }
      },
      "required": [
        "type",
        "key"
      ]
    }
  },
  "required": [
    "operation",
    "arguments",
    "result"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 对每个参数，节点从配置的来源（常量、消息数据、元数据、属性或时序）获取值。若无法获取且未指定默认值，处理失败。
2. 所有参数值转换为数值（double）格式。转换失败则处理失败。
3. 节点根据所选运算，使用获取的参数值执行数学计算。
4. 结果按配置精度格式化（四舍五入到指定小数位）。
5. 结果保存到配置的目标：消息、元数据、属性和/或时序。
6. 处理成功完成后，消息经 `Success` 连接转发。

## 输出连接

- `Success`
    - 数学运算成功完成且结果已保存。
- `Failure`
    - 处理过程中出错，例如：
        - 缺失必需参数且无默认值
        - 参数值无法转换为数字
        - 除零
        - 无效数学运算（如实数范围内负数的平方根）
        - 其他意外错误

## Examples

### Example 1 — Accumulating water consumption

A water meter device reports incremental consumption. You need to update the total consumption stored as an attribute.

**Incoming message**

Data:

```json
{
  "deltaConsumption": 15.7
}
```

**State of the system**

Originator has a server attribute: `totalConsumption` = `12543.8`

**Node configuration**

```json
{
  "operation": "ADD",
  "arguments": [
    {
      "name": "x",
      "type": "ATTRIBUTE",
      "key": "totalConsumption",
      "attributeScope": "SERVER_SCOPE",
      "defaultValue": 0
    },
    {
      "name": "y",
      "type": "MESSAGE_BODY",
      "key": "deltaConsumption"
    }
  ],
  "result": {
    "type": "ATTRIBUTE",
    "key": "totalConsumption",
    "attributeScope": "SERVER_SCOPE",
    "resultValuePrecision": 2,
    "addToBody": true,
    "addToMetadata": false
  }
}
```

**Outgoing message**

Data:

```json
{
  "deltaConsumption": 15.7,
  "totalConsumption": 12559.5
}
```

Routed via the `Success` connection.

**Result**

The originator attribute `totalConsumption` is updated from 12543.8 to 12559.5 (12543.8 + 15.7). The new total is also added to the message data for use in subsequent rule nodes.

---

### Example 2 — Complex signal processing calculation

Calculate a signal quality indicator using a custom formula that combines distance, signal strength, and environmental factors. The formula uses trigonometric
functions, logarithms, and built-in constants.

Formula: `quality = 100 * e^(-distance / 1000) * (1 + 0.5 * sin(2 * pi * frequency/1000)) * sqrt(abs(signalStrength))`

**Incoming message**

Originator: `DEVICE`

Data:

```json
{
  "distance": 250,
  "frequency": 2400,
  "signalStrength": -45
}
```

**Node configuration**

```json
{
  "operation": "CUSTOM",
  "customFunction": "100 * e^(-x / 1000) * (1 + 0.5 * sin(2 * pi * y / 1000)) * sqrt(abs(z))",
  "arguments": [
    {
      "name": "x",
      "type": "MESSAGE_BODY",
      "key": "distance"
    },
    {
      "name": "y",
      "type": "MESSAGE_BODY",
      "key": "frequency"
    },
    {
      "name": "z",
      "type": "MESSAGE_BODY",
      "key": "signalStrength"
    }
  ],
  "result": {
    "type": "MESSAGE_BODY",
    "key": "signalQuality",
    "resultValuePrecision": 2,
    "addToBody": true,
    "addToMetadata": false
  }
}
```

**Outgoing message**

Data:

```json
{
  "distance": 250,
  "frequency": 2400,
  "signalStrength": -45,
  "signalQuality": 675.98
}
```

Routed via the `Success` connection.

**Result**

The signal quality indicator is calculated using exponential decay for distance, sinusoidal modulation for frequency effects, and square root transformation of signal strength. The
formula demonstrates the use of:

- The built-in constant `e` (Euler's number) for exponential calculations
- The built-in constant `pi` for trigonometric calculations
- Functions: `sin()`, `sqrt()`, `abs()`
- Complex expression with multiple operations

The result (675.98) is saved to the message data for further processing.
