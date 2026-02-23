### GET 方法

使用 GET 方法可从 FTP 服务器读取数据。

```bash
get filePath=<filePath>;
```

其中：
- `<filePath>` - FTP 服务器上的文件路径。

例如，本示例中 **light_level.txt** 文件在 FTP 服务器上存储房间光照度。
要读取房间光照度值，请运行以下查询：

```bash
get filePath=./light_level.txt;
```

**响应：**

```json
{"result":  30}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/ftp-get-set-rpc-1.png)
{: refdef}

### SET 方法

使用 SET 方法可向 FTP 服务器写入数据。

```bash
set filePath=<filePath>;value=<value>;
```

其中：
- `<filePath>` - FTP 服务器上的文件路径；
- `<value>` - 要写入的值。

例如，本示例中 **light_level.txt** 文件在 FTP 服务器上存储房间光照度。
要写入房间光照度值，请运行以下查询：

```bash
set filePath=./light_level.txt;value=80;
```

**响应：**

```json
{"result":  "{\"success\": true}"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/ftp-get-set-rpc-2.png)
{: refdef}

使用 GET 方法检查设置后的房间光照度值。只需运行上述 GET RPC 方法即可：

```bash
get filePath=./light_level.txt;
```

**响应：**

```json
{"result":  80}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/ftp-get-set-rpc-3.png)
{: refdef}
