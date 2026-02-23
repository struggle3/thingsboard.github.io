---
layout: docwithnav-gw
title: IoT Gateway 源码安装
description: 从源码安装 ThingsBoard IoT Gateway

---

## 源码安装

从源码安装 ThingsBoard Gateway，请按以下步骤操作：    
  
**1.** 使用 apt 安装所需系统库：
```bash
sudo apt install python3-dev python3-pip python3-venv libglib2.0-dev git
```
{: .copy-code}

**2.** 从 GitHub 克隆仓库：
```bash
git clone --recurse-submodules https://github.com/thingsboard/thingsboard-gateway.git --depth 1
```
{: .copy-code}

**3.** 进入克隆目录：
```bash
cd thingsboard-gateway
```
{: .copy-code}

**4.** 创建并激活虚拟环境：
```bash
python3 -m venv venv && source venv/bin/activate
```
{: .copy-code}

**5.** 安装 Python 依赖：
```bash
pip install -r requirements.txt
```
{: .copy-code}

**6.** 安装库：
```bash
python setup.py install
```
{: .copy-code}

**7.** 创建「logs」目录：
```bash
mkdir logs
```
{: .copy-code}

**8.** 配置网关以连接你的 ThingsBoard 实例：在 *tb_gateway.json* 配置文件中修改「host」和「accessToken」为你的值。
该文件说明见 [IoT Gateway 配置](/docs/iot-gateway/configuration/#general-configuration-file) 指南。

tb_gateway.json 位于 config 目录：

```bash
thingsboard-gateway/thingsboard_gateway/config
```

**9.** 运行网关以验证安装：
```bash
python3 ./thingsboard_gateway/tb_gateway.py
```
{: .copy-code}

## 构建本地 Docker 镜像

构建本地 Docker 镜像，请按以下步骤操作：

**1.** 将 **Dockerfile** 复制到**根目录**：

```bash
cp docker/Dockerfile .
```
{: .copy-code}

**2.** 在项目根目录执行：

```bash
docker build -t local-gateway . 
```
{: .copy-code}

## Hot Reloader

开发环境使用时，可启用 Hot Reloader，在编辑任意项目文件时自动重启 Gateway。

启用 Hot Reloader 运行 Gateway，执行：

```bash
python3 ./thingsboard_gateway/tb_gateway.py true
```
{: .copy-code}
