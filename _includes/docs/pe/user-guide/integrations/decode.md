* TOC
{:toc}

## 简介

本教程演示如何使用Decode DL28通信处理器，将区域供热站(DHS)设施中的多种信号集成到ThingsBoard IoT平台。来自数字和模拟I/O、Modbus RTU设备及M-Bus热量表的信号汇集于单个ThingsBoard仪表板。为简化演示仅连接少量信号与设备，实际部署中可使用数百台设备和数千个信号。



![image](/images/user-guide/integrations/decode/Picture0.png)



## 系统框图

系统框图展示DHS中典型的自动化与计量元件：通过RS485通信线连接的变电站控制器或泵控制器、M-Bus线上的热量表，以及用于控制阀门和监控液位开关等的I/O扩展。



![image](/images/user-guide/integrations/decode/Picture1.png)



Decode [DL28](https://decode.rs/product/dl28/)设备充当通信与信号集中器，在DHS中安装的所有控制、监测和计量设备与互联网上的ThingsBoard服务器之间起桥接作用。本例使用三个信号：两个继电器输出和热量表的一个温度值。

## 前置条件
- [ThingsBoard Cloud](https://thingsboard.cloud/signup/)账户
- 具备以太网连接和浏览器的计算机
- Decode DL28通信控制器
- Decode EXIO I/O扩展设备
- 至少有一个继电器输出的Modbus RTU从站
- 带M-Bus的热量表
- 互联网连接

## ThingsBoard配置
### 步骤1. 登录
访问ThingsBoard Cloud网页，使用创建账户时获得的凭据登录。

### 步骤2. 添加DL28设备
登录成功后，点击左侧菜单的Devices，再点击「+」图标。选择Add New Device，输入Name、Device type和Label，点击Add按钮。



![image](/images/user-guide/integrations/decode/Picture2.png)



DL28设备出现在Device窗口。点击DL28打开Device details窗口。



![image](/images/user-guide/integrations/decode/Picture3.png)



稍后在DL28 MQTT设置中使用的Client ID和Access token，可通过COPY DEVICE ID和COPY ACCESS TOKEN按钮复制。

### 步骤3. 添加仪表板
点击左侧菜单的Dashboards，再点击「+」图标。选择Create new dashboard，输入Name和Description，点击Add按钮。



![image](/images/user-guide/integrations/decode/Picture4.png)



DL28仪表板出现在Dashboard窗口。

### 步骤4. 添加部件
点击DL28，再点击OPEN DASHBOARD打开仪表板。点击铅笔图标进入Edit mode，再点击ADD NEW WIDGET。从下拉列表选择Control widgets，然后选择Switch control。Switch control部件将用于控制EXIO和Modbus RTU设备上的继电器。



![image](/images/user-guide/integrations/decode/Picture5.png)



在Add Widget窗口中点击Entity alias字段并按ENTER。在Entity alias列表中添加DL28设备。所有部件只需添加一次。



![image](/images/user-guide/integrations/decode/Picture6.png)



点击Advanced标签并输入以下参数。



![image](/images/user-guide/integrations/decode/Picture7.png)



在Convert value function中输入以下用于切换开关状态的代码。数据发布到topic **v1/devices/me/request+**。

```bash
if(value) return { "exio_relay_1": 1 };
else return { "exio_relay_1": 0 };
```



![image](/images/user-guide/integrations/decode/Picture8.png)



点击ADD按钮将部件添加到仪表板。按同样步骤添加另一个开关部件：Switch标题为**GT900 RL1**，Attribute/Timeseries value key为**gt900_relay_1**，Convert value function在ON状态为**{ "gt900_relay_1": 1 }**，OFF状态为**{ "gt900_relay_1": 0 }**。

按同样步骤添加两个LED指示部件以显示继电器状态，LED标题为**EXIO LED RL1**和**GT900 LED RL1**，Attribute/Timeseries value key为**exio_relay_1**和**gt900_relay_1**。



![image](/images/user-guide/integrations/decode/Picture9.png)



按同样步骤添加Digital gauge部件以显示M-Bus热量表回水温度，添加新Datasource。在Entity timeseries/attributes字段输入**cal_return_temp**，点击timeseries符号。点击Add按钮将仪表添加到仪表板。



![image](/images/user-guide/integrations/decode/Picture10.png)



点击apply changes图标保存更改并退出edit mode。

## DL28设备配置
### 步骤1. 连接
将计算机和DL28设备连接到同一具备互联网接入的计算机网络，网络地址需一致。按框图将EXIO I/O扩展设备连接到I2C端口，将Modbus RTU从站连接到RS485端口S6，将热量表连接到M-Bus主站端口S4。按用户手册安全规范连接电源并为所有设备通电。

### 步骤2. 登录
在浏览器地址栏输入DL28设备的IP地址并按ENTER。在弹出窗口输入用户名和密码。默认IP、用户名和密码分别为：**192.168.0.67**、**admin**、**admin**。登录成功后加载DL28网页。若设备时间无效请更新。必要时在LAN设置中修改Default Gateway地址。

### 步骤3. 配置EXIO
在EXIO设备菜单点击Rescan按钮。检测到EXIO设备并加入设备列表。本例使用EXIO type 3（7xAI、2xDO、2xAO）。点击Save按钮。

### 步骤4. 配置Modbus RTU
在Modbus settings菜单，勾选Modbus Master并设置poll interval和response timeout（例如分别为5分钟和10秒）。点击Save按钮。
在Modbus Poll list菜单添加两个参数。继电器开关控制使用ForceSingleCoil，读取继电器状态使用ReadCoilStatus。自动分配的寄存器地址为52000和52001。



![image](/images/user-guide/integrations/decode/Picture11.png)



### 步骤5. 配置M-Bus
在Modbus Settings菜单选择M-Bus master模式、扫描地址范围和轮询间隔。本例地址范围为1到3，轮询间隔为3分钟。点击Save按钮。
在Modbus Slave List菜单点击Rescan按钮开始检测连接的M-Bus设备。设备加入列表后，点击Save保存，点击Reload加载新设备数据。
选择show/hide选项以显示设备详细数据。M-Bus数据值以4字节浮点格式存储在Modbus map中。查找感兴趣的数据字段。本例选择回水温度(Return Temperature)，存储在偏移量为1222的Input Register中。



![image](/images/user-guide/integrations/decode/Picture12.png)



### 步骤6. 配置MQTT
在MQTT Settings菜单勾选：Enable、Clean Session和JSON format。输入ThingsBoard broker数据：Broker：**mqtt.thingsboard.cloud**，Port：**1883**，Reconnect Period：**10**，Keep Alive Interval：**60**，Client ID：输入从ThingsBoard demo账户获得的**Device ID**，Username：输入从ThingsBoard demo账户获得的**Access Token**，Password：留空。点击Save按钮。
在MQTT Publish List菜单添加三个参数，其中两个用于发布继电器状态，一个用于发布热量表回水温度。点击Save按钮。



![image](/images/user-guide/integrations/decode/Picture13.png)



进入MQTT Subscribe List菜单。为**exio_relay_1**和**gt900_relay_1**两个参数订阅topic **v1/devices/me/rpc/request/+**，分别引用DL28内部Modbus Holding register 508和Input register 52000。
点击Save按钮保存更改，在Restart菜单点击Restart button application重启应用。



![image](/images/user-guide/integrations/decode/Picture14.png)



## 测试
打开DL28仪表板。通过点击EXIO RL1和GT900 RL1开关控制继电器。指示器显示输出继电器的实际状态，慢速网络可能有延迟。部件CAL_RETURN_TEMP显示热量表的回水温度。



![image](/images/user-guide/integrations/decode/Picture15.png)



## 结论
ThingsBoard是区域供热站设施远程监测与控制的理想平台。该方案在设备、仪表板和部件数量方面具有良好可扩展性，可覆盖整个城市的大型分布式网络。同时也展示了ThingsBoard系统中远程监测控制与抄表相结合的可能性。

更多关于所用产品的详细信息可从其页面和下载页面的手册获取。

如有其他问题请随时联系Decode团队。

## 另见

浏览其他[示例](/device-library/)或查阅与ThingsBoard主要功能相关的指南：

 - [设备属性](/docs/{{docsPrefix}}user-guide/attributes/) — 如何使用设备属性。
 - [遥测数据采集](/docs/{{docsPrefix}}user-guide/telemetry/) — 如何采集遥测数据。
 - [使用RPC能力](/docs/{{docsPrefix}}user-guide/rpc/) — 如何向/从设备发送命令。
 - [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine/) — 如何使用规则引擎分析设备数据。
 - [数据可视化](/docs/{{docsPrefix}}user-guide/visualization/) — 如何可视化采集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/multi-project-guides-banner.md %}
