---
layout: docwithnav-gw
title: IoT Gateway 自定义

---


* TOC
{:toc}

本部分文档可帮助您自定义 IoT Gateway 以满足特定需求。
网关中有“扩展”（extensions），用于自定义网关、添加自有连接器或转换器。  
扩展的一般使用方式如下：
1. 在网关扩展目录中创建包含您扩展的文件。（扩展所在文件夹名称即为连接器类型）
2. 将扩展添加到网关的配置文件中：  

    2.1. 自定义连接器：将连接器添加到主配置（tb_gateway.json）的「connectors」部分。例如：  
    ```
    ...
    "connectors": [
        {
             "name": "Custom connector name",
             "type": "folder_name_with_your_connector",
             "class": "NameOfYourConnectorClass",
             "configuration": "configuration_file_name_for_your_connector_in_config_folder.json"
        }
    ]
    ```  
    {:.copy-code}
    
    2.2. 自定义转换器：取决于连接器实现，通常需在连接器配置中添加「converter」参数。  
         可在对应连接器的配置文档中获取更多信息。  
         下方为 MQTT 和 OPCUA 连接器的配置示例。  
    
    MQTT:
    
    ```
    ...
    "topicFilter": "custom/sensors/+",
    "converter": {
    "type": "custom",
    "extension": "CustomMqttUplinkConverter",
    "cached": true,
    "extension-config": {
        "temperatureBytes": 2,
        "humidityBytes": 2,
        "batteryLevelBytes": 1
      }
    }
    ...
    ```  
    
    OPCUA:
      
    ```
    ...
    "mapping": [
      {
      "deviceNodePattern": "Root\\.Objects\\.Device1",
      "deviceNamePattern": "Device ${Root\\.Objects\\.Device1\\.serialNumber}",
      "converter": "CustomOpcUaConverter",
      "attributes": [
        {
          "key": "temperature °C",
          "path": "${ns=2;i=5}"
        }
      ],
      ...
    ...
    ```

3. 应用更改：需重启网关（若添加连接器）或连接器（若添加转换器）。  

本部分包含以下文章以帮助您完成自定义：  

1. [方法及数据类型](methods-and-datatypes.md) - 介绍 IoT Gateway 中使用的方法和数据类型。
    可帮助理解 IoT Gateway 中数据与方法的流转。  
2. [串口连接器](serial-connector.md) - 介绍如何为 IoT Gateway 创建串口连接器及其转换器。
    包含自定义连接器、转换器及使用步骤。  

