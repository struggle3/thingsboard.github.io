### 导入仪表盘

下载 [检查设备数据仪表盘](/docs/devices-library/resources/dashboards/ready-to-go-devices/temco-tstat10-dashboard.json){:target="_blank" download="teltonika-rut955-dashboard.json"} 并导入。

您可导入 JSON 格式的仪表盘。操作方式：进入「仪表盘」组，点击页面右上角的 **「+」** 按钮，选择 **「导入仪表盘」**。
仪表盘导入窗口将弹出，提示您上传 JSON 文件并点击 **「导入」**。

{% assign importingDashboardPE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-pe.png
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-pe.png
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-pe.png
    '
%}

{% assign importingDashboardCE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-ce.png
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-ce.png
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-ce.png
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardPE %}
{% else %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardCE %}
{% endif %}

导入后，我们需要为设备选择实体别名。
首先点击 **「铅笔」** 图标，选择实体别名，选择 **「My device」** 别名，再次点击 **「铅笔」** 图标打开编辑。
然后，从下拉列表中选择已创建设备并保存实体别名。完成后即可查看设备数据。

若操作正确，您将看到以下仪表盘：

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
![imagePe](/images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-dashboard-ce.png)
{% else %}  
![imageCe](/images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-dashboard-ce.png)
{% endif %}
