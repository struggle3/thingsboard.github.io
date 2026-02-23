## 前提条件

- 有效的 [DigitalOcean](https://cloud.digitalocean.com/){:target="_blank"} 账号

## 步骤 1. 在 DigitalOcean 上启动 Ubuntu 18.04

### 步骤 1.1 创建 DigitalOcean Droplet

- 登录 DigitalOcean 账号。
- 点击 "Droplets" 菜单项，然后点击 "Create Droplet" 按钮（见下图）。   

![image](/images/user-guide/install/digital-ocean-pe/create-droplet.png)

### 步骤 1.2 选择套餐

- 加载 "Create Droplets" 页面后，选择 "Ubuntu 18.04 x64" 作为镜像（见下图）。
- 选择套餐。建议初学者使用 2 核 CPU、4GB 内存 套餐。 

  注意：高级 ThingsBoard 用户可根据自身负载选择更合适的套餐。 
    
![image](/images/user-guide/install/digital-ocean-pe/choose-plan.png)

### 步骤 1.3 选择区域

- 向下滚动，从可用列表中选择数据中心区域（见下图）。
- [可选] 启用备份。虽为可选，但强烈建议启用。 
- [可选] 添加块存储

![image](/images/user-guide/install/digital-ocean-pe/choose-region.png)

### 步骤 1.4 认证

- 使用现有或创建新的 SSH 密钥用于连接实例。确保所选 SSH 密钥可访问。后续步骤中将用此密钥连接实例。 
- 设置有意义的主机名
- 添加 "thingsboard" 标签（本指南不会使用）。
- 最后，点击 "Create Droplet" 按钮。

![image](/images/user-guide/install/digital-ocean-pe/create-final.png)

- Droplet 创建后，将 IP 地址保存到安全位置，后续步骤中将使用。 

![image](/images/user-guide/install/digital-ocean-pe/droplet-created.png)

## 步骤 2. 配置防火墙规则

需配置防火墙规则以允许 MQTT、CoAP 和 HTTP 流量。见下图：

![image](/images/user-guide/install/digital-ocean-pe/create-firewall.png)

- 为防火墙设置有意义名称；
- 按下方界面配置 HTTP、HTTPS 及三条自定义规则。 

![image](/images/user-guide/install/digital-ocean-pe/firewall-config.png)

- 保持出站规则不变；
- 选择 Droplet 或标签以分配此防火墙；
- 最后点击 "Create Firewall" 按钮。

![image](/images/user-guide/install/digital-ocean-pe/firewall-final.png)

## 步骤 3. 使用 SSH 连接实例

请参考 [官方指南](https://www.digitalocean.com/docs/droplets/how-to/connect-with-ssh/){:target="_blank"} 
及 [步骤 1.4](/docs/user-guide/install/pe/digital-ocean/#step-14-authentication) 中创建的 SSH 密钥。
