{%- assign platform = "ThingsBoard CE" -%}
{%- assign current_version = include.version -%}
{%- assign family = include.family -%}
{%- assign current_version_with_platform = current_version -%}
{%- assign previous_version = include.prev_version -%}
{%- assign update_status = include.update_status | default: "true" -%}
{%- assign applicable_versions = include.applicable_versions -%}
{%- assign manual_version_upgrade = include.manual_version_upgrade | default: "false" -%}
{%- assign manual_version_upgrade_label = include.manual_version_upgrade_label -%}
{%- assign patch_status = include.patch_status -%}
{%- assign base_version = include.base_version -%}
{%- assign x_status = include.x -%}

{% if docsPrefix == "pe/" %}
{%- assign platform = "ThingsBoard PE" -%}
{%- assign current_version_with_platform = current_version | append: "pe" -%}
{% endif %}

{%- assign curr_parts = current_version | split: "." -%}
{%- assign prev_parts = previous_version | split: "." -%}

{%- assign curr_major = curr_parts[0] -%}
{%- assign curr_minor = curr_parts[1] -%}

{%- assign curr_major_n = curr_major | plus: 0 -%}
{%- assign curr_minor_n = curr_minor | plus: 0 -%}

{%- assign prev_major = prev_parts[0] -%}
{%- assign prev_minor = prev_parts[1] -%}

{%- assign previous_version_anchor = previous_version | replace: ".", "" -%}

{%- assign previous_version_path = prev_major | append: "-" | append: prev_minor | append: "-x" -%}

{%- assign use_external_link = false -%}
{%- if curr_major != prev_major or curr_minor != prev_minor -%}
{%- assign use_external_link = true -%}
{%- endif -%}

