---
layout: docwithnav
assignees:
- vbabak
title: 贡献指南

---

* TOC
{:toc}

我们持续倾听社区反馈以改进 ThingsBoard。
若有想法或新功能建议，请在 ThingsBoard [**GitHub issue 页面**](https://github.com/thingsboard/thingsboard/issues) 提交 issue。
请先确认 issues 列表中尚无相同或高度相似的任务。

开始实现前，请等待 ThingsBoard 团队对 issue 进行回复。我们会尽快回复。

## 所需工具

要构建并运行 ThingsBoard 实例，请确保已安装 **Java** 和 **Maven**。

[**从源码构建**](/docs/user-guide/install/building-from-source) 章节描述了 [**Java**](/docs/user-guide/install/building-from-source/#java) 和 [**Maven**](/docs/user-guide/install/building-from-source/#maven) 的安装步骤。

运行集成测试和黑盒测试需要 **docker** 和 **docker-compose**，详见 [运行测试](/docs/user-guide/install/building-from-source/#tips-and-tricks) 章节。

## Fork 并构建 ThingsBoard 仓库

安装好所需工具后，请 fork 官方 [**ThingsBoard 仓库**](https://github.com/thingsboard/thingsboard)。

然后克隆 fork 项目的源码。 

**注意：** 下文中将克隆的目录记为 **${TB_WORK_DIR}**。

首次在 Windows 上构建时，可能需要先运行以下命令安装所需的 npm 依赖： 
```bat 
npm install -g cross-env 
npm install -g webpack 
``` 

导入到 IDE 前，请先在项目根目录使用 **Maven** 构建：

```bash
cd ${TB_WORK_DIR}
mvn clean install -DskipTests
```

构建会生成 *application* 模块中的 *protobuf* 文件，供 IDE 正确编译使用。

接下来将项目作为 **Maven** 项目导入你常用的 IDE。 
可参考 [**IDEA**](https://www.jetbrains.com/help/idea/2016.3/importing-project-from-maven-model.html) 与 [**Eclipse**](https://www.baeldung.com/maven-import-eclipse) 的导入说明。   

**注意：** 使用 Eclipse 时，导入 Maven 项目后建议禁用 **ui-ngx** 的 Maven Project builder。可显著提升 Eclipse 性能，避免 Maven builder 扫描 node_modules 目录（不必要且会导致卡顿）。右键 **ui-ngx** 项目 → **Properties -> Builders**，取消勾选 **Maven Project Builder**，点击 **Ok**。

## 数据库

默认 ThingsBoard 使用 PostgreSQL 数据库存储实体和时序数据。
也可配置为混合模式：实体数据使用 PostgreSQL，时序数据使用可扩展的 Cassandra DB 集群。

### SQL 数据库：PostgreSQL

请使用 [此链接](https://wiki.postgresql.org/wiki/Detailed_installation_guides) 查看 PostgreSQL 安装说明。

安装 PostgreSQL 后，可创建新用户或设置主用户密码。

{% include templates/install/create-tb-db.md %}


### [可选] 时序数据 NoSQL 数据库：Cassandra

请参考以下安装 Cassandra 的章节：

 - [Linux 上安装 Cassandra](/docs/user-guide/install/linux/#cassandra)
 - [Windows 上安装 Cassandra](/docs/user-guide/install/windows/#cassandra)

编辑 ThingsBoard 配置文件： 

```text
/application/src/main/resources/thingsboard.yml
```

找到并将数据库类型配置参数设置为 'cassandra'。
 
```text
database:
  ts:
    type: "${DATABASE_TS_TYPE:cassandra}" # cassandra 或 sql（混合模式下仅此值应为 cassandra）
```

**注意：** 若 Cassandra 安装在远程机器或绑定到自定义接口/端口，需在 thingsboard.yml 中额外配置。
请参阅 [**配置指南**](/docs/user-guide/install/config/) 了解 **thingsboard.yml** 的详细说明及 Cassandra 连接相关属性。

更新 thingsboard.yml 后，请重新构建 application 模块以使配置生效：

```bash
cd ${TB_WORK_DIR}/application
mvn clean install -DskipTests
```

### 创建数据库 schema 并填充演示数据

为创建数据库表，请执行以下命令：

On *Linux*:

```bash
cd ${TB_WORK_DIR}/application/target/bin/install
chmod +x install_dev_db.sh
./install_dev_db.sh
```

On *Windows*:

```bat
cd %TB_WORK_DIR%\application\target\windows
install_dev_db.bat
```

## 运行开发环境

### 以热重载模式运行 UI 容器

默认 ThingsBoard UI 在 8080 端口提供服务。若需以热重载模式运行 UI，可按以下方式操作。

**注意：** 此步骤为可选，仅在对 UI 进行修改时需要。

```bash
cd ${TB_WORK_DIR}/ui-ngx
mvn clean install -P yarn-start
```

将启动监听 4200 端口的服务器，所有 REST API 和 websocket 请求将转发至 8080 端口。

### 运行服务端容器

可通过以下两种方式启动服务端容器。

方式一：在 *IDE* 中运行 *application* 模块下 **org.thingsboard.server.ThingsboardServerApplication** 的 main 方法。

方式二：从命令行以标准 **Spring boot** 应用方式启动：

```bash
cd ${TB_WORK_DIR}
java -jar application/target/thingsboard-${VERSION}-boot.jar
```

### 试运行

访问 http://localhost:4200/ 或 http://localhost:8080/，使用演示数据凭据登录 ThingsBoard：

 - *登录名* **tenant@thingsboard.org**
 - *密码* **tenant**

确认可正常登录且所有服务已正确启动。

## 代码修改

此时可以开始修改代码。
更新服务端或 UI 代码。
从用户角度验证修改是否符合需求与预期。

### 验证构建

在将修改提交到远端仓库前，使用 *Maven* 在本地执行带测试的构建：

```bash
mvn clean install
```

确保构建成功且所有测试通过。建议同时运行 [black-box tests](https://github.com/thingsboard/thingsboard/tree/master/msa/black-box-tests)。

### 推送到你的 fork

完成代码修改后，将更改提交并推送到你的 fork 仓库，并附上有意义的提交信息：

```bash
git commit -m 'Some meaningful comment'
git push origin master
```

### 创建 pull request

请默认向 **master** 分支创建 pull request（若在 GitHub issue 初步讨论阶段有需要，会提供其他 *branch* 名称）。

若 ThingsBoard master 分支在你提交前已有新变更导致冲突，请先解决冲突后再继续。

签署贡献许可协议（CLA）并确认远端构建成功。CLA 将通过 GitHub CLA bot 自动签署。
 
 ![image](/images/user-guide/pr_cla.png)

请耐心等待，pull request 可能需要数天才能完成审核。



## 另请参阅

- [Rule Node 开发](/docs/user-guide/contribution/rule-node-development/) 指南，介绍如何创建自定义 Rule Node。

- [部件开发指南](/docs/user-guide/contribution/widgets-development/)，介绍如何创建自定义部件。

## 下一步

{% assign currentGuide = "Contribution" %}{% include templates/guides-banner.md %}
