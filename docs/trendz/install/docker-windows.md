---
layout: docwithnav-trendz
assignees:
  - ashvayka
title: 使用 Docker 安装 ThingsBoard Trendz 分析（Windows）
description: 使用 Docker 安装 ThingsBoard Trendz 分析（Windows）

trendz-settings:
  0:
    image: /images/trendz/install/sync/trendz-settings-1.png
    title: "以 <b>系统管理员</b> 身份登录 <b>ThingsBoard</b>。"
  1:
    image: /images/trendz/install/sync/trendz-settings-2.png
    title: "打开 <b>Trendz 设置</b> 页面。"
  2:
    image: /images/trendz/install/sync/trendz-settings-3.png
    title: "如果看到 <b>\"同步成功完成\"</b> 消息，则同步已自动完成，无需进一步操作。"
trendz-sync:
  0:
    image: /images/trendz/install/sync/trendz-sync-1.png
    title: "如果看到错误消息，请按以下步骤操作。"
  1:
    image: /images/trendz/install/sync/trendz-sync-2.png
    title: "输入正确的 <b>Trendz 内部 URL</b> 和 <b>ThingsBoard 内部 URL</b>。"
  2:
    image: /images/trendz/install/sync/trendz-sync-3.png
    title: "点击 <b>保存配置</b>。"
  3:
    image: /images/trendz/install/sync/trendz-sync-4.png
    title: "点击 <b>重试发现</b>。"
  4:
    image: /images/trendz/install/sync/trendz-sync-5.png
    title: "当出现 <b>\"同步成功完成\"</b> 消息时，同步即告完成。"

---

* TOC 
{:toc}

本指南将帮助您在 Windows 上使用 Docker 安装并启动 Trendz 分析。

## 前置条件

{% include templates/trendz/install/docker-requirements-windows.md %}
{% include templates/trendz/install/thingsboard-requirements.md %}

## 安装步骤

### 步骤 1. Docker Compose 设置

Trendz 可与 ThingsBoard 在同一 Docker Compose 文件中运行，也可在单独的 Docker Compose 文件中运行。

对于中小型安装，我们建议与 ThingsBoard 在同一 Docker Compose 文件中安装 Trendz。

{% capture contenttogglespec %}
与 ThingsBoard 同文件%,%theSameFile%,%templates/trendz/install/docker-compose-the-same-file-windows.md%br%
单独 Docker Compose 文件%,%separateFile%,%templates/trendz/install/docker-compose-separate-file-windows.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="runOption" toggle-spec=contenttogglespec %}

### 步骤 2. 启动 Trendz 服务

{% include templates/trendz/install/docker-start-trendz-service.md %}

### 步骤 3. 将 ThingsBoard 与 Trendz 同步

{% include templates/trendz/install/sync-with-tb.md %}

## 认证

{% include templates/trendz/install/authentication.md %}

## 分离、停止和启动命令

{% include templates/trendz/install/docker-detach-stop-start-commands.md %}

## 升级 Trendz 服务

{% capture upgrade_version_by_version%}
**注意，您可一次性将 Trendz 从任意版本升级到最新版本（例如 1.2.0 -> {{ site.release.trendz_ver }} 等）。**
{% endcapture %}
{% include templates/info-banner.md content=upgrade_version_by_version %}

以下是将 Trendz 从任意版本升级到 {{ site.release.trendz_ver }} 的示例

* 创建数据库转储：

```bash
docker compose exec trendz-postgres sh -c "pg_dump -U postgres trendz > /var/lib/postgresql/data/trendz_dump"
```
{: .copy-code}

有新 Trendz 版本可用时，请按以下步骤更新安装而不丢失数据：

{% capture old_manifests_info %}
**如果使用旧版部署文件升级，请先按此[说明](/docs/trendz/install/old-docker-migrate/)中的步骤操作。**
{% endcapture %}
{% include templates/warn-banner.md content=old_manifests_info %}

1. 将 `docker-compose.yml` 文件中 `thingsboard/trendz` 和 `thingsboard/trendz-python-executor` 的版本更改为 {{ site.release.trendz_ver }}。

2. 执行以下命令：

```bash
docker pull thingsboard/trendz:{{ site.release.trendz_ver }}
docker compose stop trendz
docker compose run --rm -e UPGRADE_TRENDZ=true trendz
docker compose up -d
```
{: .copy-code}

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues-windows.md %}

## 下一步

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
