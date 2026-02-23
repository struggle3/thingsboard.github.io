* TOC
{:toc}

本指南帮助您熟悉 TBMQ {{tbmqSuffix}} 的配置文件和参数。
我们**强烈建议**使用环境变量配置 TBMQ。
这样在新平台版本发布时，您无需合并配置文件。

可用配置参数及对应环境变量列表见[此处](#configuration-parameters)。

## 如何修改配置参数？

### Docker-Based 部署

若 TBMQ 部署在 Docker Compose 环境中，可编辑脚本并为对应容器添加环境变量。更多详情请参阅 [Docker 文档](https://docs.docker.com/compose/environment-variables/#/the-envfile-configuration-option)。

### K8S-Based 部署

若 TBMQ 部署在 K8S 环境中，可编辑脚本并为对应 deployments/stateful sets 添加环境变量。更多详情请参阅 [K8S 文档](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。

## 配置参数

配置文件采用 YAML 格式。所有配置参数均有对应的环境变量名和默认值。修改配置参数时，只需修改其默认值。例如：

```bash
server:
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
```

本例中，*'HTTP_BIND_ADDRESS'* 为环境变量名，*'0.0.0.0'* 为默认值。

以下示例用于添加值为 '8084' 的环境变量 'HTTP_BIND_PORT'：

```bash
...
export HTTP_BIND_PORT=8084
```

参数按系统组件分组。列表包含名称（**thingsboard-mqtt-broker.yml** 中的路径）、环境变量、默认值和说明。

{% if docsPrefix == "pe/" %}
{% include docs/pe/mqtt-broker/install/config.md %}
{% else %}
{% include docs/mqtt-broker/install/config.md %}
{% endif %}
