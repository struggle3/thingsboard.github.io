* TOC
{:toc}

{% assign sinceVersion = "3.4" %}
{% include templates/since.md %}

ThingsBoard 版本控制服务支持通过 Git 导出和恢复 ThingsBoard 实体。
租户管理员可通过 UI 或 REST API 配置 Git 仓库访问。
平台用户可导出单个或多个 ThingsBoard 实体、浏览版本历史，并将实体恢复至指定版本。

该功能适用于多名工程师共同设计同一 Rule Chain 或 Dashboard 的场景，可提升体验并简化 CI/CD。
也可在租户或平台实例之间便捷克隆方案。

## 架构

### Entity External ID（实体外部 ID）

每个 ThingsBoard 实体均有「id」字段，为该实体在特定 ThingsBoard 环境内的唯一标识。
每个可导出的 ThingsBoard 实体还包含「externalId」字段。
该字段用于在多个环境之间导入/导出时识别同一实体。
「id」与「externalId」均为 [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) 类型。

「externalId」还用于在 Rule Chain（rule nodes）和仪表板（aliases、widget actions）中自动替换实体 id。
因此，若导入引用了设备或资产的 Rule Chain，请确保已导出/导入对应的设备或资产。

### 可导出实体与设置（Exportable Entities and settings）

{% if docsPrefix == 'ce/' %}
本功能初始版本支持以下实体：Device、Asset、Entity View、Customer、Dashboard、Widget Bundle、Rule Chain。
{% else %}
本功能初始版本支持以下实体：Device、Asset、Entity View、Customer、Dashboard、Widget Bundle、Rule Chain、Entity group、Role、Converter 和 Integration。
{% endif %}

我们刻意不提供 User 实体的导出，因用户邮箱在平台实例内唯一，将用户邮箱和凭据导出到 Git 不妥。

导出实体时，会在 Git 中存储实体的 JSON 表示。也可导出实体属性、关系和凭据（仅设备）。

### 仓库结构（Repository structure）

首次将实体导出到 Git 时，使用实体「id」作为仓库内文件名。
从 Git 导入到 ThingsBoard 时，文件名中的「id」将成为实体的「externalId」。
「externalId」在租户范围内唯一，因此可在同一平台的不同租户或不同实例之间导入/导出实体。
每次执行导出和导入时，均通过「externalId」定位要更新的实体。
示例见下。

假设有开发环境 ThingsBoard 实例，导出了名为「Dashboard 1」、id 为「4864b750-da7d-11ec-a496-97fa2815d2fe」的仪表板。
则仓库中将存在如下路径的文件：

```bash
dashboard/4864b750-da7d-11ec-a496-97fa2815d2fe.json
```

假设将该仪表板「D1」导入生产 ThingsBoard 实例。首次将实体导入新的 ThingsBoard 实例时会设置「externalId」。
此时，生产环境中的仪表板实体 id 不同，但其「externalId」仍为「4864b750-da7d-11ec-a496-97fa2815d2fe」。

{% if docsPrefix != 'ce/' %}
客户层级存储在递归的 'hierarchy' 文件夹中，与 UI 中「Customer hierarchy」页面类似。
实体组存储在 'groups' 文件夹。每个组有 'id.json'（存储组实体）和 'id_entities.json'（存储组内实体 id 列表）。
保留组 'All' 不包含 'id_entities.json'，因 'All' 组包含全部实体。
{% endif %}

{% include images-gallery.html imageCollection="gitRepoStructure" %}

### 同步策略（Sync strategy）

平台支持两种 Git 导出同步策略：Merge 和 Overwrite。  
「Merge」为默认策略，仅将所选实体追加到仓库，适合保存一个或多个文件且不删除仓库中的其他文件。
「Overwrite」策略会完全重写对应仓库文件，适合将实例中的实体列表（如 Dashboards）与 Git 仓库完全同步。
此前已保存到 Git 但当前不在平台实例中的实体，将在对应 commit 中从 Git 仓库删除。

### 可扩展性（Scalability）

ThingsBoard 版本控制服务可作为单体实例的一部分，或作为独立微服务以实现水平扩展。
版本控制服务的每个实例负责处理集群中特定租户分区的同步任务。
每次「commit」API 调用可能耗时。不支持同一租户范围内的并发「commit」API 调用。
若已有「commit」在进行中，新到达的「commit」API 调用将被系统取消。

## 使用

### Git 设置配置（Git Settings configuration）

租户管理员可进入「Advanced features」区域的「Version control」页面。该页面可配置 Git 仓库 URL、默认分支名和认证设置。
请提供空 Git 仓库的 URL。

{% include images-gallery.html imageCollection="gitConfiguration" %}

### 导出到 Git（Export to Git）

#### 单个实体导出（Single Entity Export）

进入实体详情并打开「Version control」选项卡。  
Rule Chain 和 Dashboard 在编辑器中内置版本控制按钮和弹窗部件。
参见下方截图。

**Device（设备）：**

{% include images-gallery.html imageCollection="singleEntityExportDevice" %}

**Rule Chain（规则链）：**

{% include images-gallery.html imageCollection="singleEntityExportRuleChain" %}

**Dashboard（仪表板）：**

{% include images-gallery.html imageCollection="singleEntityExportDashboard" %}

#### 批量实体导出（Multiple Entity Export）

进入版本控制页面。可选择要恢复的一种或多种实体类型。默认选中全部实体类型。

{% include images-gallery.html imageCollection="multipleEntityExport" %}

#### Auto-commit

Auto-commit 可在通过 UI 或 REST API 保存实体时，自动提交 Dashboard 和 Rule Chain。  
Auto-commit 异步执行以提升 UI 体验。  
将实体分配给客户（更改实体 owner）时不会触发 auto-commit。  
此类情况下，应使用 overwrite 策略提交该实体类型的全部实体。

{% include images-gallery.html imageCollection="autoCommitConfiguration" %}

### 从 Git 恢复（Restore from Git）

进入版本控制页面。选择 commit 并指定恢复设置。

{% include images-gallery.html imageCollection="gitRestore" %}

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}