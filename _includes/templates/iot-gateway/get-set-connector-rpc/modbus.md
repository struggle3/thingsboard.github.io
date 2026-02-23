### GET 方法

使用 GET 方法可读取 Modbus 从站寄存器的值。

```bash
get type=<type>;functionCode=<functionCode>;objectsCount=<objectsCount>;address=<address>;
```

其中：
- `<type>` - 要读取的值类型；
- `<functionCode>` - Modbus 功能码；
- `<objectsCount>` - 要读取的对象数量；
- `<address>` - 要读取的寄存器地址。

例如，本示例中可从地址为 1 的 Modbus 从站读取 16 位整数值（室外温度）。
要读取地址 1 的寄存器值，请运行以下查询：

```bash
get type=16int;functionCode=3;objectsCount=1;address=1;
```

**响应：**

```json
{"result":{"value":13}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/modbus-get-set-rpc-1.png)
{: refdef}

### SET 方法

使用 SET 方法可向 Modbus 从站寄存器写入值。

```bash
set type=<type>;functionCode=<functionCode>;objectsCount=<objectsCount>;address=<address>;value=<value>;
```

其中：
- `<type>` - 要写入的值类型；
- `<functionCode>` - Modbus 功能码；
- `<objectsCount>` - 要写入的对象数量；
- `<address>` - 要写入的寄存器地址；
- `<value>` - 要写入的值。

例如，本示例中可向地址为 2 的 Modbus 从站（房间光照度）写入 16 位整数值。
要写入地址 2 的寄存器值，请运行以下查询：

```bash
set type=16int;functionCode=6;objectsCount=1;address=2;value=80;
```

**响应：**

```json
{"result":{"value":"80"}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/modbus-get-set-rpc-2.png)
{: refdef}

检查结果。要读取地址 2 的寄存器值，请运行以下查询：

```bash
get type=16int;functionCode=3;objectsCount=1;address=2;
```

**响应：**

```json
{"result":{"value":80}}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/modbus-get-set-rpc-3.png)
{: refdef}

可见值已成功写入。
