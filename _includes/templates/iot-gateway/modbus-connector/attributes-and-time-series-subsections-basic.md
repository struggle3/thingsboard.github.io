本单元配置提供 Modbus 服务器上数据处理相关设置。这些设置在 ThingsBoard 平台实例中将被解释为设备的 attribute/time series。以下参数用于配置设备 attribute 和 time series：

- **Key** - 平台上 attribute 或 time series 的 key。
- **Type** - Modbus 寄存器的数据类型。
- **Function code** - 读取寄存器的 Modbus 功能码。
- **Objects count** - 要读取的寄存器数量。
- **Address** - Modbus 服务器上寄存器的地址。

{% capture difference %}
所有配置参数列表及详细说明请参见[高级配置](/docs/iot-gateway/config/modbus/#device-mapping)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/modbus-connector/attributes-and-timeseries-overview.png)

要添加新的 attribute 或 time series，请按以下步骤操作：

{% assign attributes = '
    ===
        image: /images/gateway/modbus-connector/attributes-1-ce.png,
        title: 在 "Attributes" 或 "**Time series**" 部分点击 "**pencil**" 图标（取决于所选部分）；
    ===
        image: /images/gateway/modbus-connector/attributes-2-ce.png,
        title: 在打开的窗口中点击 "**Add attribute**" 或 "**Add time series**"（取决于所选部分）；
    ===
        image: /images/gateway/modbus-connector/attributes-3-ce.png,
        title: 填写 key、type、function code、objects count 和 address 字段。点击 "Apply"。
'
%}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=attributes %}

##### Report strategy（上报策略）

您可为每个 time series 或 attribute 启用特定的 report strategy。该策略定义数据发送到 ThingsBoard 服务器的频率。可用策略如下：

- **On report period** - 在上报周期后向 ThingsBoard 发送数据；
- **On value change** - 当值变化时向 ThingsBoard 发送数据；
- **On value change or report period** - 当值变化或在上报周期后向 ThingsBoard 发送数据；
- **On received** - 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

{% capture difference %}
有关 report strategy 的更多信息请参见[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### Enum mapping（枚举映射）

{% capture difference %}
此功能自 ThingsBoard IoT Gateway v.3.8.1 起可用，且仅在高级配置模式下可用。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

可使用 enum mapping 功能将寄存器值映射为人类可读的字符串。对于值表示设备状态而非“传感器值”的寄存器特别有用。Enum mapping 适用于所有寄存器类型。上行 `RPC to Device` 调用可使用 enum mapping 获取解释后的值。
此外，enum mapping 可按预期与批量读取配合使用。

要为特定 attribute 或 time series 设置 enum mapping，需在配置中定义 `variants` 参数。该参数为对象，每个 key 表示可能的寄存器值，对应的 value 为描述该寄存器值的人类可读字符串。

Enum mapping 配置示例：
```json
{
  "tag": "status",
  "type": "16int",
  "address": 1,
  "objectsCount": 1,
  "functionCode": 3,
  "variants": {
    "0": "Stopped",
    "1": "Booting",
    "2": "Running"
  }
}
```

线圈寄存器 enum mapping 配置示例：
```json
{
  "tag": "relay",
  "type": "bits",
  "address": 1,
  "objectsCount": 1,
  "functionCode": 1,
  "bitTargetType": "int",
  "variants": {
    "0": "Disable",
    "1": "Enable"
  }
}
```

`RPC to Device` 调用的 enum mapping 配置示例：
```json
{
  "method": "getStatus",
  "type": "16int",
  "address": 1,
  "objectsCount": 1,
  "functionCode": 3,
  "variants": {
    "0": "Stopped",
    "1": "Booting",
    "2": "Running"
  }
}
```

{% capture difference %}
更多使用示例请参见[使用示例](/docs/iot-gateway/config/modbus/#usage-examples)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### Modifier（修饰符）

可通过以下设置对 attribute/time series 值应用 **modifier**：

| **参数** | **说明**                                                                                                                                                                  |
|:--------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Type          | **multiplier** - 读取结果将乘以此参数的值。<br>**divider** - 读取结果将除此参数的值 |
| Value         | 用于修改读取值的数值                                                                                                                             | 
| ---           |                                                                                                                                                                                  |

{% capture difference %}
更多使用示例请参见[使用示例](/docs/iot-gateway/config/modbus/#usage-examples)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/modbus-connector/modifier.png)

##### Batch reading（批量读取）

{% capture difference %}
此功能自 ThingsBoard IoT Gateway v.3.7.9 起可用，且仅在高级配置模式下可用。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

为优化读取过程，可将多个寄存器分组到单个批量读取请求中。这种方式可减少发送到 Modbus 服务器的请求数量，从而提高性能并降低网络流量。请注意，批量读取请求中的寄存器必须为相同类型和功能码。

组读取配置中有两个重要参数：`address` 和 `tag`。详细说明如下：

- **address** - 起始寄存器地址与结束寄存器地址，用 `-` 分隔。例如 `0-10` 表示组读取从地址 `0` 的寄存器开始，到地址 `10` 的寄存器结束（含）。
- **tag** - 组读取内每个寄存器的唯一标识符，用于在给定地址范围内识别特定寄存器。tag 名称可使用以下变量构成表达式：
    - `${address}` - 组读取内的寄存器地址。
    - `${unitId}` - slave ID。
    - `${functionCode}` - 功能码。
    - `${type}` - 寄存器的数据类型。
    - `${objectsCount}` - 对象数量。

`divider` 和 `multiplier` 参数按预期工作。

组读取配置示例：

```json
{
  "tag": "${unitId} - ${type} - ${address}",
  "type": "16int",
  "functionCode": 3,
  "objectsCount": 1,
  "address": "0-10"
}
```

{% capture difference %}
更多使用示例请参见[使用示例](/docs/iot-gateway/config/modbus/#usage-examples)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
