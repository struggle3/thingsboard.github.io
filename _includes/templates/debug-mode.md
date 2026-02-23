<b><font size="3">调试模式</font></b>

启用调试模式可追踪与{{ feature }}执行相关的事件、状态及潜在错误，便于开发和排障。

{% capture difference %}
**注意：**调试模式可能迅速增加磁盘占用，因为所有调试事件都会存入数据库。
自**ThingsBoard 3.9**起，平台仅在{{ feature }}创建后的前**15分钟**内存储完整调试事件，之后仅保留错误事件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

调试模式设置可组合使用或完全关闭。