此时已可为设备发布遥测数据。 如前所述，我们将使用 `thingsboard-python-client-sdk` 库。

开始配置项目：

1. 创建项目文件夹：

    ```bash
{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}   mkdir thingsboard_edge_example && cd thingsboard_edge_example{% else %}   mkdir thingsboard_example && cd thingsboard_example{% endif %}
   ```
   {:.copy-code}

2. 安装依赖：

   ```bash
   pip3 install tb-mqtt-client
   ```
   {:.copy-code}

3. 创建主脚本：

   ```bash
   nano main.py
   ```
   {:.copy-code}

4. 复制并粘贴以下代码：

   ```python
   import logging.handlers
   import time
   import os
   
   from tb_gateway_mqtt import TBDeviceMqttClient
   
   ACCESS_TOKEN = "TEST_TOKEN" {% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
   THINGSBOARD_EDGE_SERVER = '{{hostName}}' {% else %}
   THINGSBOARD_SERVER = '{{hostName}}'{% endif %}

   logging.basicConfig(level=logging.DEBUG)
   
   client = None
   
   # default blinking period
   period = 1.0
   
   
   # callback function that will call when we will change value of our Shared Attribute
   def attribute_callback(result, _):
        print(result)
        # make sure that you paste YOUR shared attribute name
        period = result.get('blinkingPeriod', 1.0)

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
   
   
   def get_data():
       cpu_usage = round(float(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage }' ''').readline().replace('\n', '').replace(',', '.')), 2)
       ip_address = os.popen('''hostname -I''').readline().replace('\n', '').replace(',', '.')[:-1]
       mac_address = os.popen('''cat /sys/class/net/*/address''').readline().replace('\n', '').replace(',', '.')
       processes_count = os.popen('''ps -Al | grep -c bash''').readline().replace('\n', '').replace(',', '.')[:-1]
       swap_memory_usage = os.popen("free -m | grep Swap | awk '{print ($3/$2)*100}'").readline().replace('\n', '').replace(',', '.')[:-1]
       ram_usage = float(os.popen("free -m | grep Mem | awk '{print ($3/$2) * 100}'").readline().replace('\n', '').replace(',', '.')[:-1])
       st = os.statvfs('/')
       used = (st.f_blocks - st.f_bfree) * st.f_frsize
       boot_time = os.popen('uptime -p').read()[:-1]
       avg_load = (cpu_usage + ram_usage) / 2
   
       attributes = {
           'ip_address': ip_address,
           'macaddress': mac_address
       }
       telemetry = {
           'cpu_usage': cpu_usage,
           'processes_count': processes_count,
           'disk_usage': used,
           'RAM_usage': ram_usage,
           'swap_memory_usage': swap_memory_usage,
           'boot_time': boot_time,
           'avg_load': avg_load
       }
       print(attributes, telemetry)
       return attributes, telemetry
   
   # request attribute callback
   def sync_state(result, exception=None):
        global period
        if exception is not None:
            print("Exception: " + str(exception))
        else:
            period = result.get('shared', {'blinkingPeriod': 1.0})['blinkingPeriod']

   def main():
        global client {% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
        client = TBDeviceMqttClient(THINGSBOARD_EDGE_SERVER, username=ACCESS_TOKEN){% else %}
        client = TBDeviceMqttClient(THINGSBOARD_SERVER, username=ACCESS_TOKEN){% endif %}
        client.connect()
        client.request_attributes(shared_keys=['blinkingPeriod'], callback=sync_state)
        
        # now attribute_callback will process shared attribute request from server
        sub_id_1 = client.subscribe_to_attribute("blinkingPeriod", attribute_callback)
        sub_id_2 = client.subscribe_to_all_attributes(attribute_callback)

        # now rpc_callback will process rpc requests from server
        client.set_server_side_rpc_request_handler(rpc_callback)

        while not client.stopped:
            attributes, telemetry = get_data()
            client.send_attributes(attributes)
            client.send_telemetry(telemetry)
            time.sleep(60)
   
   if __name__=='__main__':
       if ACCESS_TOKEN != "TEST_TOKEN":
           main()
       else:
           print("Please change the ACCESS_TOKEN variable to match your device access token and run script again.")
   ```
   {:.copy-code.expandable-15}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}

