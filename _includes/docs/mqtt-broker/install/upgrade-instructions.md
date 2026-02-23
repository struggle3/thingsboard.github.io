
* TOC
{:toc}

{% if (docsPrefix == "pe/") %}

  <div class="installation-options">
      <div class="install-options-header">
         <div class="install-options-hero">
            <div class="container">
              <div class="install-options-hero-content">
                  <h1>TBMQ Professional Edition 升级选项</h1>
              </div>
              <div class="deployment-container one-line-deployment-container">
                  <div class="deployment-div">
                      {% include installation-options-cards.liquid installationOptions="installation-options-pe-mqtt-broker-upgrade-instructions" active=true %}
                  </div>
              </div>
            </div>
         </div>
      </div>
  </div>

{% else %}

  <div class="installation-options">
      <div class="install-options-header">
         <div class="install-options-hero">
            <div class="container">
              <div class="install-options-hero-content">
                  <h1>TBMQ 升级选项</h1>
              </div>
              <div class="deployment-container one-line-deployment-container">
                  <div class="deployment-div">
                      {% include installation-options-cards.liquid installationOptions="installation-options-mqtt-broker-upgrade-instructions" active=true %}
                  </div>
              </div>
            </div>
         </div>
      </div>
  </div>

{% endif %}

{% if docsPrefix == "pe/" %}

