
* TOC
{:toc}

本文介绍 MQTT 主题的工作方式、如何在主题字符串中使用通配符，并提供示例，帮助您在 MQTT 部署中有效使用该特性。

## 主题

在 MQTT 中，主题是通信模型的基础。它们作为寻址机制，使发布者和订阅者能够交换消息。
主题分两类：
* **主题名称(Topic Names)**。发布者用于发送消息。**不得包含**通配符或以 `$` 开头（此类主题保留给 TBMQ 系统用途）。
* **主题过滤器(Topic Filters)**。订阅者用于接收消息，**可包含**通配符字符如 `#` 和 `+`。

请注意，MQTT 主题长度不得超过 65535 字节。
此外，主题至少 1 个字符长，且不得包含空字符。

MQTT 主题具有层级结构，使用正斜杠或分隔符(`/`)作为主题层级分隔符。
该分隔符将主题树划分为「主题层级」。
例如，主题可为 `sensors/livingroom/temperature`，其中 `sensors`、`livingroom` 和 `temperature` 为主题层级。
此结构便于有效控制消息路由，尤其在主题中使用通配符时。

## 通配符

MQTT 主题中的通配符提供强大机制，用于简化对多主题的订阅并降低动态环境中管理主题订阅的复杂度。订阅者可使用模式以单一订阅匹配多个主题层级。

MQTT 支持两类通配符：
1. **多层通配符(`#`)** ——匹配主题字符串末尾任意数量的层级。
2. **单层通配符(`+`)** ——匹配主题层级中的一层。

### 多层通配符

井号(`#`)是匹配主题层级中所有剩余层级的通配符。它代表父级及任意数量的子层级。

<table>
  <thead>
      <tr>
          <td style="width: 30%"><b>订阅主题过滤器</b></td>
          <td style="width: 35%"><b>匹配的主题</b></td>
          <td style="width: 35%"><b>不匹配的主题</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
        <td>sensors/#</td>
        <td>
          sensors<br>
          sensors/<br>
          sensors/livingroom<br>
          sensors/livingroom/window
        </td>
        <td>
          /sensors
        </td>
      </tr>
  </tbody>
</table>

多层通配符 `#` **必须**：
* 仅使用一次。
* 位于主题过滤器末尾。
* 前接分隔符(`/`)。

以下主题过滤器**无效**，因 `#` 通配符未正确置于主题过滤器末尾或未由分隔符正确前接：
* `#sensors`
* `#/sensors`
* `sensors/#/`
* `sensors/#/temperature`

### 单层通配符

加号(`+`)表示主题层级中的单层。可用于在特定层级上以共同模式订阅主题。

<table>
  <thead>
      <tr>
          <td style="width: 30%"><b>订阅主题过滤器</b></td>
          <td style="width: 35%"><b>匹配的主题</b></td>
          <td style="width: 35%"><b>不匹配的主题</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
        <td>sensors/+/temperature</td>
        <td>
          sensors/livingroom/temperature<br>
          sensors/bedroom/temperature
        </td>
        <td>
          sensors/livingroom/window/temperature<br>
          sensors/temperature
        </td>
      </tr>
  </tbody>
</table>

单层通配符 `+` **必须**：
* 位于主题过滤器开头或紧跟正斜杠 `/`。
* 位于主题过滤器末尾或被正斜杠 `/` 紧跟。

以下主题过滤器**无效**，因 `+` 通配符相对分隔符的位置不正确：
* `+sensors`
* `sensors+`
* `sensors/home+`
* `sensors/+home`

### 通配符使用示例

以下示例展示在 MQTT 主题中单层与多层通配符不同位置上，订阅模式所具有的灵活性与深度。

<table>
  <thead>
      <tr>
          <td style="width: 50%"><b>订阅主题过滤器</b></td><td style="width: 50%"><b>匹配的主题</b></td>
      </tr>
  </thead>
