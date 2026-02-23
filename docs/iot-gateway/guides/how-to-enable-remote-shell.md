---
layout: docwithnav-gw
title: 如何在 ThingsBoard IoT Gateway 上启用远程 Shell 功能
description: 如何在 ThingsBoard IoT Gateway 上启用远程 Shell 功能

---

* TOC
{:toc}

本指南将帮助您启用远程 Shell 功能，从 ThingsBoard 平台实例通过 ThingsBoard IoT Gateway 控制操作系统。启用后，您可以从平台直接访问底层机器、执行命令并执行维护任务，便于监控系统状态、排查问题并自动化管理操作，而无需现场物理访问。开始前请确保具备所需权限，并已按本文档前提条件配置网关。

{% capture info %}
<div>
  <p>
    <b style="color:red">警告：</b>
    <span style="color:black">此功能可能带来安全风险。强烈建议启用时使用 SSL 加密，且仅在需要时启用。</span>
  </p>
</div>
{% endcapture %}
{% include templates/warn-banner.md content=info %}

## 前提条件

1. 确保 ThingsBoard 服务已运行。最简单的方式是使用 [ThingsBoard Cloud](https://thingsboard.io/installations/){:target="_blank"}。也可参考 [安装指南](/docs/user-guide/install/installation-options/) 手动安装 ThingsBoard。
2. 已安装并配置 ThingsBoard IoT Gateway（[安装指南](/docs/iot-gateway/installation/)、[快速入门](/docs/iot-gateway/getting-started/)）。

## 步骤 1：启用远程 Shell

要启用远程 Shell 功能，请在网关 UI 中按以下步骤配置对应参数：

{% assign enableRemoteShell = '
    ===
        image: /images/gateway/remote-shell/remote-shell-1.png,
        title: Go to the **Entities** > **Gateways** tab and click on the desired gateway.
    ===
        image: /images/gateway/remote-shell/remote-shell-2.png,
        title: Click on the **"General configuration"** button on the right panel.
    ===
        image: /images/gateway/remote-shell/remote-shell-3.png,
        title: In the opened window, navigate to the **General** tab and enable the **"Remote shell"** option. Click on the **"Save"** button to apply the changes.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=enableRemoteShell %}

## Step 2. Try out the remote shell

To navigate to the remote shell, follow these steps:

{% assign navigateToRemoteShell = '
    ===
        image: /images/gateway/remote-shell/remote-shell-4.png,
        title: On the selected gateway page, click on the **"Remote shell"** button on the right panel.
    ===
        image: /images/gateway/remote-shell/remote-shell-5.png,
        title: Now you can see the shell interface (_connection setups automatically_).
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=navigateToRemoteShell %}

For example, we run **ls** command to get the list of files and directories in the current directory:

![](/images/gateway/remote-shell/remote-shell-6.png)
## Next steps

Explore guides related to main ThingsBoard features:

 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.
 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
