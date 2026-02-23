在终端中执行以下命令安装 CoAP 和 checksum 库：

```bash
pip3 install asyncio aiocoap mmh3 --user
```
{: .copy-code}

进入客户端文件夹路径，执行以下命令以通过 ThingsBoard 获取固件示例脚本：

```bash
python3 coap_firmware_client.py 
```
{: .copy-code}

下载 CoAP 客户端示例：[**coap_firmware_client.py**](/docs/user-guide/resources/firmware/coap_firmware_client.py)

出现以下提示时：
- `Please write your ThingsBoard host or leave it blank to use default (localhost):`：输入 localhost 或平台地址；
- `Please write your ThingsBoard port or leave it blank to use default (5683):`：可直接按 Enter 继续，或输入端口号；
- `Please write accessToken for device:`：从 ThingsBoard 复制设备 accessToken 并粘贴到终端；
- `Please write firmware chunk size in bytes or leave it blank to get all firmware by request:`：留空则一次性下载完整固件；若需分块下载，请输入分块大小（字节）。

{% include images-gallery.html imageCollection="fw-coap-updated" %}

设备固件已更新。要查看状态，请前往固件仪表板，如下文所述。

要了解固件更新相关操作，请[发起请求并订阅属性](/docs/{{docsPrefix}}reference/coap-api/#firmware-api)。