<tbody>
    <tr>
      <td>sensors/+/temperature/#</td>
      <td>
        sensors/livingroom/temperature<br>
        sensors/bedroom/temperature<br>
        sensors/livingroom/temperature/status
      </td>
    </tr>
    <tr>
      <td>sensors/+/sensor/#</td>
      <td>
        sensors/kitchen/sensor/temperature<br>
        sensors/bedroom/sensor/humidity<br>
        sensors/livingroom/sensor/light/intensity
      </td>
    </tr>
    <tr>
      <td>+/house/#</td>
      <td>
        north/house/livingroom/temperature<br>
        south/house/kitchen/humidity<br>
        east/house/garden/light/intensity
      </td>
    </tr>
    <tr>
      <td>factory/+/status/#</td>
      <td>
        factory/machine1/status<br>
        factory/machine2/status<br>
        factory/machine1/status/error
      </td>
    </tr>
    <tr>
      <td>+/devices/+/battery</td>
      <td>
        home/devices/laptop/battery<br>
        office/devices/phone/battery<br>
        car/devices/gps/battery
      </td>
    </tr>
    <tr>
      <td>building/+/room/+/temperature</td>
      <td>
        building/1stfloor/room/101/temperature<br>
        building/2ndfloor/room/201/temperature<br>
        building/3rdfloor/room/301/temperature
      </td>
    </tr>
  </tbody>
</table>

## 最佳实践

设计 MQTT 主题时，遵循最佳实践有助于保证清晰、一致和可维护。

* 避免空白和特殊字符（除 `/` 外）。虽未明确禁止，但可能引起混淆或错误。
* 避免驼峰命名。统一使用小写以避免大小写混淆。主题区分大小写，即 `sensors/temperature` 与 `Sensors/Temperature` 视为不同主题。
* 避免主题以正斜杠(`/`)开头或结尾。易造成理解困难和不一致。例如 `sensors/home` 与 `/sensors/home` 视为不同主题。
* 避免订阅所有主题。订阅 `#` 表示客户端将接收 broker 上发往任一提主题的每条消息，可能很快被大量消息淹没，导致性能问题甚至崩溃。
* 避免过深的层级结构，随时间推移难以维护。使用清晰、描述性强且层级化的主题名，例如 `building/floor1/room1/temperature`。
* 避免不可打印字符，以保证跨系统兼容并减少意外问题。尽量仅使用 ASCII 字符。

## 多订阅匹配

在 MQTT 中，一个客户端可以有多个订阅，其中多个订阅匹配同一条发布消息的主题。

假设客户端订阅以下主题：
* `sensors/+/temperature`
* `sensors/room1/#`

若消息发布到主题 `sensors/room1/temperature`，**两个订阅均匹配**该主题。

此时 TBMQ 不会向每个匹配订阅各发一份。
而是将消息投递给 **QoS 最高的订阅**，或当多个订阅 QoS 相同时投递给第一个匹配的订阅。

## 配置最大主题段数

在 TBMQ 配置中，可定义主题中允许使用的最大正斜杠(`/`)数量。

默认不限制，因环境变量 `MQTT_TOPIC_MAX_SEGMENTS_COUNT` 设为 `0`（禁用）。

主题名中段数过多会负面影响处理时间和性能。
每增加一个段都会提高 broker 内主题匹配与路由的复杂度，可能导致延迟上升和资源消耗增加。

例如，若将 `MQTT_TOPIC_MAX_SEGMENTS_COUNT` 设为 `2`，则当用户尝试在主题中使用超过两个正斜杠(`/`)时（如 `sensors/floor1/room1/temperature` 含 3 个正斜杠），broker 将抛出错误。

## 共享订阅主题

还需提及 [共享订阅](/docs/{{docsPrefix}}mqtt-broker/user-guide/shared-subscriptions/) 特性，用于在多个订阅者间分发消息，实现负载均衡和资源高效利用。

共享订阅主题具有**特定格式**，以区别于普通主题。

共享主题的通用结构为：
```
$share/{ShareName}/{TopicFilter}
```

其中：
* $share —— 表示该订阅为共享订阅的常量。
* {ShareName} —— 共享订阅的标识符，用于区分其他共享订阅。
* {TopicFilter} —— 表示用于订阅的主题过滤器，与普通订阅类似。
  可包含通配符如 `#` 和 `+` 以匹配多个主题。

共享订阅主题示例：

```
$share/group1/country/+/city/+/home/#
```