{%- assign prev_parts = previous_version | split: "." (-%}
{%- assign prev_major = prev_parts[0] -%}
{%- assign prev_minor = prev_parts[1] -%}

{% if patch_status == "true" %}
### 将 {{ platform }} 升级到最新 {{ base_version }}（{{ current_version }}）
{% else %}
### 将 {{ platform }} 升级到 {{ current_version }}
{% endif %}

{%- if x_status == "true" -%}
{%- assign prev_version_label = prev_major | append: "." | append: prev_minor | append: ".x" -%}
{%- else -%}
{%- assign prev_version_label = previous_version -%}
{%- endif -%}

{% if docsPrefix == "pe/" %}
{%- assign prev_version_label = prev_version_label | append: "PE" -%}
{% endif %}

{% assign platform_hash = "#upgrading-thingsboard-ce-to-" %}
{% if docsPrefix == "pe/" %}
{%- assign platform_hash = "#upgrading-thingsboard-pe-to-" -%}
{% endif %}

{%- if use_external_link -%}
{%- assign prev_version_href = "/docs/" | append: docsPrefix | append: "user-guide/install/upgrade-instructions/centos/v" | append: previous_version_path | append: "/" | append: platform_hash | append: previous_version_anchor -%}
{%- else -%}
{%- assign prev_version_href = platform_hash | append: previous_version_anchor -%}
{%- endif -%}

{% capture difference %}
**注意：**
{% if curr_major > "4" or (curr_major == "4" and curr_minor >= "2") %}
本升级步骤适用于 ThingsBoard 版本 {{ prev_version }}{% if patch_status == "true" %} 或任意 {{ base_version }} 补丁{% endif %}。
要升级到 {{ current_version_with_platform | upcase }}，需先[**升级到 {{ prev_version }}**]({{ prev_version_href }})。
{% else %}
本升级步骤适用于 ThingsBoard 版本 {{ prev_version_label }}{% if applicable_versions %}{% assign versions = applicable_versions | split: "," %}{% for v in versions %} 和 ThingsBoard 版本 {{ v | strip }}{% endfor %}{% endif %}。
要升级到 {{ current_version_with_platform | upcase }}，需先[**升级到 {{ prev_version_label }}**]({{ prev_version_href }})。
{% endif %}
{%- if docsPrefix == "pe/" -%}
<br>
升级 ThingsBoard 前请先[**准备**](#prepare-for-upgrading-thingsboard)。
{%- endif -%}
{% endcapture %}

{% if curr_major > "4" or (curr_major == "4" and curr_minor >= "2") %}
{% if patch_status == "true" %}
{% include templates/info-banner.md content=difference %}
{% endif %}
{% else %}
{% include templates/info-banner.md content=difference %}
{% endif %}

{%- if curr_major_n > 4 -%}
  {%- if docsPrefix == "pe/" -%}
    {% include templates/install/pe-tb-products-upgrade-compatibility.md %}
  {%- else -%}
    {% include templates/install/tb-products-upgrade-compatibility.md %}
  {%- endif -%}
{%- elsif curr_major_n == 4 and curr_minor_n >= 3 -%}
  {%- if docsPrefix == "pe/" -%}
    {% include templates/install/pe-tb-products-upgrade-compatibility.md %}
  {%- else -%}
    {% include templates/install/tb-products-upgrade-compatibility.md %}
  {%- endif -%}
{%- endif -%}

{% if current_version == "3.8" and docsPrefix != "pe/" %}
#### 安装 PostgreSQL contrib 包（仅 CentOS）

```bash
sudo dnf install -y postgresql16-contrib
```
{: .copy-code}
{% endif %}
{% if current_version == "3.7" %}
{% include templates/install/tb-370-update-linux.md %}
{% endif %}
{% if current_version == "3.5" %}
{% include templates/install/tb-350-update.md %}
{% endif %}

#### 下载 ThingsBoard{% if docsPrefix == "pe/" %} PE{% endif %} 安装包

{% if docsPrefix == "pe/" %}
```bash
wget https://dist.thingsboard.io/thingsboard-{{ current_version_with_platform }}.rpm
```
{: .copy-code}
{% else %}
```bash
wget https://github.com/thingsboard/thingsboard/releases/download/v{{ current_version_with_platform }}/thingsboard-{{ current_version_with_platform }}.rpm
```
{: .copy-code}
{% endif %}

#### ThingsBoard{% if docsPrefix == "pe/" %} PE{% endif %} 服务升级

* 若 ThingsBoard 服务正在运行，请先停止。

```bash
sudo service thingsboard stop
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
* 按[此处](/docs/user-guide/install/pe/rhel/#step-9-install-thingsboard-webreport-component)所述安装 ThingsBoard Web Report 组件。
{% endif %}

```bash
sudo rpm -Uvh thingsboard-{{ current_version_with_platform }}.rpm
```
{: .copy-code}

{% capture difference %}
**注意：**
<br>
安装包可能会提示合并 ThingsBoard 配置。建议选择合并选项，以确保先前参数不会被覆盖。
{% endcapture %}

{% capture update_note %}
{% assign base_version_parts = base_version | split: "." %}
{% assign patch_part = base_version_parts[2] %}
{% if patch_status == "true" %}
若从 {{ previous_version }} 升级，则**必须**运行下方脚本。若从 {{ family | append: "." | append: patch_part | append: ".x" }} 版本升级，则**不要**运行升级脚本，直接启动服务即可。
{% else %}
若从 {{ previous_version }} 版本升级，必须运行下方脚本
{% endif %}
{% endcapture %}

{% capture update_script %}

```bash
sudo /usr/share/thingsboard/bin/install/upgrade.sh{% if manual_version_upgrade == "true" %} --fromVersion={% if manual_version_upgrade_label %}{{ manual_version_upgrade_label }}{% else %}{{ previous_version }}{% endif %}{% endif %}
```
{: .copy-code}
{% endcapture %}

{% if curr_major > "4" or (curr_major == "4" and curr_minor >= "2") %}
{% include templates/warn-banner.md content=update_note %}
{{ update_script }}
{% elsif update_status == "true" %}
{{ update_script }}
{% endif %}

#### 启动服务
{% if current_version == "3.7" %}
{% capture cassandra-370 %}
**若已安装 Cassandra**，请确保为 *cassandra.in.sh* 包含文件设置正确的 **JAVA_HOME** 参数。截至 3.7.0 版本，最新稳定版 Cassandra 尚不支持 Java 17。

如需操作，可参考 [**Cassandra 安装指南**](/docs/user-guide/install/rhel/?rhelThingsboardDatabase=hybrid#cassandra-installation) 中的 *"you will need to install Java..."* 部分。
{% endcapture %}
{% include templates/info-banner.md content=cassandra-370 %}
{% endif %}

```bash
sudo service thingsboard start
```
{: .copy-code}

{% if current_version == "3.4.2" %}
{% capture default-jwt %}
若在生产环境中使用默认 JWT 签名密钥 "thingsboardDefaultSigningKey"，请更新。详见 [JWT 安全设置](/docs/user-guide/ui/security-settings/#jwt-security-settings)。
{% endcapture %}
{% include templates/info-banner.md content=default-jwt %}
{% endif %}
