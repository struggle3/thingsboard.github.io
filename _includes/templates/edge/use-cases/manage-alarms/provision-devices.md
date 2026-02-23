为简化操作，我们将通过 UI 手动配置设备。

首先在 Edge 上创建 **DHT22 温度传感器** 和 **空调** 设备，并为二者建立关联。该关联将用于在 **DHT22 温度传感器** 上报临界温度时查找对应的 **空调** 设备。

我们将在 Edge 上配置设备。请使用 URL **EDGE_URL** 打开 ThingsBoard **Edge** UI。

{% include images-gallery.html imageCollection="provisionDevicesEdge" showListImageTitles="true" %}

请使用 URL **SERVER_URL** 打开 **{{appPrefix}}**：

{% include images-gallery.html imageCollection="provisionDevices" showListImageTitles="true" %}
