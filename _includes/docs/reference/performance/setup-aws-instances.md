#### Step 1. Launch EC2 instance. 

为进行纯净测试，请为ThingsBoard和性能工具各启动一台实例。
操作系统为Linux，镜像*Ubuntu 20 LTS*。架构根据实例类型选择x64或ARM。
分配Elastic IP以便在重启间保持实例访问。
至少需要两台实例：一台运行ThingsBoard本身，一台运行性能测试应用。   

![ThingsBoard and Performance test instances](/images/reference/performance-aws-instances/method/setup/performance_test_aws_instances.png "ThingsBoard and Performance test instances")

初始时防火墙不允许连接实例。需开放必要端口以使实例与管理员机器互通。  

为两台实例配置网络安全组，并为源IP（办公室、家庭、性能测试）的入站规则开放TCP端口22（SSH）、8080（HTTP）、1883（MQTT）、9999（JMX）。

![Setup network security group for performance test](/images/reference/performance-aws-instances/method/setup/performance_test_network_security_group.png "Setup network security group for performance test")

据经验，规则数量会影响网络性能，因此另一可选方案是为可信IP和本地网络IP子网放行“全部流量”。

![Security group inbound rules](/images/reference/performance-aws-instances/method/setup/performance_test_network_security_group_inbound_rules.png)


#### Step 2. Setup SSH to the instance.

（可选）配置SSH私钥以访问实例。建议将`PEM`密钥文件放到`~/.ssh/aws.pem`并设置`~/.ssh/config`，例如：
```bash
Host tb
 Hostname 52.50.5.45
 Port 22
 IdentityFile /home/username/.ssh/aws.pem
 IdentitiesOnly yes
 User ubuntu
```
{: .copy-code}

连接ThingsBoard实例时使用以下命令：
```bash
ssh tb
```

#### Step 3. Install Docker and Docker-compose.

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


#### Step 4. Launch ThingsBoard and third-party components using docker-compose

将docker-compose文件下载到工作目录。 
docker-compose文件列于与您性能测试[场景](/docs/{{docsPrefix}}reference/performance-comparison/#test-summary)对应的“如何复现测试”部分。

确保文件存在于工作目录且命名为"docker-compose.yml"，然后执行以下命令： 

```bash
# stop previous instance (if any)
docker-compose stop
# remove previous instance (old data will be lost)
docker-compose rm
# run new instance from scratch 
docker-compose up 
```

注：为简化起见，我们使用[docker-compose host网络模式](https://docs.docker.com/compose/compose-file/compose-file-v3/#network_mode)。
这也有助于避免微服务间活跃网络通信时的docker-proxy开销。
