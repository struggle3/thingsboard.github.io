{% capture debug_note %}
**Debug** 模式在开发与故障排查中非常有用，但在生产环境中保持启用会显著增加数据库存储需求，因为所有调试数据均会存入数据库。

强烈建议在调试完成后 **禁用 Debug 模式**。
{% endcapture %}
{% include templates/info-banner.md content=debug_note %}
