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
<br>
建议将 Trendz 加入 **ThingsBoard HAProxy 配置**，使 Trendz 可通过 **与 ThingsBoard 相同的域名**访问。
{% endcapture %}
{% include templates/warn-banner.md content=tb_haproxy_note %}

#### {{ platform }} 服务升级

{% include docs/trendz/install/docker-upgrade-steps.md version=current_version %}

#### 同步 Trendz 与 ThingsBoard

升级后需将 Trendz 与 ThingsBoard 同步。操作步骤见[此处](/docs/trendz/install/docker#step-6-sync-thingsboard-with-trendz)。

