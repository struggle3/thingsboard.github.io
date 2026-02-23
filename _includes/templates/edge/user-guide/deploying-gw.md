要部署 **ThingsBoard Gateway**：

{% assign iotGWdashboardPE = '
    ===
        image: /images/edge/user-guide/edge-install/6-dashboard-group-pe.webp,
        title: 登录 **ThingsBoard Professional Edition** 实例，进入 **仪表板** 部分，选择 **「Group」** 选项卡。点击 **「+」** 图标添加新分组。在 **「添加实体分组」** 弹出窗口中，在 **「Name」** 字段输入分组名称，并点击 **「Add」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/7-all-dashboards-pe.webp,
        title: 然后选择 **「All」** 选项卡，找到 **「ThingsBoard IoT Gateways」** 仪表板。**「ThingsBoard IoT Gateways」** 仪表板为预置的开箱即用仪表板。点击 **「Dashboard details」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/8-manage-owner-and-groups-pe.webp,
        title: 在 **「Dashboard details」** 页面点击 **「Manage owner and groups」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/9-add-group-pe.webp,
        title: 在 **「Manage owner and groups」** 弹出窗口中，从 **「Groups」** 下拉菜单选择新创建的分组。点击 **「Update」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/10-instance-secton-manage-dashboard-pe.webp,
        title: 进入 **Edge Management > Instances** 部分，点击 **「Manage edge dashboard groups」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/11-assign-pe.webp,
        title: 在 **「Dashboard groups」** 页面，点击 **「+」** 图标，将新创建的分组分配给 Edge 实例。点击 **「Assign」** 按钮。该分组及其内所有仪表板将分配给 Edge 实例。
'
%}

{% assign iotGWdashboardCE = '
    ===
        image: /images/edge/user-guide/edge-install/6-instance-section-manage-dashboard.webp,
        title: 登录 **ThingsBoard Community Edition** 实例，进入 **Edge Management > Instances** 部分，点击 **「Manage dashboards」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/7-assign.webp,
        title: 在 **「Edge Dashboards」** 页面，点击 **「+」** 图标，将 **「ThingsBoard IoT Gateways」** 仪表板分配给 Edge 实例。点击 **「Assign」** 按钮。**「ThingsBoard IoT Gateways」** 仪表板为预置的开箱即用仪表板。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=iotGWdashboardPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=iotGWdashboardCE %}
{% endif %}

{% assign localhostPE = '
    ===
        image: /images/edge/user-guide/edge-install/12-dashboards-on-edge-pe.webp,
        title: 打开 **Edge 实例**，进入 **Dashboards** 部分，打开 **「ThingsBoard IoT Gateways」** 仪表板。
    ===
        image: /images/edge/user-guide/edge-install/13-add-gw-pe.webp,
        title: 点击右上角 **「+」** 图标添加新网关。在 **「Name」** 字段输入网关名称，选择 **「default」** 设备配置。点击 **「Create」** 按钮。
'
%}

{% assign localhostCE = '
    ===
        image: /images/edge/user-guide/edge-install/8-dashboards-on-edge.webp,
        title: 打开 **Edge 实例**，进入 **Dashboards** 部分，打开 **「ThingsBoard IoT Gateways」** 仪表板。
    ===
        image: /images/edge/user-guide/edge-install/9-add-gw.webp,
        title: 点击右上角 **「+」** 图标添加新网关。在 **「Name」** 字段输入网关名称，选择 **「default」** 设备配置。点击 **「Create」** 按钮。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=localhostPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=localhostCE %}
{% endif %}
