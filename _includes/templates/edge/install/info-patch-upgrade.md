{% capture patch_restrictions %}
若从 **{{minorVersion}}** 升级，**必须**运行以下脚本。若从 **{{mainteneceVersion}}** 版本升级，
**请勿**运行升级脚本，直接启动Edge服务即可。
{% endcapture -%}

{% include templates/warn-banner.md content=patch_restrictions %}

{% if page.url contains 'centos' or page.url contains 'ubuntu' %}

升级 **ThingsBoard Edge** 服务：
```bash
sudo /usr/share/tb-edge/bin/install/upgrade.sh 
```
{: .copy-code}

{% elsif page.url contains 'windows' %}
升级 **ThingsBoard Edge** 服务：
```bash
C:\tb-edge>upgrade.bat 
```
{: .copy-code}
**注意：** 必须以管理员权限运行升级脚本。

{% elsif docsPrefix == "pe/edge/" and page.url contains 'docker' %}
升级 **ThingsBoard Edge** 服务：
```bash
docker compose run mytbedge upgrade-tb-edge-pe.sh
```
{: .copy-code}

{% elsif docsPrefix == "edge/" and page.url contains 'docker' %}
升级 **ThingsBoard Edge** 服务：
```bash
docker compose run mytbedge upgrade-tb-edge.sh
```
{: .copy-code}
{% endif %}