---
layout: docwithnav-trendz
assignees:
  - ashvayka
title: 使用 Docker 安装 ThingsBoard Trendz Analytics（Linux 或 Mac OS）
description: 使用 Docker 在 Linux 或 Mac OS 上安装 ThingsBoard Trendz Analytics

trendz-settings:
  0:
    image: /images/trendz/install/sync/trendz-settings-1.png
    title: "Log in to <b>ThingsBoard</b> as a <b>Sysadmin</b>."
  1:
    image: /images/trendz/install/sync/trendz-settings-2.png
    title: "Open the <b>Trendz Settings</b> page."
  2:
    image: /images/trendz/install/sync/trendz-settings-3.png
    title: "If you see the message <b>\"Synchronization completed successfully\"</b>, the synchronization has been completed automatically and no further action is required."
trendz-sync:
  0:
    image: /images/trendz/install/sync/trendz-sync-1.png
    title: "If you see an error message, follow these steps."
  1:
    image: /images/trendz/install/sync/trendz-sync-2.png
    title: "Enter the correct <b>Trendz internal URL</b> and <b>ThingsBoard internal URL</b>."
  2:
    image: /images/trendz/install/sync/trendz-sync-3.png
    title: "Click <b>Save configuration</b>."
  3:
    image: /images/trendz/install/sync/trendz-sync-4.png
    title: "Click <b>Retry discovery</b>."
  4:
    image: /images/trendz/install/sync/trendz-sync-5.png
    title: "Once the message <b>\"Synchronization completed successfully\"</b> appears, the synchronization is complete."

---

* TOC
{:toc}


本指南帮助您使用Docker在Linux或Mac OS上安装并启动Trendz Analytics。

## Prerequisites

{% include templates/trendz/install/docker-requirements-linux.md %}
{% include templates/trendz/install/thingsboard-requirements.md %}

## Installation Steps

### Step 1. Docker Compose setup

Trendz可与ThingsBoard共用同一Docker Compose文件，或使用独立的Docker Compose文件运行。

中小型安装建议Trendz与ThingsBoard共用同一Docker Compose文件。

{% capture contenttogglespec %}
The same Docker Compose file with ThingsBoard%,%theSameFile%,%templates/trendz/install/docker-compose-the-same-file-linux.md%br%
Separate Docker Compose file%,%separateFile%,%templates/trendz/install/docker-compose-separate-file-linux.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="runOption" toggle-spec=contenttogglespec %}

### Step 2. Start Trendz service

{% include templates/trendz/install/docker-start-trendz-service.md %}

### Step 3. Sync ThingsBoard With Trendz

{% include templates/trendz/install/sync-with-tb.md %}

## Authentication

{% include templates/trendz/install/authentication.md %}

## Detaching, stop and start commands

{% include templates/trendz/install/docker-detach-stop-start-commands.md %}

## Upgrade Trendz Service

{% capture upgrade_version_by_version%}
**注意：可从任意版本直接升级到最新版（如 1.2.0 -> {{ site.release.trendz_ver }} 等）。**
{% endcapture %}
{% include templates/info-banner.md content=upgrade_version_by_version %}

以下为从任意Trendz版本升级到{{ site.release.trendz_ver }}的示例

* 创建数据库备份：

```bash
docker compose exec trendz-postgres sh -c "pg_dump -U postgres trendz > /var/lib/postgresql/data/trendz_dump"
```
{: .copy-code}

当有新Trendz版本发布时，按以下步骤更新安装并保留数据：

{% capture old_manifests_info %}
**若使用旧版部署文件升级，请先按[本说明](/docs/trendz/install/old-docker-migrate/)执行相应步骤。**
{% endcapture %}
{% include templates/warn-banner.md content=old_manifests_info %}

1. 将`docker-compose.yml`中`thingsboard/trendz`和`thingsboard/trendz-python-executor`的版本改为{{ site.release.trendz_ver }}。

2. 执行以下命令：

```bash
docker pull thingsboard/trendz:{{ site.release.trendz_ver }}
docker compose stop trendz
docker compose run --rm -e UPGRADE_TRENDZ=true trendz
docker compose up -d
```
{: .copy-code}

## Troubleshooting

### DNS issues

{% include templates/troubleshooting/dns-issues.md %}

## Next steps

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
