{% capture tb_3_0_upgrade_note %}
**升级至 ThingsBoard 3.0 前的重要提示**
 - ThingsBoard UI 已从 AngularJS 1.5.8 重写为 Angular 9。
   - 这意味着什么？
     - 概括而言，意味着：现代化应用、更易开发前端元素、性能提升以及 UI 定制更灵活。
   - 如何升级？
     - 若您不在仪表盘中使用自定义部件或自定义操作，可安全升级。
     - 新的 JS 框架可能不完全支持您当前的代码（自定义部件和自定义操作），需稍作重构。因此建议您使用我们的云环境或开发实例测试您的定制内容。
    
 - 从纯 Cassandra 迁移至混合数据库方案
    - 我们仍支持 Cassandra 存储遥测数据，但不再用于存储设备、客户、租户等实体。
    - 这意味着什么？
      - 这将简化维护和未来改进，并将在 v3.1 中支持高级搜索能力。
    - 如何升级？    
      - 若您使用纯 PostgreSQL 或 PostgreSQL（实体）+ Cassandra（遥测），则不受影响。
      - 若您使用纯 Cassandra，升级过程将自动执行但需一定时间。停机时间取决于设备、属性、告警和关系的数量。
        若上述实体少于 1000 万，升级通常仅需数分钟，具体取决于数据库性能。
      
{% endcapture %}
{% include templates/info-banner.md content=tb_3_0_upgrade_note %}
