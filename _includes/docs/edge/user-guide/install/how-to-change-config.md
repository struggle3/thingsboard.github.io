* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard Edge 配置文件和参数。我们 **建议** 使用环境变量配置 ThingsBoard Edge。这样在新 Edge 版本发布时无需合并配置文件。可用配置参数及对应环境变量列表见[此处](#configuration-parameters)。

## 如何更改配置参数？

### Linux

若 ThingsBoard Edge 安装在 **Linux** 上，可在 tb-edge.conf 文件中指定环境变量：

```bash
sudo nano /usr/share/tb-edge/conf/tb-edge.conf
```

使用以下简单示例添加新环境变量 'HTTP_BIND_PORT'，值为 '8081'：

```bash
...
export HTTP_BIND_PORT=8081
```

### Windows

若 ThingsBoard Edge 安装在 **Windows** 上，可在以下目录的 tb-edge.yml 文件中指定环境变量：

```bash
YOUR_INSTALL_DIR/conf
```

配置文件使用 YAML 格式编写。

所有配置参数均有对应的环境变量名称和默认值。要更改配置参数，只需更改其默认值。例如：

```bash
server:
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
```

此例中，*'HTTP_BIND_ADDRESS'* 为环境变量名称，*'0.0.0.0'* 为默认值。

### Docker 部署

若 ThingsBoard Edge 在 docker compose 环境中安装，可编辑脚本并为相应容器添加环境变量。
详见 [docker documentation](https://docs.docker.com/compose/environment-variables/#/the-envfile-configuration-option)。
