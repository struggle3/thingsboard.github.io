
在本目录下为 **ThingsBoard Edge** 服务创建 docker compose 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

然后需在此文件中填写配置内容。
**Edge** 实例创建成功后，预设安装说明可供使用。
其中包含 **Edge Secret**、**Edge Key** 等重要凭证。要获取这些配置：

{% assign presetConfigPE = '
    ===
        image: /images/edge/user-guide/edge-install/4-install-instructions-pe.webp,
        title: 进入 **ThingsBoard Professional Edition** 实例的 **Edge management > Instances** 部分，点击 **Instance**。然后点击 **「Install & Connect Instructions」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/5-docker-pe.webp,
        title: 在 **「Install & Connect Instructions」** 弹出窗口中，选择 **「Docker」** 选项卡并 **复制配置内容**。
'
%}

{% assign presetConfigCE = '
    ===
        image: /images/edge/user-guide/edge-install/4-install-instructions.webp,
        title: 进入 **ThingsBoard Community Edition** 实例的 **Edge management > Instances** 部分，点击 **Instance**。然后点击 **「Install & Connect Instructions」** 按钮。
    ===
        image: /images/edge/user-guide/edge-install/5-docker.webp,
        title: 在 **「Install & Connect Instructions」** 弹出窗口中，选择 **「Docker」** 选项卡并 **复制配置内容**。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=presetConfigPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=presetConfigCE %}
{% endif %}


* 将复制的内容粘贴到 **docker-compose.yml** 文件中，按 **CTRL+S** 保存。按 **CTRL+X** 关闭文件。

* 执行以下命令：

```bash
docker compose up -d
docker compose logs -f mytbedge
```
{: .copy-code}

{% capture local-deployment %}
命令必须在保存 docker-compose.yml 的 **同一目录** 下执行。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}
