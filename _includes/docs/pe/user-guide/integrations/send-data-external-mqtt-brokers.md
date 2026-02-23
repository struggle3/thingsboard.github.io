{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

本教程演示如何通过旋钮控制部件向外部MQTT broker发送数据。

* TOC
{:toc}

## 用例

假设您的设备用于控制温度，希望借助ThingsBoard将其用作外部MQTT broker。

本教程将配置ThingsBoard规则引擎，使其通过MQTT协议自动发送消息。您可将本教程作为更复杂任务的基础。

MQTT集成可将现有协议和负载格式转换为ThingsBoard消息格式，适用于多种部署场景：

  - 从外部系统、IoT平台或连接提供商后端流式传输设备和/或资产数据。
  - 从云上运行的自定义应用流式传输设备和/或资产数据。
  - 将采用自定义基于MQTT协议的现有设备连接至ThingsBoard。
  
请参阅集成示意图了解更多。 
 
  ![image](/images/user-guide/integrations/mqtt-integration.svg)

## 前置条件

我们假设您已完成以下指南并阅读了以下文章：

  * [入门指南](/docs/{{docsPrefix}}getting-started-guides/helloworld/)。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  * [MQTT集成](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/)。
  * [数据转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#data-converters)。

## 模型定义
  
我们将操作名为「Thermostat-A」、类型为「thermostat」的温度传感器设备，该设备将在集成运行过程中自动创建。

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-device.png)

## 入门

### 创建转换器

为使集成正常工作，需创建下行和上行转换器。

- 进入**Data Converters** -> **Add new Data Converter** -> **Import Converter** 

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/import_new_converter.png)

- Import following files: [**uplink converter**](/docs/user-guide/resources/sensor_uplink_converter.json),
 [**downlink converter**](/docs/user-guide/resources/sensor_downlink_converter.json).

You can check them like this:

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-check-converters.png)

Uplink converter should look like this:

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-uplink-converter.png) 

Downlink converter should look like this:

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-downlink-converter.png)


### 创建集成

集成需使用远程服务器。本例可使用iot.eclipse.org作为MQTT数据源。
集成配置如下：

- 进入**Integrations** -> **Add new Integration**

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/add-new-integration.png)

- Fill in the fields with the input data shown in the following table: 

<table>
  <thead>
      <tr>
          <td><b>Field</b></td><td><b>Input Data</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Name</td>
          <td>Thermostat MQTT integration</td>
      </tr>
      <tr>
          <td>Type</td>
          <td>MQTT</td>
      </tr>
      <tr>
          <td>Debug mode</td>
          <td>False</td>
      </tr>
      <tr>
          <td>Uplink data converter</td>
          <td>Sensor Uplink Converter</td>
      </tr>
      <tr>
          <td>Downlink data converter</td>
          <td>Sensor Downlink Converter</td>
      </tr>
      <tr>
          <td>Host</td>
          <td>iot.eclipse.org</td>
      </tr>
      <tr>
          <td>Port</td>
          <td>1883</td>
      </tr>
      <tr>
          <td>Connection timeout(sec)</td>
          <td>10</td>
      </tr>
      <tr>
          <td>Client ID</td>
          <td>(empty)</td>
      </tr>
      <tr>
          <td>Clean session</td>
          <td>True</td>
      </tr>
      <tr>
          <td>Enable SSL</td>
          <td>False</td>
      </tr>
      <tr>
          <td>Credentials</td>
          <td>Anonymous</td>
      </tr>
      <tr>
          <td>Topic filters</td>
          <td>devices/Thermostat-A/temperature/latest</td>
      </tr>
      <tr>
          <td>QOS</td>
          <td>At most once</td>
      </tr>
      <tr>
          <td>Topic filters</td>
          <td>devices/Thermostat-A/temperature/settings/</td>
      </tr>
      <tr>
                <td>QOS</td>
           <td>At most once</td>
      </tr>
      <tr>
         <td>Downlink topic pattern</td>
         <td>${topic}</td>
      </tr>
      <tr>
          <td>Description</td>
          <td>(empty)</td>
      </tr>
      <tr>
          <td>Metadata</td>
          <td>(empty)</td>
      </tr>
   </tbody>
</table> 

- After filling all fields click the **ADD** button. 

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-create-integration-1.png)
![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-create-integration-2.png)

### 配置仪表板

下载并[**导入**](/docs/{{docsPrefix}}user-guide/ui/dashboards/#dashboard-import)本教程的仪表板JSON[**文件**](/docs/user-guide/resources/temperature_control_dashboard.json)。

### 启动设备模拟器

为使部件在没有真实设备的情况下工作，需启动模拟器。

First, you should check if node, npm and npm module mqtt are installed by using following commands:

```bash
#to display node version
node -v
#to display npm version
npm -v
#to display npm mqtt module version
npm list mqtt 
```

If you don't have npm, you can install it from  [here](https://www.npmjs.com/package/npm),
and npm MQTT module with following command:

```bash
sudo npm install mqtt --save
```

and node from [here](https://nodejs.org/en/download/).

Download the [**file**](/docs/user-guide/resources/mqtt-downlink-virtual-device.js) and run it with following 
command to launch device emulator: 

```bash
node mqtt-downlink-virtual-device.js
```

Note: device emulator should be put in the folder where node-modules is situated.


### 效果演示

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-work-demonstration.png) 

使用控制部件（本例为旋钮）会导致仪表板上的值发生变化。

仪表板可从[**此处**](/docs/user-guide/resources/temperature_control_dashboard.json)获取，并可按[**此方式**](/docs/{{docsPrefix}}user-guide/ui/dashboards/#dashboard-import)导入。

## 消息流

本节说明本教程中每个节点的作用。 

### Modifying rule chain

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-root-rule-chain.png) 

  * **节点A**：Originator attributes enrichment节点
      
    * 将客户端属性deviceName写入metadata
    
   ![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-node-A.png) 
    
  * **节点B**：Script Transformation节点
      
     * 将metadata中的deviceName写入消息参数
     
    ![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-node-B.png)

  * **节点C**：Integration Downlink节点
  
    * 将消息发送至集成
    
    ![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-node-C.png) 

可下载并[**导入**](/docs/{{docsPrefix}}user-guide/ui/rule-chains/#rule-chains-importexport)本教程的规则链JSON[**文件**](/docs/user-guide/resources/mqtt-downlink-root-rule-chain.json)。
该规则链需标记为root。
 

## 下一步

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}
