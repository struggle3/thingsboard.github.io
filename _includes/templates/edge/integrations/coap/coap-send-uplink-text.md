发送上行消息：

```shell
echo -e 'SN-001,default,temperature,25.7,humidity,69' | coap-client -m post $YOUR_COAP_ENDPOINT_URL -t text/plain -f-
```
{: .copy-code}
* 请将 **`$YOUR_COAP_ENDPOINT_URL`** 替换为对应值。

![image](/images/pe/edge/integrations/coap/terminal-coap-text-payload-1-edge.webp)

查看上行消息：
* 进入 **Integrations center > Integrations**（集成中心 > 集成）部分并点击该集成
* 在 **「Integration details」**（集成详情）页面选择 **「Events」**（事件）选项卡
* 检查上行消息状态。若配置正确，状态将显示为 **「OK」**。

{% include images-gallery.html imageCollection="events-text" %}

消息发送后，将创建新设备。
查看创建的设备及其数据：
* 进入 **Entities > Devices**（实体 > 设备）部分并点击该设备
* 在 **「Device details」**（设备详情）页面选择 **「Latest telemetry」**（最新遥测）选项卡。

{% include images-gallery.html imageCollection="device-text" %}

接收到的数据可在 **Uplink converter**（上行转换器）中查看：
* 进入 **Integrations center > Data converters**（集成中心 > 数据转换器）部分并点击 **Uplink converter**
* 在 **「Data converter details」**（数据转换器详情）页面，选择 **「Events」**（事件）选项卡
* 在 **「In」** 和 **「Out」** 列中查看消息详情。

{% include images-gallery.html imageCollection="coap-converter-text-events" %}
