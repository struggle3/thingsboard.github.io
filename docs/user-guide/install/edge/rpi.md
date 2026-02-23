---
layout: docwithnav-edge
title: 在 Raspberry Pi 上安装 ThingsBoard Edge
description: 在 Raspberry Pi 上安装 ThingsBoard Edge

---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南介绍在 **Raspberry Pi** 上安装 **ThingsBoard Edge** 的步骤。

{% include templates/edge/install/prerequisites.md %}

## 步骤 1：安装 Java 17（OpenJDK）

{% include templates/install/ubuntu-java-install.md %}

## 步骤 2：安装 ThingsBoard Edge 服务

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard-edge/releases/download/{{ site.release.edge_tag }}/tb-edge-{{ site.release.edge_ver }}.deb
```
{: .copy-code}

进入下载目录并安装 ThingsBoard Edge 服务

```bash
sudo dpkg -i tb-edge-{{ site.release.edge_ver }}.deb
```
{: .copy-code}

## 步骤 3：配置 ThingsBoard Edge 数据库

{% include templates/edge/install/rpi-db-rpi-postgresql.md %}

## 步骤 4：Queue 服务

默认情况下，**ThingsBoard Edge** 使用内置 queue 实现，无需额外配置。

适用于开发或概念验证（PoC）环境，因可扩展性有限，不建议用于生产或集群部署。

## 步骤 5：[可选] 低性能设备内存优化

{% include templates/edge/install/memory-on-slow-edge-machines.md %} 

## 步骤 6：运行安装脚本

{% include templates/edge/install/run-edge-install.md %} 

## 步骤 7：重启 ThingsBoard Edge 服务

```bash
sudo service tb-edge restart
```
{: .copy-code}

## 步骤 8：打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %}

* 或将 **localhost** 替换为 **Raspberry Pi 的实际本地 IP**

## 故障排除

**ThingsBoard Edge** 日志位于以下目录：

```bash
/var/log/tb-edge
```

检查服务端错误可运行以下命令：

```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```
{: .copy-code}

{% include templates/edge/install/edge-service-commands.md %}

## 下一步

{% include templates/edge/install/next-steps.md %}
