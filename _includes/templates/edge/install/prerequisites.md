{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "Professional Edition" %}
{% else %}
{% assign appPrefix = "Community Edition" %}
{% endif %}

## 前置条件

要运行 **ThingsBoard {{appPrefix}} Edge**，需具备支持 **Edge** 功能的活跃 **ThingsBoard {{appPrefix}} 账号**。

{% if docsPrefix == 'pe/edge/' %}
{% include templates/edge/obtain-pe-cloud.md %}
{% else %}
{% include templates/edge/obtain-ce-cloud.md %}
{% endif %}

{% include templates/edge/install/hardware-requirements.md %}

### 部署新 Edge 实例

要创建新的 **Edge**：

{% if docsPrefix == 'pe/edge/' %}
{% assign addEdge = '
    ===
        image: /images/pe/edge/installation-add-edge-item-1.png,
        title: 登录 **ThingsBoard PE** 实例，进入 **Edge Management > Instances** 区域。点击右上角 **"+"** 图标并选择 **"Add new edge"**。
    ===
        image: /images/pe/edge/installation-add-edge-item-2.png,
        title: 输入要创建的 Edge 名称，如 "My New Edge"。**如需要**，更新 **cloud endpoint**。 
* 若 **Edge** 运行在 [Docker 容器](https://docs.docker.com/get-started/docker-overview/){:target="_blank"}中，**不要**使用 "localhost" 作为endpoint，应使用 **ThingsBoard PE** 所在且 Edge 容器可访问的机器 **IP 地址**，如 http://10.7.2.143:8080。
* 若使用 **ThingsBoard Cloud**，则无需修改此设置。
* 点击 **"Add"** 按钮以确认添加 **Edge instance**。 

    ===
        image: /images/pe/edge/installation-add-edge-item-3.png,
        title: 新 **Edge** 已创建，将出现在列表顶部（默认按创建时间排序）。
'%}
{% else %}
{% assign addEdge = '
    ===
        image: /images/edge/installation-add-edge-item-1.png,
        title: 登录 **ThingsBoard CE** 实例，进入 **Edge Management > Instances** 区域。点击右上角 **"+"** 图标并选择 **"Add new edge"**。
    ===
        image: /images/edge/installation-add-edge-item-2.png,
        title: 输入要创建的 Edge 名称，如 "My New Edge"。点击 **"Add"** 按钮以确认添加 **Edge instance**。
    ===
        image: /images/edge/installation-add-edge-item-3.png,
        title: 新 **Edge** 已创建，将出现在列表顶部（默认按创建时间排序）。
'%}
{% endif %}

{% include images-gallery.liquid imageCollection=addEdge showListImageTitles="true" %}