将上方代码中的 THINGSBOARD_EDGE_SERVER、ACCESS_TOKEN 变量改为您的凭证。

连接所需变量：  

   | 变量名 | 默认值 | 说明 |
   |-|-|
   | ACCESS_TOKEN | **TEST_TOKEN** | 设备访问令牌 |
   | THINGSBOARD_EDGE_SERVER | **{{hostName}}** | 运行 Edge 的 {{deviceName}} 的 IP 地址 | 
   
若在已安装 Edge 的同一台 **{{deviceName}}** 上运行脚本，也可使用 `localhost`。

{% else %}

将上方代码中的 THINGSBOARD_SERVER、ACCESS_TOKEN 变量改为您的凭证。

连接所需变量：  

   | 变量名 | 默认值 | 说明 | 
   |-|-|
   | ACCESS_TOKEN | **TEST_TOKEN** | 设备访问令牌 |
   | THINGSBOARD_SERVER | **{{hostName}}** | 您的 ThingsBoard 主机或 IP 地址 |
{% endif %}

5. 按 **Ctrl+O** 和 **Ctrl+X** 保存文件。
6. 最后，运行脚本：

   ```bash
   python3 main.py
   ```
   {:.copy-code}

若操作正确，将看到如下控制台输出：
```
> INFO:tb_device_mqtt:connection SUCCESS
> 
> 
> {'ip_address': '192.168.1.198', 'macaddress': '3c:06:30:44:e0:24'} {'cpu_usage': 6.6, 'processes_count': 8, 'disk_usage': 70.0, 'RAM_usage': 73.9, 'swap_memory_usage': 69.4, 'battery': 29, 'boot_time': 1675154176.0}
> 
```

下面回顾并解释代码。 本步骤关注 `get_data` 函数。`get_data` 负责打包并返回数据，如需监控更多指标，可方便地向字典中添加新的遥测或属性：
```python
...
def get_data():
       cpu_usage = round(float(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage }' ''').readline().replace('\n', '').replace(',', '.')), 2)
       ip_address = os.popen('''hostname -I''').readline().replace('\n', '').replace(',', '.')[:-1]
       mac_address = os.popen('''cat /sys/class/net/*/address''').readline().replace('\n', '').replace(',', '.')
       processes_count = os.popen('''ps -Al | grep -c bash''').readline().replace('\n', '').replace(',', '.')[:-1]
       swap_memory_usage = os.popen("free -m | grep Swap | awk '{print ($3/$2)*100}'").readline().replace('\n', '').replace(',', '.')[:-1]
       ram_usage = float(os.popen("free -m | grep Mem | awk '{print ($3/$2) * 100}'").readline().replace('\n', '').replace(',', '.')[:-1])
       st = os.statvfs('/')
       used = (st.f_blocks - st.f_bfree) * st.f_frsize
       boot_time = os.popen('uptime -p').read()[:-1]
       avg_load = (cpu_usage + ram_usage) / 2
   
       attributes = {
           'ip_address': ip_address,
           'macaddress': mac_address
       }
       telemetry = {
           'cpu_usage': cpu_usage,
           'processes_count': processes_count,
           'disk_usage': used,
           'RAM_usage': ram_usage,
           'swap_memory_usage': swap_memory_usage,
           'boot_time': boot_time,
           'avg_load': avg_load
       }
       print(attributes, telemetry)
       return attributes, telemetry
...
```

数据发送部分：如下所示，每 60 秒发送一次属性和遥测（如需更频繁可自行调整）：
```python
...		
    while not client.stopped:
        attributes, telemetry = get_data()
        client.send_attributes(attributes)
        client.send_telemetry(telemetry)
        time.sleep(60)
...
```
