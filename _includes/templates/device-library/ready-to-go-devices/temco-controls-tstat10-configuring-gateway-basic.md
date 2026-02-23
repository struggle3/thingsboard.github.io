{% assign creatingGatewayCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-1-ce.png,
        title: 在浏览器中打开 ThingsBoard 并登录。进入侧边栏 "**实体**" > "**网关**" 标签页，点击 "**+**" 按钮。填写 "**名称**" 和 "**设备配置**" 并点击 "**创建**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-2-ce.png,
        title: 使用启动命令启动网关； 
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-3-ce.png,
        title: 网关已创建。点击侧边栏菜单中的 "**连接器配置**" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-4-ce.png,
        title: 点击 "**+**" 添加新连接器；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-5-ce.png,
        title: 选择 "**BACnet**" 连接器类型，填写 "**名称**" 并点击 "**添加**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-6-ce.png,
        title: 连接器已创建；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-7-ce.png,
        title: 在已创建连接器中进入 "**设备**" 标签页并删除默认设备；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-8-ce.png,
        title: 点击 "添加设备" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-9-ce.png,
        title: 填写 "**Host**" 和 "**Port**"（可在 T3000 软件中查看）。"**设备名称**" 和 "**设备配置名称**" 分别填 "**Temco Tstat10**" 和 "**default**"。轮询周期设为 3000 ms（可按需调整）；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-10-ce.png,
        title: 点击 "**时序铅笔**" 图标；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-11-ce.png,
        title: 在弹出窗口中点击 "**添加时序**" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-12-ce.png,
        title: "**Key**" 填 "**sensor_temperature**"，"**Object ID**" 填 "**Analog Input**" 和 "**1**"。点击 "**添加时序**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-13-ce.png,
        title: "**Key**" 填 "**sensor_humidity**"，"**Object ID**" 填 "**Analog Input**" 和 "**2**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-14-ce.png,
        title: "**Key**" 填 "**controller_temperature**"，"**Object ID**" 填 "**Analog Input**" 和 "**9**"。点击 "**应用**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-15-ce.png,
        title: 点击 "**添加**" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-16-ce.png,
        title: 设备已添加。
'
%}

{% assign creatingGatewayPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-1-pe.png,
        title: 在浏览器中打开 ThingsBoard 并登录。进入侧边栏 "**实体**" > "**网关**" 标签页，点击 "**+**" 按钮。填写 "**名称**" 和 "**设备配置**" 并点击 "**创建**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-2-pe.png,
        title: 使用启动命令启动网关； 
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-3-pe.png,
        title: 网关已创建。点击侧边栏菜单中的 "**连接器配置**" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-4-pe.png,
        title: 点击 "**+**" 添加新连接器；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-5-pe.png,
        title: 选择 "**BACnet**" 连接器类型，填写 "**名称**" 并点击 "**添加**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-6-pe.png,
        title: 连接器已创建；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-7-pe.png,
        title: 在已创建连接器中进入 "**设备**" 标签页并删除默认设备；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-8-pe.png,
        title: 点击 "添加设备" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-9-pe.png,
        title: 填写 "**Host**" 和 "**Port**"（可在 T3000 软件中查看）。"**设备名称**" 和 "**设备配置名称**" 分别填 "**Temco Tstat10**" 和 "**default**"。轮询周期设为 3000 ms（可按需调整）；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-10-pe.png,
        title: 点击 "**时序铅笔**" 图标；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-11-pe.png,
        title: 在弹出窗口中点击 "**添加时序**" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-12-pe.png,
        title: "**Key**" 填 "**sensor_temperature**"，"**Object ID**" 填 "**Analog Input**" 和 "**1**"。点击 "**添加时序**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-13-pe.png,
        title: "**Key**" 填 "**sensor_humidity**"，"**Object ID**" 填 "**Analog Input**" 和 "**2**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-14-pe.png,
        title: "**Key**" 填 "**controller_temperature**"，"**Object ID**" 填 "**Analog Input**" 和 "**9**"。点击 "**应用**"；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-15-pe.png,
        title: 点击 "**添加**" 按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-16-pe.png,
        title: 设备已添加。
'
%}

{% capture difference %}
别忘了在 docker compose 文件中暴露端口 **47808**。
同时，在设备的**高级配置**中，将设备 host 添加到 **Alternative responses address** 数组。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingGatewayPE %}
{% else %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingGatewayCE %}
{% endif %}
