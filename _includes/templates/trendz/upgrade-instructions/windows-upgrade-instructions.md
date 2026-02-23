{%- assign platform = "Trendz Analytics" -%}
{%- assign current_version = include.version -%}
{%- assign family = include.family -%}
{%- assign patch_status = include.patch_status -%}
{%- assign base_version = include.base_version -%}

{%- assign curr_parts = current_version | split: "." -%}

{%- assign curr_major = curr_parts[0] -%}
{%- assign curr_minor = curr_parts[1] -%}

{%- assign curr_major_n = curr_major | plus: 0 -%}
{%- assign curr_minor_n = curr_minor | plus: 0 -%}

{% if patch_status == "true" %}
### Upgrading {{ platform }} to latest {{ base_version }} ({{ current_version }})
{% else %}
### Upgrading {{ platform }} to {{ current_version }}
{% endif %}

{%- assign platform_hash = "#upgrading-trendz-analytics-to-" -%}

{% capture tb_haproxy_note %}
**注意：**
<br>
若 Trendz 部署在 **HAProxy** 之后，请确保将 **`/trendz/`** 和 **`/apiTrendz/`** 路径路由到 Trendz 后端，而非 **`/trendz`** 和 **`/apiTrendz`**。
此外，建议将 Trendz 加入 **ThingsBoard HAProxy 配置**，使 Trendz 可通过 **与 ThingsBoard 相同的域名**访问。
{% endcapture %}
{% include templates/warn-banner.md content=tb_haproxy_note %}

#### 下载 Trendz Analytics 安装包

下载适用于 Windows 的 Trendz Analytics 安装包：[trendz-windows-{{ current_version }}.zip](https://dist.thingsboard.io/trendz-windows-{{ current_version }}.zip)。

#### 升级 Trendz Analytics 服务

* 若 Trendz 服务正在运行，请先停止。

```text
net stop trendz
```
{: .copy-code}

* 备份原有 Trendz Analytics 配置（位于 \<Trendz install dir\>\conf，如 C:\trendz\conf）。
* 删除 ThingsBoard 安装目录。
* 将安装包解压到 ThingsBoard 安装目录。
* 将备份的旧 Trendz 配置文件与新版本对比。

{% assign base_version_parts = base_version | split: "." %}
{% assign patch_part = base_version_parts[2] %}
{% if patch_status == "true" %}
{% capture update_note %}
**注意：**
若从 {{ family | append: "." | append: patch_part | append: ".x" }} 版本升级，**请勿**运行升级脚本，直接启动服务即可。
{% endcapture %}
{% include templates/info-banner.md content=update_note %}
{% endif %}

* 最后运行 **upgrade.bat** 脚本将 Trendz 升级到新版本。

**注意** 以上脚本需以管理员权限执行。 

```text
C:\trendz>upgrade.bat
```
{: .copy-code}

#### 启动服务

```text
net start trendz
```
{: .copy-code}

#### 同步 Trendz 与 ThingsBoard

升级后需将 Trendz 与 ThingsBoard 同步。操作步骤见[此处](/docs/trendz/install/windows#step-6-sync-thingsboard-with-trendz)。