### 从 TBMQ CE 升级至 TBMQ PE（v2.2.0）

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 2.2.0 TBMQ CE version. In order to upgrade to TBMQ PE 2.2.0 you need to [upgrade to 2.2.0 TBMQ CE first](/docs/mqtt-broker/install/upgrade-instructions/#upgrading-to-220).
**Notice the Bitnami Images information.**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 说明：TBMQ PE v2.2.0 中的第三方组件更新

We’d like to inform you about several **third-party component updates** introduced in **TBMQ Professional Edition (PE) v2.2.0** compared to the Community Edition (CE).
这些更改提升了性能与稳定性，并使 TBMQ 与官方支持的开源技术保持一致。

更新遵循此处所述的现代化规划：
[Bitnami Image Migration](https://github.com/thingsboard/thingsboard-ce-k8s/blob/master/BITNAMI-IMAGE-MIGRATION.md#3-long-term-production-solution).

#### 变更说明

| Component          | TBMQ CE v2.2.0              | TBMQ PE v2.2.0       | 变更说明与原因                                                                                                                                                                                                                                                      |
| ------------------ | --------------------------- | -------------------- |-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **PostgreSQL**     | `postgres:16`               | `postgres:17`        | 升级至更新主版本，提升性能、可靠性与资源效率。现有数据卷保持完全兼容。                                                                                                                |
| **Kafka**          | `bitnamilegacy/kafka:3.7.0` | `apache/kafka:4.0.0` | 根据从 Bitnami 迁移至官方开源镜像的计划更新。引入新卷并映射至 Apache Kafka 镜像所需路径。                                                                           |
| **Redis → Valkey** | `bitnamilegacy/redis:7.2.5` | `valkey/valkey:8.0`  | 根据从 Bitnami 迁移至开源镜像的计划更新。Redis 由 Valkey（Redis 7 的社区驱动分支）替代。引入新卷 `tbmq-valkey-data` 并映射至 Valkey 镜像使用的数据目录。 |

#### 重要说明

从 TBMQ CE 2.2.0 升级至 TBMQ PE 2.2.0 会引入多项组件变更，迁移前后需注意。

开始升级前，**强烈建议对现有环境进行完整备份**。
包括 **PostgreSQL 数据库**（例如使用 `pg_dump`），以及计划迁移的 **Kafka** 和 **Redis** 数据卷。
备份可确保在升级过程中出现配置或兼容性问题时安全恢复环境。

PostgreSQL 版本从 **16 升级至 17**，提升性能、可靠性与资源效率。
虽然现有数据卷保持兼容，但仍需执行正确的数据库版本升级（例如使用 `pg_upgrade`），以确保数据完整性与新版本的完全兼容。

Kafka 和 Redis 已从 Bitnami 镜像迁移至官方开源镜像——分别为 **Apache Kafka** 和 **Valkey**。
该迁移是远离 Bitnami 镜像的长期现代化规划的一部分。
伴随此次变更，**Kafka 从 3.7.0 升级至 4.0.0**，提升性能、扩展性与消息处理效率。
新镜像使用**不同的内部数据目录和卷映射**，因此无法直接复用现有 Bitnami 卷。
您需要**手动迁移 Kafka 和 Redis 数据**，或**从新的空卷开始**。
> **⚠️ 注意**：使用新卷将清除 Kafka 和 Redis 中当前存储的所有数据，包括客户端会话状态、未送达与保留消息及其他持久化代理数据。

标准升级脚本仅负责更新 PostgreSQL 数据库模式，不包含 Kafka 或 Valkey 的数据迁移逻辑。

{% capture difference %}
**NOTE:** You may [contact us](/docs/pe/mqtt-broker/help/) if you require additional guidance for the migration. While we do not provide direct or fully managed migration assistance, we can offer general recommendations and insights to help facilitate a smoother upgrade experience.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

---

请通过页面顶部的[选择卡片](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)进入相应文档以继续升级步骤。

{% else %}

{% if docsPrefix != 'pe/' %}
{% capture difference %}
关注 **TBMQ Professional Edition**？可将 TBMQ CE 升级至 [TBMQ PE](/docs/pe/mqtt-broker/install/upgrade-instructions/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
{% endif %}

### 升级至 2.2.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 2.1.0 TBMQ version. In order to upgrade to 2.2.0 you need to [upgrade to 2.1.0 first](#upgrading-to-210).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 关于 TBMQ 部署中的 Bitnami 镜像

在 TBMQ 部署中，我们使用 **Bitnami 镜像**作为 PostgreSQL、Redis 和 Kafka 等第三方组件。 
The Bitnami team [**has announced important upcoming changes**](https://github.com/bitnami/charts/issues/35164) to their catalog that affect these images.

**What’s happening:**

* Starting **August 28, 2025**, the public `docker.io/bitnami` registry will only provide a small set of “latest” hardened images for development use.
* All versioned images will be moved to a temporary legacy registry: `docker.io/bitnamilegacy`. These images will remain available but will not receive updates or security patches.
* The long-term, supported solution is Bitnami’s new Secure Images (subscription-based).

**Temporary solution:**
To avoid disruption in your TBMQ deployments, please update your image references from `docker.io/bitnami/...` to `docker.io/bitnamilegacy/...`.
This ensures that your clusters continue to work after August 28, 2025.

**Next steps:**
We are currently evaluating a **long-term strategy** for TBMQ third-party images. We’ll share the details once the new approach is finalized.

---

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### 升级至 2.1.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 2.0.0 and 2.0.1 TBMQ versions.
In order to upgrade to 2.1.0, your current version should be greater or equal to 2.0.0 version.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 拉取 TBMQ 镜像（可选）

根据当前安装方式拉取 2.1.0 版 TBMQ 镜像。

{% capture tabspec %}tbmq-pull-2-1-0
tbmq-pull-2-1-0-single,Single node,shell,resources/2.1.0/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/2.1.0/tbmq-single-node-pull.sh
tbmq-pull-2-1-0-cluster,Cluster mode,shell,resources/2.1.0/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/2.1.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### 起始版本（2.1.0 起自动检测）

自 2.1.0 起，升级脚本已移除 _fromVersion_ 参数，不再支持。
2.1.0 起，升级脚本会自动检测当前安装版本，并根据预定义的支持版本列表判断是否可继续升级。

请通过页面顶部的[选择卡片](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)进入相应文档以继续升级步骤。

### 升级至 2.0.1

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 2.0.0 TBMQ version. In order to upgrade to 2.0.1 you need to [upgrade to 2.0.0 first](#upgrading-to-200).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Pull TBMQ image (Optional)

Pull 2.0.1 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-2-0-1
tbmq-pull-2-0-1-single,Single node,shell,resources/2.0.1/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/2.0.1/tbmq-single-node-pull.sh
tbmq-pull-2-0-1-cluster,Cluster mode,shell,resources/2.0.1/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/2.0.1/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ should be set to **2.0.0**.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### Upgrading to 2.0.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 1.4.0 TBMQ version. In order to upgrade to 2.0.0 you need to [upgrade to 1.4.0 first](#upgrading-to-140).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

This release of TBMQ introduces significant improvements, including key new features and a migration from PostgreSQL to Redis for storing messages for persistent DEVICE clients. 
For more details, refer to the [architecture documentation](/docs/{{docsPrefix}}mqtt-broker/architecture/).

Before upgrading, it is strongly recommended to back up your PostgreSQL database to ensure data safety. 
Follow the steps by selecting an appropriate guide from [one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/) on top of the page.

#### Pull TBMQ image (Optional)

Pull 2.0.0 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-2-0-0
tbmq-pull-2-0-0-single,Single node,shell,resources/2.0.0/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/2.0.0/tbmq-single-node-pull.sh
tbmq-pull-2-0-0-cluster,Cluster mode,shell,resources/2.0.0/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/2.0.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ should be set to **1.4.0**.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### Upgrading to 1.4.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 1.3.0 TBMQ version. In order to upgrade to 1.4.0 you need to [upgrade to 1.3.0 first](#upgrading-to-130).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Pull TBMQ image (Optional)

Pull 1.4.0 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-1-4-0
tbmq-pull-1-4-0-single,Single node,shell,resources/1.4.0/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.4.0/tbmq-single-node-pull.sh
tbmq-pull-1-4-0-cluster,Cluster mode,shell,resources/1.4.0/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.4.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ should be set to **1.3.0**.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### Upgrading to 1.3.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 1.2.1 TBMQ version. In order to upgrade to 1.3.0 you need to [upgrade to 1.2.1 first](#upgrading-to-121).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Pull TBMQ image (Optional)

Pull 1.3.0 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-1-3-0
tbmq-pull-1-3-0-single,Single node,shell,resources/1.3.0/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.3.0/tbmq-single-node-pull.sh
tbmq-pull-1-3-0-cluster,Cluster mode,shell,resources/1.3.0/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.3.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ should be set to **1.2.1**.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### Upgrading to 1.2.1

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 1.2.0 TBMQ version. In order to upgrade to 1.2.1 you need to [upgrade to 1.2.0 first](#upgrading-to-120).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Pull TBMQ image (Optional)

Pull 1.2.1 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-1-2-1
tbmq-pull-1-2-1-single,Single node,shell,resources/1.2.1/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.2.1/tbmq-single-node-pull.sh
tbmq-pull-1-2-1-cluster,Cluster mode,shell,resources/1.2.1/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.2.1/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ should be set to **1.2.0**.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### Upgrading to 1.2.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 1.1.0 TBMQ version. In order to upgrade to 1.2.0 you need to [upgrade to 1.1.0 first](#upgrading-to-110).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Pull TBMQ image (Optional)

Pull 1.2.0 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-1-2-0
tbmq-pull-1-2-0-single,Single node,shell,resources/1.2.0/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.2.0/tbmq-single-node-pull.sh
tbmq-pull-1-2-0-cluster,Cluster mode,shell,resources/1.2.0/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.2.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ should be set to **1.1.0**.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

### Upgrading to 1.1.0

{% capture difference %}
**NOTE**:
<br>
These steps are applicable for 1.0.0, and 1.0.1 TBMQ versions.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Pull TBMQ image (Optional)

Pull 1.1.0 version TBMQ image depending on your current installation.

{% capture tabspec %}tbmq-pull-1-1-0
tbmq-pull-1-1-0-single,Single node,shell,resources/1.1.0/tbmq-single-node-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.1.0/tbmq-single-node-pull.sh
tbmq-pull-1-1-0-cluster,Cluster mode,shell,resources/1.1.0/tbmq-cluster-mode-pull.sh,/docs/{{docsPrefix}}mqtt-broker/install/resources/1.1.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### From version

The _fromVersion_ can be set to either **1.0.0** or **1.0.1** values.

Navigate to the appropriate documentation to proceed with the next upgrade steps by [choosing one of the cards](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/)
on top of the page.

{% endif %}

### Next steps

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
