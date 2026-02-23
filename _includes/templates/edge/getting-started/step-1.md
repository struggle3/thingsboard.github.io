在**ThingsBoard**中，**设备**是生成遥测数据的核心实体，这些数据被存储和处理以供仪表盘和分析使用。
**ThingsBoard**还提供**虚拟设备shell**，用于代表物理设备发送遥测数据以便进行测试。

要在**Edge**上添加新设备，请登录您的**ThingsBoard Edge**实例（**EDGE_URL**）并按以下步骤操作：

{% include images-gallery.html imageCollection="step1" showListImageTitles="true" %}

此外，还可使用以下方式：
* [Bulk provisioning（批量配置）](/docs/{{peDocsPrefix}}user-guide/bulk-provisioning/){: target="_blank"}：通过用户界面从CSV文件部署多个设备。
* [REST API](/docs/{{peDocsPrefix}}api/){: target="_blank"}：以编程方式添加设备及其他实体。

{% capture local-deployment %}
在**Edge**上创建设备后，它将**自动配置**到**ThingsBoard Server**。要在Server上查看Edge设备，请访问**SERVER_URL**并进入**Entities > Devices**（实体 > 设备）部分。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}
