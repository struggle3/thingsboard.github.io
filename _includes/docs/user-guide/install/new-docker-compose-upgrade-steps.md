{% assign current_version = include.version %}
{% assign previous_version = include.previous_version %}

{% capture update_note %}
{% assign base_version_parts = base_version | split: "." %}
{% assign patch_part = base_version_parts[2] %}
{% if patch_status == "true" %}
若从{{ previous_version }}升级，**必须**执行下方脚本。但若从{{ family | append: "." | append: patch_part | append: ".x" }}版本升级，**请勿**执行升级脚本，直接启动服务即可。
{% else %}
若从{{ previous_version }}版本升级，必须执行下方脚本
{% endif %}
{% endcapture %}

1. 修改`.env`文件中的`TB_VERSION`参数。

```.env
TB_VERSION={{ current_version }}
```

2. 执行以下命令：
    
```bash
./docker-stop-services.sh  
```
{: .copy-code}  

{% include templates/warn-banner.md content=update_note %}

```bash
./docker-upgrade-tb.sh
```
{: .copy-code}  

```bash
./docker-start-services.sh
```
{: .copy-code}