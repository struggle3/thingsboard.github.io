
出于安全考虑，所有 **Raspberry Pi** 设备默认禁用 **SSH**。
需启用 SSH 才能继续。
若已连接显示器和键盘，可在存储设备设置期间通过 GUI 或在终端中启用 **SSH**。

在终端中启用 **SSH**，请执行：

```bash
sudo raspi-config
```
{: .copy-code}

在 **Raspberry Pi 软件配置工具 (raspi-config)** 页面：

{% assign raspi-config = '
===
image: /images/devices-library/edge/paspberry-pi/1-raspi-config-interface-options.webp,
title: 进入 **Interface Options** 并按 **Enter** 选择。
===
image: /images/devices-library/edge/paspberry-pi/2-raspi-config-enable-ssh.webp,
title: 选择 **「Enable/disable remote command line access using SSH」** 选项并按 Enter。
===
image: /images/devices-library/edge/paspberry-pi/3-raspi-config-confirm-enable-ssh.webp,
title: 选择 **Yes** 确认启用 SSH 服务器。
===
image: /images/devices-library/edge/paspberry-pi/4-raspi-config-ssh-server-enabled-ok.webp,
title: 应出现确认消息，提示 **SSH server is enabled**（SSH 服务器已启用）。
===
image: /images/devices-library/edge/paspberry-pi/5-raspi-config-finish.webp,
title: 选择 **Finish** 并关闭程序。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=raspi-config %}
