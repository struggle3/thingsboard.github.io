{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
**ThingsBoard Edge** 支持发送[远程过程调用 (RPC)](/docs/{{peDocsPrefix}}user-guide/rpc/#server-side-rpc){: target="_blank"}
{% else %} 
**ThingsBoard** 支持发送[远程过程调用 (RPC)](/docs/{{page.docsPrefix}}user-guide/rpc/#server-side-rpc){: target="_blank"}
{% endif %}，可在服务端应用与设备之间双向通信。
该功能支持向设备发送/接收命令并获取执行结果。

本指南将配置 RPC 命令以立即从 OrangePI 获取遥测数据。若使用导入的仪表板，则无需额外配置，仪表板已包含以下部件：

![one-way-rpc-widget](/images/devices-library/basic/single-board-computers/one-way-rpc-widget.png)


💡 若您创建新仪表板，可使用**「RPC 按钮」**部件进行单向 RPC 通信，该部件位于**「控制部件」**组合中。

下面编写代码。 首先创建 `rpc_callback` 函数，在设备收到服务端 RPC 请求时触发。与共享属性示例类似，需在 `main` 中将该回调绑定到订阅者。

```python
client = None

...

# callback function that will call when we will send RPC
def rpc_callback(id, request_body):
    # request body contains method and other parameters
    print(request_body)
    method = request_body.get('method')
    if method == 'getTelemetry':
        attributes, telemetry = get_data()
        client.send_attributes(attributes)
        client.send_telemetry(telemetry)
    else:
        print('Unknown method: ' + method)

...

def main():
    ...

    # now rpc_request_response will process rpc requests from server
    client.set_server_side_rpc_request_handler(rpc_callback)

    ...
```

点击 **RPC 按钮** 后，设备将立即发送遥测（CPU 占比、进程数等）。
可在仪表板的图表中看到更新。

![timeseries-rpc-widget](/images/devices-library/basic/single-board-computers/timeseries-rpc-widget.png)

若操作正确，控制台将输出：

```python
{'method': 'getTelemetry', 'params': {}}
```