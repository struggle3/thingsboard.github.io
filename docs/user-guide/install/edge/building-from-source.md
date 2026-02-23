---
layout: docwithnav-edge
title: 从源码构建
description: 从源码构建 ThingsBoard Edge

---

* TOC
{:toc}

本指南介绍如何下载并从源码构建 ThingsBoard Edge。以下说明已在 Ubuntu 22.04 LTS / 24.04 LTS 及 CentOS 8/9 上验证。

## 必备工具

本节包含构建工具的安装说明。

### Java

ThingsBoard Edge 使用 Java 17 构建。可按 [以下说明](/docs/user-guide/install/linux#java) 安装 Java 17。

### Maven

ThingsBoard 构建需要 Maven 3.1.0 或更高版本。

{% capture tabspec %}maven-installation
A,Ubuntu,shell,resources/maven-ubuntu-installation.sh,/docs/user-guide/install/resources/maven-ubuntu-installation.sh
B,CentOS,shell,resources/maven-centos-installation.sh,/docs/user-guide/install/resources/maven-centos-installation.sh{% endcapture %}
{% include tabs.html %}

**注意：** 在某些 Linux 环境下，Maven 安装可能将 Java 7 设为默认 JVM。
可按 Java 安装 [说明](#java) 进行修正。

## 源码

可从官方 [GitHub 仓库](https://github.com/thingsboard/thingsboard-edge) 克隆项目源码。

```bash
# checkout latest release branch
git clone -b {{ site.release.branch }} git@github.com:thingsboard/thingsboard-edge.git
cd thingsboard-edge
```
{: .copy-code}

## 构建

在 thingsboard-edge 目录下运行以下命令进行构建：

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

可在 target 目录中找到 debian、rpm 及 Windows 安装包：
 
```bash
application/target
```

## 技巧与建议

在全新的干净环境中从源码构建 ThingsBoard Edge 较为简单。

以下建议可提升构建体验： 

- [clean maven cache](https://www.baeldung.com/maven-clear-cache)
  ```bash
  rm -rf ~/.m2/repository
  ```
  {: .copy-code}

- clean gradle cache
  ```bash
  rm -rf ~/.gradle/caches/
  ```
  {: .copy-code}

- clean node modules
  ```bash
  rm -rf ui-ngx/node_modules
  ```
  {: .copy-code}

- build in parallel, format headers, build docker images
  ```bash
  mvn -T 0.8C license:format clean install -DskipTests -Ddockerfile.skip=false
  ```
  {: .copy-code}
