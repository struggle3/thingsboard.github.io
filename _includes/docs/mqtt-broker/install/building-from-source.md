* TOC
{:toc}

本指南将帮助您从源码下载并构建 TBMQ。以下说明已在 Ubuntu 20.04 LTS/22.04 LTS/24.04 LTS 上测试通过。

## 所需工具

本节包含构建工具的安装说明。

### Java

TBMQ 使用 Java 17 构建。请按以下说明安装 OpenJDK 17：

```bash
sudo apt update
sudo apt install openjdk-17-jdk-headless
```
{: .copy-code}

请勿忘记将操作系统配置为默认使用 OpenJDK 17。
可使用以下命令配置默认版本：

```bash
sudo update-alternatives --config java
```
{: .copy-code}

可使用以下命令检查安装是否成功：

```bash
java -version
```
{: .copy-code}

预期命令输出为：

```text
openjdk version "17.0.xx"
OpenJDK Runtime Environment (...)
OpenJDK 64-Bit Server VM (build ...)
```

### Maven

TBMQ 构建需要 Maven 3.6.3 及以上版本。

```bash
sudo apt install maven
```
{: .copy-code}

**请注意**：在部分 Linux 机器上，Maven 安装可能会将 Java 7 设为默认 JVM。
请使用 Java 安装[说明](#java)进行修复。

## 源码

您可从官方 [GitHub 仓库](https://github.com/thingsboard/tbmq)克隆项目源码。

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq
```
{: .copy-code}

## 构建

在 TBMQ 目录下运行以下命令构建项目：

```bash
mvn clean install -DskipTests
```
{: .copy-code}

## 构建本地 Docker 镜像

请确保已安装 [Docker](https://docs.docker.com/engine/install/)。

```bash
mvn clean install -DskipTests -Ddockerfile.skip=false
```
{: .copy-code}

## 构建产物

您可在 target 目录中找到 debian、rpm 和 windows 安装包：
 
```bash
cd application/target
```
{: .copy-code}

## 运行测试

我们使用 [Docker](https://docs.docker.com/engine/install/) 运行各类集成测试和黑盒测试。

请配置 [以非 root 用户管理 Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) 以正确运行测试。

主分支和发布分支均已通过测试，因此您可跳过测试，也无需安装 Docker。

运行全部单元测试和集成测试：

```bash
mvn clean install
```
{: .copy-code}

## 技巧与提示

在全新的纯净环境中，TBMQ 从源码构建较为简便。

以下是一些提升构建体验的技巧： 

- [清理 Maven 缓存](https://www.baeldung.com/maven-clear-cache)
  ```bash
  rm -rf ~/.m2/repository
  ```
  {: .copy-code}

- 清理 Gradle 缓存
  ```bash
  rm -rf ~/.gradle/caches/
  ```
  {: .copy-code}

- 清理 node modules
  ```bash
  rm -rf ui-ngx/node_modules
  ```
  {: .copy-code}

- 并行构建、格式化头文件、构建 Docker 镜像
  ```bash
  mvn -T 0.8C license:format clean install -DskipTests -Ddockerfile.skip=false
  ```
  {: .copy-code}