### 导入仪表盘

您可导入 JSON 格式的仪表盘。要导入仪表盘，请进入「仪表盘」组，点击页面右上角的 **「+」** 按钮，选择 **「导入仪表盘」**。仪表盘导入窗口将弹出，系统会提示您上传 **JSON** 文件并点击 **「导入」**。

{% assign importingDashboardCE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-ce.png,
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-ce.png,
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-ce.png,
    '
%}

{% assign importingDashboardPE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-pe.png,
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-pe.png,
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-pe.png,
    '
%}

{% assign importingDashboardEdgeCE = '
    ===
        image: /images/edge/config/general/import-dashboard-1-ce.webp,
    ===
        image: /images/edge/config/general/import-dashboard-2-ce.webp,
    ===
        image: /images/edge/config/general/import-dashboard-3-ce.webp,
'
%}

{% assign importingDashboardEdgePE = '
    ===
        image: /images/edge/config/general/import-dashboard-1-pe.webp,
    ===
        image: /images/edge/config/general/import-dashboard-2-pe.webp,
    ===
        image: /images/edge/config/general/import-dashboard-3-pe.webp,
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardPE %}
{% elsif page.docsPrefix == "pe/edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardEdgePE %}
{% elsif page.docsPrefix == "edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardEdgeCE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardCE %}
{% endif %}

下方可找到仪表盘 JSON 文件：

[检查并控制设备数据仪表盘](/docs/devices-library/resources/dashboards/minicomputers/dashboard.json){:target="_blank" download="dashboard.json"}

导入后，我们需要为设备选择实体别名。
操作方式：点击铅笔图标并选择实体别名，选择别名「My device」并点击铅笔图标打开编辑。
然后，从下拉列表中选择名为 My device 的设备并保存实体别名。完成后即可查看设备数据。

若操作正确，您将看到以下仪表盘：
![dashboard](/images/devices-library/basic/single-board-computers/minicomputer-dashboard.png)
