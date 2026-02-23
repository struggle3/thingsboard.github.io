我们将使用专用于向ThingsBoard发送遥测的[性能测试工具](https://github.com/thingsboard/performance-tests/#running)。
该工具还会创建设备、仪表板等实体。

#### 步骤1：启动EC2实例

在与目标ThingsBoard服务器[部署](/docs/reference/performance/setup-aws-instances/)位置相同的VPC中启动实例。
确保测试实例可访问ThingsBoard实例的8080和1883端口。

#### 步骤2：配置实例的SSH访问

（可选）配置SSH私钥以访问实例。建议将`PEM`密钥文件放到`~/.ssh/aws.pem`并设置`~/.ssh/config`，例如：
```bash
Host pt
 Hostname 34.242.159.12
 Port 22
 IdentityFile /home/username/.ssh/aws.pem
 IdentitiesOnly yes
 User ubuntu
```
{: .copy-code}


连接性能测试实例时使用以下命令
```bash
ssh pt
```

#### 步骤3：安装Docker和Docker Compose

我们将使用docker和docker-compose以非root用户运行性能测试。 
为节省配置时间并保持环境一致，以下提供一体化安装脚本。  
通过SSH登录，在ThingsBoard和性能测试实例上均执行以下命令：

```bash
sudo apt update
sudo apt install -y docker docker-compose
# setup some utilities
sudo apt install -y htop iotop
# manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# test non-root docker run
docker run hello-world
```
{: .copy-code}


### 步骤4：运行性能测试

命令与以下类似。请勿忘记将TB_INTERNAL_IP替换为目标ThingsBoard实例的私有IP地址。

```bash
# Put your ThingsBoard private IP address here, assuming both ThingsBoard and performance tests EC2 instances are in same VPC.
export TB_INTERNAL_IP=172.31.16.229 
docker run -it --rm --network host --name tb-perf-test \
  --env REST_URL=http://$TB_INTERNAL_IP:8080 \
  --env MQTT_HOST=$TB_INTERNAL_IP \
  --env DEVICE_END_IDX=5000 \
  --env MESSAGES_PER_SECOND=1000 \
  --env ALARMS_PER_SECOND=10 \
  --env DURATION_IN_SECONDS=86400 \
  --env DEVICE_CREATE_ON_START=true \
  thingsboard/tb-ce-performance-test:3.3.3
```
{: .copy-code}