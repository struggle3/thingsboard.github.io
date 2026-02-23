* TOC
{:toc}

## Overview

ThingsBoard MCP Server为LLM和AI代理与ThingsBoard物联网平台交互提供**自然语言界面**。

该服务器实现了[Model Context Protocol (MCP)](https://modelcontextprotocol.io/docs/getting-started/intro){: target="_blank"}，使AI系统可通过自然语言命令访问和操作ThingsBoard中的数据。通过该集成，您可以：

- 使用对话式语言查询实体（设备、资产、客户等）数据与遥测
- 通过AI助手管理实体
- 使用AI工具分析物联网数据并生成报告
- 通过AI驱动的工作流自动化ThingsBoard操作

服务器可与支持MCP协议的Claude Desktop、Cursor及其他AI应用无缝集成。

## Requirements

开始前请确保具备以下条件：

{% if docsPrefix == nil or docsPrefix == "pe/" %}
- **ThingsBoard instance**:
    - **Local/On-premise instance**: Self-hosted ThingsBoard installation on your own [infrastructure](/docs/{{docsPrefix}}user-guide/install/installation-options/){: target="_blank"}, or
{% endif %}
{% if docsPrefix == nil or docsPrefix == "pe/" %}
    - **ThingsBoard Cloud**: Fully managed cloud service available at [ThingsBoard Cloud](https://thingsboard.io/installations/){: target="_blank"}
{% endif %}
{% if docsPrefix == "paas/" %}
- **ThingsBoard Cloud**: Fully managed cloud service available at [thingsboard.cloud](https://thingsboard.cloud/signup){: target="_blank"}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
- **EU ThingsBoard Cloud**: Fully managed cloud service available at [eu.thingsboard.cloud](https://eu.thingsboard.cloud/signup){: target="_blank"}
{% endif %}
{% if docsPrefix contains "edge/" %}
- **ThingsBoard Edge instance** [up and running](/docs/user-guide/install/{{docsPrefix}}installation-options/){: target="_blank"}
{% endif %}
- **认证凭据** - 在ThingsBoard实例上具有相应权限的有效用户名和密码

请记下ThingsBoard URL、用户名和密码 - 后续步骤中将以**your_thingsboard_url**、**your_username**和**your_password**使用。

## Quick Start Guide

1. **配置MCP客户端**：将ThingsBoard MCP服务器添加到客户端配置（见[Client Configuration](#client-configuration)）
2. **开始使用自然语言**：通过MCP客户端与ThingsBoard实例交互

## Features

### Entity Operations

- **Devices**：查看设备详情、凭据、配置并管理设备关系
- **Assets**：查看并管理资产、资产配置和资产关系
- **Customers**：访问客户信息、标题并管理客户关系
- **Users**：管理用户、令牌、激活链接和用户分配

### Telemetry Management

- **Attribute Access**：按作用域获取任意实体的属性键和值
- **Time-series Access**：获取支持多种聚合选项的时序数据
- **Telemetry Insert/Update**：保存属性或时序数据，支持可选TTL设置

### Relations

通过基于方向的查询发现和导航实体间关系。

### Alarms

获取特定实体的告警、告警类型及严重程度信息。

### Administration

- **System Settings**：访问并管理管理设置
- **Security Settings**：查看安全策略与JWT配置
- **Version Control**：管理仓库与自动提交设置
- **System Information**：检查更新并获取使用统计

## Installation

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
本MCP服务器与ThingsBoard物联网平台配合使用。安装需提供ThingsBoard实例URL及有效凭据。
{% endif %}
{% if docsPrefix contains "edge/" %}
本MCP服务器与ThingsBoard Edge配合使用。安装需提供ThingsBoard Edge实例URL及有效凭据。
{% endif %}

### ThingsBoard Account

安装MCP服务器前请确保：
{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
* 能访问ThingsBoard实例
{% endif %}
{% if docsPrefix contains "edge/" %}
* 能访问ThingsBoard Edge实例
{% endif %}
* 具有足够权限的用户账户
* 该账户的用户名和密码

### Docker Image

建议使用Docker Hub上的预构建Docker镜像快速开始。

#### Server Modes

ThingsBoard MCP Server支持两种运行模式：

- **STDIO Mode（标准输入/输出）**：服务器通过标准输入/输出流直接通信
- **SSE Mode（Server-Sent Events）**：服务器作为HTTP服务运行，供客户端连接

#### Running in STDIO Mode (Default)

STDIO模式下，必须使用 `-i` 参数保持stdin打开：

```bash
docker pull thingsboard/mcp
docker run --rm -i -e THINGSBOARD_URL=<your_thingsboard_url> -e THINGSBOARD_USERNAME=<your_username> -e THINGSBOARD_PASSWORD=<your_password> thingsboard/mcp
```
{: .copy-code}

#### Running in SSE Mode

SSE模式下，需使用 `-p` 参数暴露8000端口并显式覆盖默认设置：

```bash
docker pull thingsboard/mcp
docker run --rm -p 8000:8000 -e THINGSBOARD_URL=<your_thingsboard_url> -e THINGSBOARD_USERNAME=<your_username> -e THINGSBOARD_PASSWORD=<your_password> -e SPRING_AI_MCP_SERVER_STDIO=false -e SPRING_WEB_APPLICATION_TYPE=servlet thingsboard/mcp
```
{: .copy-code}

### Build from Sources

也可从源码构建JAR并直接运行ThingsBoard MCP Server。

#### Prerequisites

- Java 17或更高版本
- Maven 3.6或更高版本

#### Build Steps

* 克隆[仓库](https://github.com/thingsboard/thingsboard-mcp){: target="_blank"}
* 构建项目：

```bash
mvn clean install -DskipTests
```
{: .copy-code}

* JAR文件将生成于target目录：

```bash
./target/thingsboard-mcp-server-1.0.0.jar
```

* 使用JAR运行服务器：

```bash
# For STDIO Mode
java -jar ./target/thingsboard-mcp-server-1.0.0.jar
```
{: .copy-code}

```bash
# For SSE Mode
java -Dspring.ai.mcp.server.stdio=false Dspring.main.web-application-type=servlet -jar ./target/thingsboard-mcp-server-1.0.0.jar
```
{: .copy-code}

## Client Configuration

若要在MCP客户端启动时（如Claude Desktop）以容器方式启动服务器，需在客户端设置中添加相应配置。

### Docker Configuration

若使用Docker镜像，请在 `claude_desktop_config.json` 中使用如下配置：

```json
{
  "mcpServers": {
    "thingsboard": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "THINGSBOARD_URL",
        "-e",
        "THINGSBOARD_USERNAME",
        "-e",
        "THINGSBOARD_PASSWORD",
        "-e",
        "LOGGING_PATTERN_CONSOLE",
        "thingsboard/mcp"
      ],
      "env": {
        "THINGSBOARD_URL": "<thingsboard_url>",
        "THINGSBOARD_USERNAME": "<thingsboard_username>",
        "THINGSBOARD_PASSWORD": "<thingsboard_password>",
        "LOGGING_PATTERN_CONSOLE": ""
      }
    }
  }
}
```

### 二进制配置

若从源码构建了JAR文件，请在 `claude_desktop_config.json` 中使用如下配置：

```json
{
  "mcpServers": {
    "thingsboard": {
      "command": "java",
      "args": [
        "-jar",
        "/absolute/path/to/thingsboard-mcp-server-1.0.0.jar"
      ],
      "env": {
        "THINGSBOARD_URL": "<thingsboard_url>",
        "THINGSBOARD_USERNAME": "<thingsboard_username>",
        "THINGSBOARD_PASSWORD": "<thingsboard_password>",
        "LOGGING_PATTERN_CONSOLE": ""
      }
    }
  }
}
```

## 环境变量

MCP服务器连接ThingsBoard实例需设置以下环境变量：

| 变量 | 说明 | 默认值 |
|----------|------------------------------------------------|---------|
| `THINGSBOARD_URL` | ThingsBoard实例的基础URL | |
| `THINGSBOARD_USERNAME` | 用于向ThingsBoard认证的用户名 | |
| `THINGSBOARD_PASSWORD` | 用于向ThingsBoard认证的密码 | |
| `THINGSBOARD_LOGIN_INTERVAL_SECONDS` | 登录会话刷新间隔（秒） | 1800 |
| `SPRING_WEB_APPLICATION_TYPE` | Spring应用类型（none或servlet） | none |
| `SPRING_AI_MCP_SERVER_STDIO` | 启用/禁用标准I/O通信 | true |
| `SPRING_AI_MCP_SERVER_SSE_ENDPOINT` | Server-Sent Events（SSE）端点URL | /sse |
| `SPRING_AI_MCP_SERVER_SSE_MESSAGE_ENDPOINT` | Server-Sent Events消息端点URL | /mcp/message |
| `SERVER_PORT` | HTTP服务器端口号 | 8080 |

这些变量可通过以下方式设置：
- 直接在Docker命令行中用 `-e` 参数指定
- 或在MCP客户端配置的 `env` 块中设置

## 可用工具

ThingsBoard MCP Server提供多种可通过自然语言命令使用的工具。按类别组织如下。

### 设备工具

| 工具 | 说明 |
|------|-------------|
| `getDeviceById` | 根据提供的设备ID获取设备对象。 |
| `getDeviceCredentialsByDeviceId` | 根据设备ID获取设备凭据。若创建设备时未指定凭据，平台将生成随机'ACCESS_TOKEN'凭据。 |
| `getTenantDevices` | 返回租户拥有的设备分页结果。 |
| `getTenantDevice` | 按名称获取租户设备。设备名称为设备的唯一属性。 |
| `getCustomerDevices` | 返回分配给客户的设备对象分页结果。 |
| `getUserDevices` | 返回当前用户可用的设备对象分页结果。 |
| `getDevicesByIds` | 根据ID列表获取设备。请求的设备须由租户拥有或分配给客户。 |
| `getDevicesByEntityGroupId` | 返回属于指定实体组ID的设备对象分页结果。 |

### 资产工具

| 工具 | 说明 |
|------|-------------|
| `getAssetById` | 根据提供的资产ID获取资产对象。 |
| `getTenantAssets` | 返回租户拥有的资产分页结果。 |
| `getTenantAsset` | 按名称获取租户资产。资产名称为资产的唯一属性。 |
| `getCustomerAssets` | 返回分配给客户的资产对象分页结果。 |
| `getUserAssets` | 返回当前用户可用的资产对象分页结果。 |
| `getAssetsByIds` | 根据ID列表获取资产。请求的资产须由租户拥有或分配给客户。 |
| `getAssetsByEntityGroupId` | 返回属于指定实体组ID的资产对象分页结果。 |

### 客户工具

| 工具 | 说明 |
|------|-------------|
| `getCustomerById` | 根据提供的客户ID获取客户对象。 |
| `getCustomers` | 返回租户拥有的客户分页结果。 |
| `getTenantCustomer` | 使用客户标题获取客户。 |
| `getUserCustomers` | 返回用户可用的客户分页结果。 |
| `getCustomersByEntityGroupId` | 返回属于指定实体组ID的客户对象分页结果。 |

### 用户工具

| 工具 | 说明 |
|------|-------------|
| `getUserById` | 根据提供的用户ID获取用户对象。 |
| `getUsers` | 返回租户或客户拥有的用户分页结果。 |
| `getTenantAdmins` | 返回分配给指定租户的租户管理员用户分页结果。 |
| `getCustomerUsers` | 返回分配给指定客户的用户分页结果。 |
| `getAllCustomerUsers` | 返回当前租户下权限为'CUSTOMER_USER'的用户分页结果。 |
| `getUsersForAssign` | 返回可分配给指定alarmId的用户数据对象分页结果。 |
| `getUsersByEntityGroupId` | 返回属于指定实体组ID的用户对象分页结果。 |

### 告警工具

| 工具 | 说明 |
|------|-------------|
| `getAlarmById` | 根据提供的告警ID获取告警对象。 |
| `getAlarmInfoById` | 根据提供的告警ID获取告警信息对象。 |
| `getAlarms` | 获取所选实体的告警分页结果。 |
| `getAllAlarms` | 获取属于当前用户所有的告警分页结果。 |
| `getHighestAlarmSeverity` | 根据发起者及可选状态过滤获取最高告警严重程度。 |
| `getAlarmTypes` | 根据租户拥有或分配给客户的告警获取唯一告警类型集合。 |

### 实体组工具

| 工具 | 说明 |
|------|-------------|
| `getEntityGroupById` | 根据提供的实体组ID获取实体组对象。 |
| `getEntityGroupsByType` | 根据提供的实体类型获取实体组信息对象列表。 |
| `getEntityGroupByOwnerAndNameAndType` | 根据提供的所有者、类型和名称获取实体组对象。 |
| `getEntityGroupsByOwnerAndType` | 根据提供的所有者ID和实体类型获取实体组信息对象列表。 |
| `getEntityGroupsForEntity` | 返回包含指定实体ID的组列表。 |
| `getEntityGroupsByIds` | 根据提供的实体组ID列表获取实体组信息对象列表。 |

### 关系工具

| 工具 | 说明 |
|------|-------------|
| `getRelation` | 若存在，返回两个指定实体间的关系对象。 |
| `findByFrom` | 按'from'方向返回指定实体的关系对象列表。 |
| `findInfoByFrom` | 按'from'方向返回指定实体的关系信息对象列表。 |
| `findByTo` | 按'to'方向返回指定实体的关系对象列表。 |
| `findInfoByTo` | 按'to'方向返回指定实体的关系信息对象列表。 |

### 遥测工具

| 工具 | 说明 |
|------|-------------|
| `getAttributeKeys` | 获取指定实体的所有属性键。 |
| `getAttributeKeysByScope` | 获取指定实体及作用域的所有属性键。 |
| `getAttributes` | 获取指定实体的属性。 |
| `getAttributesByScope` | 获取指定实体及作用域的属性。 |
| `getTimeseriesKeys` | 获取指定实体的所有时序键。 |
| `getLatestTimeseries` | 获取指定实体及键的最新时序值。 |
| `getTimeseries` | 获取指定实体、键及时间范围的时序数据。 |
| `saveDeviceAttributes` | 保存设备属性。 |
| `saveEntityAttributesV1` | 保存实体属性（版本1）。 |
| `saveEntityAttributesV2` | 保存实体属性（版本2）。 |
| `saveEntityTelemetry` | 保存实体遥测数据。 |
| `saveEntityTelemetryWithTTL` | 保存带生存时间（TTL）的实体遥测数据。 |

### 管理工具

| 工具 | 说明 |
|------|-------------|
| `getAdminSettings` | 使用指定字符串键获取管理设置对象。 |
| `getSecuritySettings` | 获取包含密码策略、锁定限制等的安全设置对象。 |
| `getSystemInfo` | 获取系统主要信息。 |
| `getUsageInfo` | 获取当前租户的使用统计。 |