* TOC
{:toc}

本指南帮助您熟悉 ThingsBoard 配置文件与参数。我们**建议**使用环境变量配置 ThingsBoard，这样在新平台版本发布时无需合并配置文件。可用配置参数及对应环境变量列表位于 {% if docsPrefix == null %}[此处](/docs/user-guide/install/config/){% endif %}{% if docsPrefix == "pe/" %}[此处](/docs/user-guide/install/pe/config/){% endif %}。

## 如何修改配置参数？

### Linux 单体部署

若 ThingsBoard 在 **Linux** 上以**单体应用**形式安装，可在 thingsboard.conf 中指定环境变量：

```bash
sudo nano /usr/share/thingsboard/conf/thingsboard.conf
```

参考以下简单示例，添加新环境变量 'HTTP_BIND_PORT'，值为 '8081'。

```bash
...
export HTTP_BIND_PORT=8081
```

### Windows 单体部署

若 ThingsBoard 在 **Windows** 上以**单体应用**形式安装，可在以下目录的 thingsboard.yml 中指定环境变量：

```bash
YOUR_INSTALL_DIR/conf
```

配置文件采用 YAML 格式。

所有配置参数都有对应的环境变量名和默认值。要修改配置参数，只需修改其默认值即可。例如：

```bash
server:
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
```

本例中，*'HTTP_BIND_ADDRESS'* 为环境变量名，*'0.0.0.0'* 为默认值。

### Docker 部署

若 ThingsBoard 在 docker compose 环境中安装，可编辑脚本并为对应容器添加环境变量。
详见 [Docker 文档](https://docs.docker.com/compose/environment-variables/#/the-envfile-configuration-option)。

### K8S 部署

若 ThingsBoard 在 K8S 环境中安装，可编辑脚本并为对应 deployment/stateful set 添加环境变量。
详见 [K8S 文档](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。
