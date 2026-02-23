TBMQ v2.1.0 引入多项改进，包括新的 Integration Executor 微服务及第三方服务版本升级。

#### 添加 Integration Executor 微服务

本版本通过新的 [Integration Executor](/docs/{{docsPrefix}}mqtt-broker/integrations/) 微服务支持外部集成。

要获取包括 Integration Executor 在内的最新配置文件，请从release分支拉取更新。
按照 [运行升级说明](#run-upgrade) 中的步骤操作，直至执行升级脚本前（暂不执行 **.sh** 命令）。

#### 更新第三方服务

{% include templates/mqtt-broker/upgrade/upgrade-third-parties-for-2.1.0-release-cluster.md %}
