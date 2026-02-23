* TOC
{:toc}

## 用例描述

作为租户，我希望通过脚本或 UI 预配置设备。我的客户直接从我或通过经销商购买设备。
我希望客户在获得设备物理访问权后，能够基于二维码或类似方式认领设备。

设备被认领后，客户成为其所有者，客户用户可访问设备数据并控制设备。

## 设备认领场景

ThingsBoard 用户在「知道」设备名称和 Secret Key 时可以认领设备。
Secret Key 为可选，始终有过期时间，并可能随时间变化。

Secret Key 可通过两种方式配置：

1. *Device-side key（设备端 key）* 场景 - 设备包含带过期时间戳的 **expirationTime** 服务端属性。设备向 ThingsBoard 发送包含认领数据的认领请求，此后客户才能使用设备认领部件认领设备。
2. *Server-side key（服务端 key）* 场景 - 设备包含带认领数据的 **claimingData** 服务端属性，客户使用认领设备部件认领设备。

详见下文。

{% capture claimingscenariotogglespec %}
使用 <b>device-side</b> key 场景认领%,%deviceside%,%templates/claiming/device-key-scenario.md%br%
使用 <b>server-side</b> key 场景认领%,%serverside%,%templates/claiming/server-key-scenario.md%br%{%endcapture%}
{% include content-toggle.liquid content-toggle-id="claimingscenario" toggle-spec=claimingscenariotogglespec %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}

## PE 中的设备认领权限

需注意的是，在 PE 版本中，尝试认领特定设备的用户必须具有相应权限。
本例中所需权限为：

- **Resource: Device**
- **Operation: Claim devices**

让我们为自定义认领用户组添加上述权限。

{% include images-gallery.html imageCollection="device-claiming-permissions-in-pe-carousel" showListImageTitles="true" %}

{% endif %}

## 设备认领部件

{% include images-gallery.html imageCollection="device-claiming-widget-carousel" showListImageTitles="true" %}

## 设备认领 API 请求

认领请求以 POST 请求发送至以下 URL：

```shell
http(s)://host:port/api/customer/device/$DEVICE_NAME/claim
```
{: .copy-code}

支持的数据格式为：

```json
{
  "secretKey":"value"
}
```
{: .copy-code}

**注意**：消息不包含 **durationMs** 参数，**secretKey** 参数为可选。

认领成功后，设备将分配给特定客户。若系统参数 **allowClaimingByDefault** 为 **false**，**claimingAllowed** 属性将自动删除。

此外，可以重新认领设备，即从客户中取消分配设备。若 **allowClaimingByDefault** 为 **false**，**claimingAllowed** 属性将再次出现。

有关上述步骤的更多详情请参阅下文。

## 设备重新认领 API 请求

要重新认领设备，可向以下 URL 发送 DELETE 请求（别忘了将设备名称替换为正确名称）：

```shell
curl -X DELETE {{httpsUrl}}/api/customer/device/$DEVICE_NAME/claim
```
{: .copy-code}

您将收到类似以下的响应：

```json
{
  "result": {},
  "setOrExpired": true
}
```
{: .copy-code}

## Python 示例脚本

本节提供设备认领功能的代码示例。
我们将使用 **tb-mqtt-client** Python 模块连接并认领设备。
可通过以下命令安装：

```bash
pip3 install tb-mqtt-client --user
```
{: .copy-code}

### 基本认领示例

假设我们在租户级别有设备并已配置客户，如上所述。
此时，我们想连接设备并发送认领请求将其分配给客户。

用例描述：
ThingsBoard 上有一台名为 **Test claiming device** 的设备。
设备具有访问令牌凭据 - **Eypdinl1gUF5fSerOPJF**。

我们应[下载下方脚本](/docs/user-guide/resources/claiming-device/basic_claiming_example.py)并运行以向服务器发送认领请求。

```python
#
# Copyright © 2016-2024 The ThingsBoard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

from tb_device_mqtt import TBDeviceMqttClient

def collect_required_data():
    config = {}
    print("\n\n", "="*80, sep="")
    print(" "*20, "ThingsBoard basic device claiming example script.", sep="")
    print("="*80, "\n\n", sep="")
    host = input("Please write your ThingsBoard server hostname or leave it blank to use default ({{mqttHostName}}): ")
    config["host"] = host if host else "{{mqttHostName}}"
    token = ""
    while not token:
        token = input("Please write accessToken for device: ")
        if not token:
            print("Access token is required!")
    config["token"] = token
    config["secret_key"] = input("Please write secret key for claiming request: ")
    if not config["secret_key"]:
        print("Please make sure that you have claimingData in server attributes for device to use this feature without device secret in the claiming request.")
    duration_ms = input("Please write duration in milliseconds for claiming request or leave it blank to use default (30000): ")
    config["duration_ms"] = int(duration_ms) if duration_ms else 30000
    print("\n", "="*80, "\n", sep="")
    return config


if __name__ == '__main__':
    config = collect_required_data()
    client = TBDeviceMqttClient(config["host"], username=config["token"])
    client.connect()
    rc = client.claim(secret_key=config["secret_key"], duration=config["duration_ms"]).get()
    if rc == 0:
        print("Claiming request was sent, now you should use claiming device widget to finish the claiming process.")

```
{:.copy-code.expandable-20}

然后我们可使用 [设备认领部件](#device-claiming-widget)。

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/guides-banner.md %}
