---
layout: docwithnav-pe
title: 从旧版 Docker 部署文件迁移
description: 从旧版 Docker 部署文件迁移
---

* TOC
{:toc}

本指南将帮助您从使用卷绑定的旧版 Docker 安装部署文件迁移到使用本地卷。
本指南涵盖独立 Trendz 安装。

## 为何更改部署文件？

- 数据曾持久化在具有特定所有权的本地文件夹中，而非使用 Docker 卷机制

## 谁需要本指南？

拥有如下或类似 docker compose 文件的客户：

```yml
version: '3.0'
services:
  mytrendz:
    restart: always
    image: "thingsboard/trendz:1.14.0"
    ports:
      - "8888:8888"
    environment:
      TB_API_URL: http://10.0.0.101:8080
      TRENDZ_LICENSE_INSTANCE_DATA_FILE: /data/license.data
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/trendz
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: postgres
      SCRIPT_ENGINE_TIMEOUT: 30000
    volumes:
      - ~/.mytrendz-data:/data
      - ~/.mytrendz-logs:/var/log/trendz
  postgres:
    restart: always
    image: "postgres:15"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: trendz
      POSTGRES_PASSWORD: postgres
    volumes:
      - ~/.mytrendz-data/db:/var/lib/postgresql/data
```
{: .copy-code}

## 将 Postgres 数据迁移到 Docker 卷

创建命名 Docker 卷：

```bash
docker volume create --name trendz-postgres-data
```
{: .copy-code}

使用附加卷运行容器，将数据从文件夹复制到新创建的卷

```bash
docker run --rm -v ~/.mytrendz-data/db:/source -v trendz-postgres-data:/destination alpine sh -c "cp -rp /source/* /destination/"
```
{: .copy-code}

{% capture old_postgres_info %}
**请注意，我们之前 docker compose 中使用的是 PostgreSQL 15 镜像，现已替换为 PostgreSQL 16。**
**要启动 Postgres DB 容器，您需要在新的部署文件中使用 `postgres:15` 镜像，或升级数据库文件**
{% endcapture %}
{% include templates/info-banner.md content=old_postgres_info %}

## 将 Trendz 数据迁移到 Docker 卷

创建命名 Docker 卷：

```bash
docker volume create --name trendz-data
```
{: .copy-code}

使用附加卷运行容器，将数据从文件夹复制到卷：

```bash
docker run --rm -v ~/.mytrendz-data/:/source -v tb-pe-license-data:/destination alpine sh -c "cp -rp /source/* /destination/ && chown 799:799 /destination/license.data"
```
{: .copy-code}

## 迁移到新部署文件

使用文本编辑器打开 `docker-compose.yml` 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

复制当前 Docker Compose [清单](/docs/trendz/install/docker/#step-2-docker-compose-setup)并替换旧文件。如需可替换 Postgres docker 镜像。

数据迁移到 docker 卷且 `docker-compose.yml` 文件与安装示例具有相同结构后，即可进行 Trendz [升级](/docs/trendz/install/docker/#upgrade-trendz-service)。
