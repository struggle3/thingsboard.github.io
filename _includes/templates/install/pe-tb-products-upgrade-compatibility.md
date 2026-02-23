{% capture products_compatibility %}
**升级前兼容性检查**

若 ThingsBoard 与 Edge PE 或 Trendz Analytics 一同使用，请确认目标 ThingsBoard 版本与当前已安装组件的版本兼容。如不兼容，请先升级相关组件。

- **Edge PE：** [版本发布表](/docs/pe/edge/releases/releases-table/)  
- **Trendz Analytics：** [版本发布表](/docs/trendz/releases/releases-table/)

{% endcapture %}
{% include templates/warn-banner.md content=products_compatibility %}