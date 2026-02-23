使用基于 [Arguments](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments) 中配置变量的 [TBEL](/docs/{{docsPrefix}}user-guide/tbel/){:target="_blank"} 函数定义计算逻辑。

Script 计算字段必须实现：

```js
function calculate(ctx, arg1, arg2, ...): object | object[]
```
函数可返回单个 JSON 对象（多个输出 key）或 JSON 对象数组（多条 time series 记录）。

> 输出变量名在返回对象内直接定义。

示例：露点计算

```js
// Constants for Magnus formula
var a = 17.625;
var b = 243.04;

var alpha = ((a * temperature) / (b + temperature)) + Math.log(humidity / 100.0);
var dewPoint = toFixed((b * alpha) / (a - alpha), 1);

return {"dewPoint": dewPoint};
```
{: .copy-code}

函数使用 <span class="code-light">temperature</span> 与 <span class="code-light">humidity</span> 参数计算露点值。
结果将存储在变量 <span class="code-light">dewPoint</span> 中，保留一位小数。

<b><font size="4">直接访问参数</font></b>   
Arguments 也作为函数参数（`arg1`、`arg2`...）传入，可直接使用（如 temperature、humidity）以简化脚本。

> 可按清晰度与个人习惯选择直接参数或 `ctx.args.<arg>`。

<br><b><font size="4">上下文对象 (ctx)</font></b>

`ctx` 对象提供元数据及对 argument 值的访问：
- `ctx.latestTs` — the most recent timestamp (milliseconds) from telemetry-based arguments. Useful for storing results with the same timestamp as incoming data.
- `ctx.args` — an object containing all configured arguments, accessible via dot (`.`) notation:
    - **Single-value arguments** <i>(attributes or latest telemetry)</i>
        - `ctx.args.<arg>.ts` — timestamp of the argument.
        - `ctx.args.<arg>.value` — value of the argument.
    - **Rolling time series arguments**
        - `ctx.args.<arg>.timeWindow` — object with start and end timestamps `{ startTs, endTs }`.
        - `ctx.args.<arg>.values` — array of `{ ts, value }` records representing timestamped telemetry.
        - `ctx.args.<arg>.<method>()` — built-in methods such as `mean()`, `sum()`, `min()`, `max()`, `first()`, `last()`, `merge()`, and others.

{% assign scriptFunction = '
===
image: /images/user-guide/calculated-fields/script/script-function-1-ce.png
title: Define a function that will perform calculations using the variables defined in the "Arguments" section. The variable name that will store the calculation result is defined within the function itself.
'
%}

{% include images-gallery.liquid imageCollection=scriptFunction %}
