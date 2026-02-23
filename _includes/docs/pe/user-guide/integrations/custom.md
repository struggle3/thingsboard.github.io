{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 简介

Custom集成**仅在主ThingsBoard实例上远程执行**。它允许创建使用自定义配置的集成，可选用任意传输协议与设备通信。

本指南提供创建并启动ThingsBoard custom integration的逐步说明。
例如，我们将启动使用TCP传输协议的custom integration，从设备流式传输数据并将转换后的数据推送到[{{hostName}}](https://{{hostName}}/signup)。

开始前，可在[此处](https://github.com/thingsboard/remote-integration-example)找到本指南将使用的custom integration示例完整代码。
 
## 前置条件

我们假定您已在自己的 ThingsBoard PE v2.4.1+ 实例或 {{hostName}} 上拥有租户管理员账户。

Let’s assume that we have a sensor which is sending current temperature, humidity and battery level readings respectively in the following format: **“25,40,94”**.
 
## Uplink and Downlink Converters

Before setting up a custom integration, you need to create an Uplink and a Downlink converters.

### 上行转换器

创建uplink converter。

![image](/images/user-guide/integrations/remote/custom-converter.gif)

**注意**：尽管 Debug mode 对开发和故障排查很有用，但在生产模式下保持启用会大幅增加数据库占用的磁盘空间，因所有调试数据都会存储其中。
强烈建议调试完成后关闭 Debug mode。 

以下为粘贴到Decoder function区域的脚本：

```javascript
/** Decoder **/

// decode payload to string
var decodedString = decodeToString(payload);
// remove unnecessary [\"] and split by [,] to get an array
var payloadArray = decodedString.replace(/\"/g, "").split(',');
var result = {
    deviceName: "Device A",
    deviceType: "type",
    telemetry: {
        // get each reading from the array and convert the string value to a number
        temperature: Number(payloadArray[0]),
        humidity: Number(payloadArray[1]),
        batteryLevel: Number(payloadArray[2])
    },
    attributes: {}
};

/** Helper functions **/

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   // convert payload to string.
   var str = decodeToString(payload);

   // parse string to JSON
   var data = JSON.parse(str);
   return data;
}

return result;
``` 

decoder函数用于将传入数据和metadata解析为ThingsBoard可消费的格式。
**deviceName**和**deviceType**为必填，**attributes**和**telemetry**为可选。
**Attributes**和**telemetry**为扁平键值对象，不支持嵌套对象。

### Downlink Converter

本指南中不会使用 Downlink converter，因此无需创建。
若有其他使用场景，请参阅以下 [说明](/docs/{{peDocsPrefix}}user-guide/integrations/#downlink-data-converter)。
 
## Custom Integration 配置
 
创建 custom integration。

![image](/images/user-guide/integrations/remote/custom-integration.gif)

选择 **Custom** 类型并启用 **Debug mode** 时，**Execute remotely** 会自动启用。

**Integration class** 用于通过 Java 反射方法创建 integration 实例。

**Integration JSON configuration** 为自定义配置，本示例中包含两个字段：
- **port**：用于绑定 TCP 服务端与客户端通信
- **msgGenerationIntervalMs**：消息生成的间隔

我们将在本指南后续部分回到此配置。

## Custom Integration 应用

### 下载示例应用

可从 [ThingsBoard 仓库](https://github.com/thingsboard/remote-integration-example) 获取代码，并用 maven 构建项目：

```bash
mvn clean install
```

将 maven 项目添加到您常用的 IDE 中。

### 依赖概览

项目中使用的主要依赖：

```xml
<!-- Api ThingsBoard provides to create custom integration -->
<dependency>
    <groupId>org.thingsboard.common.integration</groupId>
    <artifactId>remote-integration-api</artifactId>
    <version>${thingsboard.version}</version>
</dependency>
<!-- Netty for TCP client-server implementation -->
<dependency>
    <groupId>io.netty</groupId>
    <artifactId>netty-all</artifactId>
    <version>${netty.version}</version>
</dependency>
<!-- Grpc transport between remote integration and ThingsBoard -->
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-netty</artifactId>
    <version>${grpc.version}</version>
</dependency>
```

### Source code review

Main source code is the [CustomIntegration](https://github.com/thingsboard/remote-integration-example/blob/master/src/main/java/org/thingsboard/integration/custom/basic/CustomIntegration.java) Java class.
Integration is expecting "Hello to ThingsBoard" message from the TCP client and replies with the "Hello from ThingsBoard!".
Once the [client emulator](https://github.com/thingsboard/remote-integration-example/blob/master/src/main/java/org/thingsboard/integration/custom/client/CustomClient.java) receives "Hello from ThingsBoard!"
, it will start sending auto-generated data to ThingsBoard in the following format: **“25,40,94”**. 
The Integration will pass the incoming message as-is to the [uplink converter](/docs/{{peDocsPrefix}}user-guide/integrations/custom/#uplink-converter) and push data to ThingsBoard.

**注意**：自 ThingsBoard 3.3.1 起，tb-remote-integration.yml 中新增了必需配置属性：

```yml
service:
  type: "${TB_SERVICE_TYPE:tb-integration}"
```

若使用旧版 custom remote integration，并计划将 custom integration 升级至 3.3.1，请确保已在 tb-remote-integration.yml 文件中添加该属性。

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
