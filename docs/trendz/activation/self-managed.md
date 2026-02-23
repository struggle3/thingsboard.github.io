---
layout: docwithnav-trendz
title: 如何激活自托管 Trendz
description: 如何激活自托管 Trendz

login:
  0:
    image: /images/trendz/activation/self-hosted/login-1.png
    title: 'Open the <b>ThingsBoard License Portal</b> and sign in with your ThingsBoard account as a sysadmin.'
  1:
    image: /images/trendz/activation/self-hosted/login-2.png
    title: 'Go to the <b>Subscriptions</b> tab or <b>Perpetual licenses</b> tab (depends on your subscription type).'

enable:
  0:
    image: /images/trendz/activation/self-hosted/enable-1.png
    title: 'In the list of licensed installations, select the ThingsBoard instance for which you want to enable Trendz and click on it to open the instance profile'
  1:
    image: /images/trendz/activation/self-hosted/enable-2.png
    title: 'Click <b>Manage Add-ons</b>.'
  2:
    image: /images/trendz/activation/self-hosted/enable-3.png
    title: 'Scroll down and enable the <b>Trendz Analytics</b> checkbox.'
  3:
    image: /images/trendz/activation/self-hosted/enable-4.png
    title: 'Click <b>Next</b> in the lower right corner.'

complete-payment:
  0:
    image: /images/trendz/activation/self-hosted/complete-payment.png
    title: 'On the Summary screen, verify the selected plan and full price. If everything is correct, click <b>Update</b> and complete the payment.'

pricing:
  0:
    image: /images/trendz/activation/self-hosted/self-managed-1.png
    title: 'You can find out up-to-date prices on Trendz add-on in the <b>pricing page</b>.'
  1:
    image: /images/trendz/activation/self-hosted/self-managed-2.png
    title: 'Calculate your pricing, based on your ThingsBoard self-managed setup.'
---

* TOC
{:toc}

本节介绍如何通过 License Portal 为 ThingsBoard 自托管环境激活 Trendz。

## 激活步骤

### 步骤 1：登录 License Portal

* 打开 [ThingsBoard License Portal](https://license.thingsboard.io/login)
* 使用 ThingsBoard 系统管理员账号登录
* 进入「**Subscriptions**」或「**Perpetual licenses**」标签（视订阅类型而定）

{% include images-gallery.html imageCollection="login" %}

### 步骤 2：选择实例并启用 Trendz 插件

* 在已授权安装列表中，选择要启用 Trendz 的 ThingsBoard 实例
* 点击实例打开实例配置
* 点击「**Manage Add-ons**」
* 向下滚动并勾选「**Trendz Analytics**」
* 点击右下角「**Next**」

{% include images-gallery.html imageCollection="enable" %}

### 步骤 3：查看摘要并完成支付

* 在摘要页面确认所选方案和总价
* 若无误，点击「**Update**」并完成支付

{% include images-gallery.html imageCollection="complete-payment" %}

### 步骤 4：重启 ThingsBoard

最后，需重启 ThingsBoard 服务以获取最新订阅信息。

## 定价

可在 [定价页面](/pricing/?section=thingsboard-pe-options&product=thingsboard-pe) 查看 Trendz 插件最新价格。

{% include images-gallery.html imageCollection="pricing" %}

如有任何问题，请**[联系我们](/docs/contact-us)**，我们的团队将帮您找到最适合的解决方案。

## 下一步

* 遵循 [安装指南](/docs/trendz/install/installation-options) 在您的环境中安装 Trendz
* 遵循 [入门指南](/docs/trendz/getting-started) 了解 Trendz 功能
* 访问 [文档](/docs/trendz) 了解 Trendz 功能与特性
