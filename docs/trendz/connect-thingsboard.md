---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 将 Trendz 连接到 ThingsBoard
description: 将 Trendz Analytics 平台连接到 ThingsBoard
---

* TOC
{:toc}

## Trendz 与 ThingsBoard 4.2.1 或更早版本

本指南说明如何将 Trendz 连接到 ThingsBoard 4.2.1 或更早版本。强烈建议将 ThingsBoard 更新到最新版本，以使用全部 Trendz 与 ThingsBoard 功能。

To install Trendz for ThingsBoard 4.2.1 or older:

1. Start from step 1 of the installation guide.
2. Before the `Start Trendz service` step, configure `TRENDZ_LICENSE_SECRET` and `TB_API_URL`.
3. Complete all other steps, except for `Sync ThingsBoard With Trendz`.
4. Perform [post-installation steps](/docs/trendz/post-installation-steps).

### Configure License Secret

To interact with ThingsBoard 4.2.1 or older, you need a Trendz license secret key. If you do not have one, obtain it from the [ThingsBoard support team](/docs/contact-us).

Edit the Trendz configuration file:

```bash
sudo nano /etc/trendz/conf/trendz.conf
```

Add the following line and replace `YOUR_LICENSE_SECRET_HERE` with your license key:

```bash
export TRENDZ_LICENSE_SECRET=YOUR_LICENSE_SECRET_HERE
```

For Docker installations, update the `TRENDZ_LICENSE_SECRET` environment variable with the correct value.

### Configure TB_API_URL

By default, Trendz assumes ThingsBoard is hosted on the same instance and accessible at:

```
http://localhost:9090
```

If ThingsBoard is hosted on a different instance or port, update the configuration accordingly:

```bash
sudo nano /usr/share/trendz/conf/trendz.conf
```

Set the correct URL:

```yml
export TB_API_URL=http://localhost:9090
```

For Docker installations, update the `TB_API_URL` environment variable with the correct value.


## Next Steps

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
