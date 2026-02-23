{%- assign platform = "ThingsBoard CE" -%}
{%- assign current_version = include.version -%}
{%- assign family = include.family -%}
{%- assign current_version_with_platform = current_version -%}
{%- assign previous_version = include.prev_version -%}
{%- assign update_status = include.update_status | default: "true" -%}
{%- assign applicable_versions = include.applicable_versions -%}
{%- assign manual_version_upgrade = include.manual_version_upgrade | default: "false" -%}
{%- assign manual_version_upgrade_label = include.manual_version_upgrade_label -%}
{%- assign zip = include.zip | default: "false" -%}
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
{%- assign prev_version_href = "/docs/" | append: docsPrefix | append: "user-guide/install/upgrade-instructions/windows/v" | append: previous_version_path | append: "/" | append: platform_hash | append: previous_version_anchor -%}
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

{% if current_version == "3.7" %}
{% include templates/install/tb-370-update-windows.md %}
{% endif %}
{% if current_version == "3.5" %}
{% include templates/install/tb-350-update.md %}
{% endif %}

#### 下载 ThingsBoard{% if docsPrefix == "pe/" %} PE{% endif %} 安装包

{% assign upgrade_package = "" %}
{% if docsPrefix == "pe/" %}
{% assign upgrade_package = "thingsboard-windows-" %}
{% if zip == "true" %}
{% assign upgrade_package = upgrade_package | append: current_version | append: "pe.zip" %}
{% else %}
{% assign upgrade_package = upgrade_package | append: "setup-" | append: current_version | append: "pe.exe" %}
{% endif %}
下载 Windows 版 ThingsBoard PE 安装包：[{{ upgrade_package }}](https://dist.thingsboard.io/{{ upgrade_package }})。
{% else %}
下载 Windows 版 ThingsBoard 安装文件：[thingsboard-windows-{{ current_version }}.zip](https://github.com/thingsboard/thingsboard/releases/download/v{{ current_version }}/thingsboard-windows-{{ current_version }}.zip)。
{% endif %}

#### ThingsBoard{% if docsPrefix == "pe/" %} PE{% endif %} 服务升级

* 若 ThingsBoard 服务正在运行，请先停止。

```text
net stop thingsboard
```
{: .copy-code}

* 备份位于 \<ThingsBoard 安装目录\>\conf 的先前 ThingsBoard{% if docsPrefix == "pe/"%} PE{% endif %} 配置（例如 C:\thingsboard\conf）。
{% if docsPrefix == "pe/" %}
{% if zip == "true" %}
* 将 **{{ upgrade_package }}** 的内容复制到同一位置。
{% else %}
* 运行安装包 **{{ upgrade_package }}**
{% endif %}
{% endif %}
{% if docsPrefix != "pe/" %}
* 删除 ThingsBoard 安装目录。
* 将安装压缩包解压到 ThingsBoard 安装目录。
{% endif %}
* 将第一步备份的旧 ThingsBoard 配置文件与新配置进行比较和合并。


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
执行常规升级脚本：

```text
C:\thingsboard>upgrade.bat{% if manual_version_upgrade == "true" %} --fromVersion={% if manual_version_upgrade_label %}{{ manual_version_upgrade_label }}{% else %}{{ previous_version }}{% endif %}{% endif %}
```
{: .copy-code}
{% endcapture %}

{% if curr_major > "4" or (curr_major == "4" and curr_minor >= "2") %}
{% include templates/warn-banner.md content=update_note %}
{{ update_script }}
{% else %}

{% if update_status == "true" %}
{% capture difference %}
**注意：**
<br>
上述脚本应以管理员身份执行。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
{% endif %}

{% if update_status == "true" %}
{{ update_script }}
{% endif %}

{% endif %}

#### 启动服务
```text
net start thingsboard
```
{: .copy-code}

{% if current_version == "3.4.2" %}
{% capture default-jwt %}
若在生产环境中使用默认 JWT 签名密钥 "thingsboardDefaultSigningKey"，请更新。详见 [JWT 安全设置](/docs/user-guide/ui/security-settings/#jwt-security-settings)。
{% endcapture %}
{% include templates/info-banner.md content=default-jwt %}
{% endif %}
