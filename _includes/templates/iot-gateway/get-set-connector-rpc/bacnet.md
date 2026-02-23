### GET 方法

使用 GET 方法可从 BACnet 设备读取数据。

```bash
get objectType=<objectType>;objectId=<objectId>;propertyId=<propertyId>;
```

其中：
- `<objectType>` - 要读取的对象类型；
- `<objectId>` - 要读取的对象 ID；
- `<propertyId>` - 要读取的属性 ID。

例如，本示例中可从 BACnet 设备读取房间光照度值。
要读取房间光照度值，请运行以下查询：

```bash
get objectType=analogValue;objectId=1;propertyId=presentValue;
```

**Response:**

```json
{"result": "30.5"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/bacnet-get-set-rpc-1.png)
{: refdef}

# SET 方法

使用 SET 方法可向 BACnet 设备写入数据。

```bash
set objectType=<objectType>;objectId=<objectId>;propertyId=<propertyId>;priority=<priority>;value=<value>;
```

其中：
- `<objectType>` - 要写入的对象类型；
- `<objectId>` - 要写入的对象 ID；
- `<propertyId>` - 要写入的属性 ID；
- `<priority>` - 要写入值的优先级（可选）；
- `<value>` - 要写入的值（可选，1 到 16 的整数）。

若 value 为空，BACnet connector 将发送带 Null 值的 relinquish 命令。
SET RPC 应包含 value 或 priority，或两者兼有。

例如，本示例中可将房间光照度值设置到 BACnet 设备。
要设置房间光照度值，请运行以下查询：

```bash
set objectType=analogValue;objectId=1;propertyId=presentValue;value=30.9;
```

**Response:**

```json
{"result": "{\"status\":\"ok\"}"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/bacnet-get-set-rpc-2.png)
{: refdef}

使用 GET 方法检查设置后的房间光照度值。只需运行上述 GET RPC 方法即可：

```bash
get objectType=analogValue;objectId=1;propertyId=presentValue;
```

**Response:**

```json
{"result": "30.9"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/bacnet-get-set-rpc-3.png)
{: refdef}
