{% capture difference %}
**请勿忘记在设备上创建共享属性 `blinkingPeriod`。** 
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
可通过[共享属性](/docs/{{peDocsPrefix}}user-guide/attributes/#shared-attributes){: target="_blank"}更新功能修改闪烁周期。
{% else %}
可通过[共享属性](/docs/{{page.docsPrefix}}user-guide/attributes/#shared-attributes){: target="_blank"}更新功能修改闪烁周期。
{% endif %}

该属性类型仅适用于设备，与服务端属性类似但有关键差异：设备固件/应用可请求共享属性值或订阅其更新。共享属性常用于存储设备配置。

运行本段代码建议使用 Python 3.9 或更高版本。  


若尚未安装 Python，请按以下步骤操作：  

```bash
sudo apt update
sudo apt install software-properties-common
```
{:.copy-code}

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
{:.copy-code}

```bash
sudo apt install python3.9
```
{:.copy-code}

```bash
sudo apt-get install -y python3 git python3-pip
```
{:.copy-code}

还需安装 Adafruit-Blinka 库，使用以下命令：  

```bash
pip3 install Adafruit-Blinka
```
{:.copy-code}


现在可以编写代码。本部分在 `blink` 函数中使用新包控制 LED 闪烁，
并通过 `attibute_callback` 在共享属性变更时被调用，最后在 `main` 中将其绑定到订阅者。

```python
import digitalio
import board

...

# default blinking period
period = 1.0

# callback function that will call when we will change value of our Shared Attribute
def attribute_callback(client, result):
    print(client, result)
    # make sure that you paste YOUR shared attribute name
    period = result.get('blinkingPeriod', 1.0)

def main():
    ...
    # make sure that you paste YOUR shared attribute name
    sub_id_1 = client.subscribe_to_attribute("blinkingPeriod", attribute_callback)
    sub_id_2 = client.subscribe_to_all_attributes(attribute_callback)
    led = digitalio.DigitalInOut(board.PD14)
    led.direction = digitalio.Direction.OUTPUT
    ...
    led.value = True
    time.sleep(period)
    led.value = False
    time.sleep(period)
```

若使用导入的仪表板，可通过仪表板右下角的以下部件调整闪烁周期：

![attribute-update-widget](/images/devices-library/basic/single-board-computers/attribute-update-widget.png)
