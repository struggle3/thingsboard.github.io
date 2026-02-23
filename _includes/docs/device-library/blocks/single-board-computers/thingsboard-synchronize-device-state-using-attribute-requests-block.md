{% capture difference %}
**请确保在设备上创建共享属性 `blinkingPeriod`。** 
{% endcapture %}
{% include templates/info-banner.md content=difference %}

示例代码支持在启动时从 {% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}**ThingsBoard Edge**{% else %}**ThingsBoard**{% endif %} 获取设备状态。相关代码片段如下。

Attribute callback:
```python
def sync_state(result, exception=None):
    global period
    if exception is not None:
        print("Exception: " + str(exception))
    else:
        period = result.get('shared', {'blinkingPeriod': 1.0})['blinkingPeriod']
```
{:.copy-code}

Attribute request:
```python
def main():
    client = TBDeviceMqttClient("{{hostName}}", username="ACCESS_TOKEN")
    client.connect()
    client.request_attributes(shared_keys=['blinkingPeriod'], callback=sync_state)
    ...
```
{:.copy-code}

为使回调能从 {% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}**ThingsBoard Edge**{% else %}**ThingsBoard**{% endif %} 接收共享属性数据，
设备在连接后需显式请求。此功能使设备在重启后能恢复正确的属性值，保持实际状态。

