* TOC
{:toc}

ThingsBoard 规则引擎支持对传入遥测数据进行基本分析，例如  crossing。
规则引擎的设计理念是根据设备属性或数据本身，将 IoT 设备的数据路由到不同插件。
然而，多数实战场景还需要高级分析支持：机器学习、预测分析等。

本教程将演示如何：

 - 使用内置规则引擎能力将遥测设备数据从 ThingsBoard 路由到 Kafka topic（适用于 ThingsBoard CE 和 PE）。
 - 使用简单的 Kafka Streams 应用聚合多设备数据。
 - 通过 ThingsBoard PE Kafka Integration 将分析结果推送回 ThingsBoard 进行持久化和可视化。

本教程中的分析虽然较为简单，但目标是突出集成步骤。

![image](/images/samples/analytics/kafka-streams/kafka-streams-example.svg)

假设我们拥有大量光伏板，每块板包含多个光伏组件。
ThingsBoard 用于收集、存储和可视化每块板中各光伏组件的异常遥测。

我们通过将单个光伏组件的产出值与同板所有组件的平均值及该值的标准**deviation**进行比较来计算异常。

![image](/images/user-guide/integrations/kafka/deviation.png)

我们将使用 30 秒窗口（可配置）的 [Kafka Streams](https://kafka.apache.org/documentation/streams/) 任务分析多设备的实时数据。

为存储和可视化分析结果，我们将为每块光伏板创建三个虚拟光伏组件设备。

## 前置条件

以下服务必须处于运行状态：

* ThingsBoard PE v2.4.2+ [实例](/docs/user-guide/install/pe/installation-options/)
* Kafka [服务器](https://kafka.apache.org/23/documentation/streams/quickstart#quickstart_streams_download)

## 步骤 1. 规则链配置

本步骤将配置三个 generator 节点，用于在开发期间生成模拟测试数据。
生产环境通常不需要它们，但对调试非常有用。我们将为 3 个组件和 1 块板生成数据。
其中两个组件产生相同值，一个组件产生较低值以模拟组件劣化。
当然，您应使用真实设备产生的真实数据替换。此处仅为示例。

创建三个类型为 "solar-module" 的设备。若使用 ThingsBoard PE，可将它们放入新的 "Solar Modules" 分组。

![image](/images/samples/analytics/kafka-streams/solar-module-devices.png) 

现在创建三个设备模拟器，将数据直接推送到本地 Kafka broker。
模拟数据将推送到负责将数据写入 Kafka topic 的 Kafka Rule Node。
先配置 Kafka Rule Node。使用本地 Kafka 服务器（localhost:9092）和 topic "solar-module-raw"。

![image](/images/samples/analytics/kafka-streams/add-kafka-rule-node.png)

为第一个组件添加 "generator" 节点。将该 generator 配置为持续「产生」5 瓦。

![image](/images/samples/analytics/kafka-streams/add-module1-simulator-rule-node.png)

为第二个组件添加 "generator" 节点，同样配置为持续「产生」5 瓦。

为第三个组件添加 "generator" 节点，配置为持续「产生」3.5 瓦，以模拟组件劣化。

![image](/images/samples/analytics/kafka-streams/add-module3-simulator-rule-node.png)

结果规则链应类似如下：

![image](/images/samples/analytics/kafka-streams/simulator-rule-chain.png)

您也可以[下载](/docs/samples/analytics/resources/solar_module_simulator.json)规则链 JSON 文件并[导入](/docs/{{docsPrefix}}user-guide/ui/rule-chains/#rule-import)到项目中。

导入规则链后，请检查 Kafka 节点的调试输出。若 Kafka 在 localhost 正常运行，您应看到类似的调试消息。
注意调试日志中无错误：

![image](/images/samples/analytics/kafka-streams/check-no-errors.png)

## 步骤 2. 启动 Kafka Streams 应用

本步骤将下载并启动示例应用，该应用分析 "solar-module-raw" 的原始数据并输出关于组件劣化的有价值洞察。
示例应用计算时间窗口（可配置）内每块板中各组件的总产能。
然后计算每块板各组件的平均功率及其在同一时间窗口内的 deviation。
完成后，应用将各组件的值与平均值比较，若差值大于 deviation，则视为异常。

异常计算结果推送到 "anomalies-topic"。
ThingsBoard 通过 Kafka Integration 订阅该 topic，生成告警并将异常持久化到数据库。

### 下载示例应用

可从 [ThingsBoard 仓库](https://github.com/thingsboard/kafka-streams-example) 获取代码，并用 maven 构建项目：

```bash
mvn clean install
```

将该 maven 项目添加到您常用的 IDE 中。

### 依赖说明

项目使用的主要依赖：

```xml
<dependencies>
...
    <dependency>
        <groupId>org.apache.kafka</groupId>
        <artifactId>kafka-streams</artifactId>
        <version>${kafka.version}</version>
    </dependency>
...
</dependencies>
```

### 源码说明

Kafka Streams 应用逻辑主要集中于 [SolarConsumer](https://github.com/thingsboard/kafka-streams-example/blob/master/src/main/java/org/thingsboard/kafka/SolarConsumer.java) 类。

```java
private static Properties getProperties() {
    final Properties props = new Properties();
    props.put(StreamsConfig.APPLICATION_ID_CONFIG, "streams");
    props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
    props.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, 0);
    props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
    props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
    props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest");
    return props;
}
```

```java
private static final String IN_TOPIC = "solar-module-raw";

private static final TopicNameExtractor<String, SolarModuleAggregatorJoiner> OUT_TOPIC =
        new StaticTopicNameExtractor<>("solar-module-anomalies");

// Time for windowing
private static final Duration DURATION = Duration.ofSeconds(30);

private static final TimeWindows TIME_WINDOWS = TimeWindows.of(DURATION);

private static final JoinWindows JOIN_WINDOWS = JoinWindows.of(DURATION);

private static final StreamsBuilder builder = new StreamsBuilder();


// serde - Serializer/Deserializer
// for custom classes should be custom Serializer/Deserializer
private static final Serde<SolarModuleData> SOLAR_MODULE_DATA_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleData.class));

private static final Serde<SolarModuleAggregator> SOLAR_MODULE_AGGREGATOR_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleAggregator.class));

private static final Serde<SolarPanelAggregator> SOLAR_PANEL_AGGREGATOR_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarPanelAggregator.class));

private static final Serde<SolarModuleKey> SOLAR_MODULE_KEY_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleKey.class));

private static final Serde<SolarPanelAggregatorJoiner> SOLAR_PANEL_AGGREGATOR_JOINER_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarPanelAggregatorJoiner.class));

private static final Serde<SolarModuleAggregatorJoiner> SOLAR_MODULE_AGGREGATOR_JOINER_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleAggregatorJoiner.class));

private static final Serde<String> STRING_SERDE = Serdes.String();

private static final Serde<Windowed<String>> WINDOWED_STRING_SERDE = Serdes.serdeFrom(
    new TimeWindowedSerializer<>(STRING_SERDE.serializer()),
    new TimeWindowedDeserializer<>(STRING_SERDE.deserializer(), TIME_WINDOWS.size()));

// 1 - sigma
private static final double Z = 1;
```

```java
// source stream from kafka
final KStream<SolarModuleKey, SolarModuleData> source =
    builder
        .stream(IN_TOPIC, Consumed.with(STRING_SERDE, SOLAR_MODULE_DATA_SERDE))
        .map((k, v) -> KeyValue.pair(new SolarModuleKey(v.getPanel(), v.getName()), v));


// calculating sum power and average power for modules
final KStream<Windowed<SolarModuleKey>, SolarModuleAggregator> aggPowerPerSolarModuleStream =
     source
        .groupByKey(Grouped.with(SOLAR_MODULE_KEY_SERDE, SOLAR_MODULE_DATA_SERDE))
        .windowedBy(TIME_WINDOWS)
        .aggregate(SolarModuleAggregator::new,
            (modelKey, value, aggregation) -> aggregation.updateFrom(value),
            Materialized.with(SOLAR_MODULE_KEY_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE))
        .suppress(Suppressed.untilTimeLimit(DURATION, Suppressed.BufferConfig.unbounded()))
        .toStream();


// calculating sum power and average power for panels
final KStream<Windowed<String>, SolarPanelAggregator> aggPowerPerSolarPanelStream =
    aggPowerPerSolarModuleStream
        .map((k, v) -> KeyValue.pair(new Windowed<>(k.key().getPanelName(), k.window()), v))
        .groupByKey(Grouped.with(WINDOWED_STRING_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE))
        .aggregate(SolarPanelAggregator::new,
            (panelKey, value, aggregation) -> aggregation.updateFrom(value),
            Materialized.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE))
        .suppress(Suppressed.untilTimeLimit(DURATION, Suppressed.BufferConfig.unbounded()))
        .toStream();


 // if used for join more than once, the exception "TopologyException: Invalid topology:" will be thrown
final KStream<Windowed<String>, SolarModuleAggregator> aggPowerPerSolarModuleForJoinStream =
    aggPowerPerSolarModuleStream
        .map((k, v) -> KeyValue.pair(new Windowed<>(k.key().getPanelName(), k.window()), v));


// joining aggregated panels with aggregated modules
// need for calculating sumSquare and deviance
final KStream<Windowed<String>, SolarPanelAggregatorJoiner> joinedAggPanelWithAggModule =
    aggPowerPerSolarPanelStream
        .join(
            aggPowerPerSolarModuleForJoinStream,
            SolarPanelAggregatorJoiner::new, JOIN_WINDOWS,
            Joined.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE));


//calculating sumSquare and deviance
final KStream<Windowed<String>, SolarPanelAggregator> aggPowerPerSolarPanelFinalStream =
    joinedAggPanelWithAggModule
        .groupByKey(Grouped.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_JOINER_SERDE))
        .aggregate(SolarPanelAggregator::new,
            (key, value, aggregation) -> aggregation.updateFrom(value),
            Materialized.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE))
        .suppress(Suppressed.untilTimeLimit(DURATION, Suppressed.BufferConfig.unbounded()))
        .toStream();


// joining aggregated modules with aggregated panels in which calculated sumSquare and deviance
// need for check modules with anomaly power value
final KStream<Windowed<String>, SolarModuleAggregatorJoiner> joinedAggModuleWithAggPanel =
    aggPowerPerSolarModuleStream
        .map((k, v) -> KeyValue.pair(new Windowed<>(k.key().getPanelName(), k.window()), v))
        .join(
            aggPowerPerSolarPanelFinalStream,
            SolarModuleAggregatorJoiner::new, JOIN_WINDOWS,
            Joined.with(WINDOWED_STRING_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE));


// streaming result data (modules with anomaly power value)
joinedAggModuleWithAggPanel
    .filter((k, v) -> isAnomalyModule(v))
    .map((k, v) -> KeyValue.pair(k.key(), v))
    .to(OUT_TOPIC, Produced.valueSerde(SOLAR_MODULE_AGGREGATOR_JOINER_SERDE));


// starting streams
final KafkaStreams streams = new KafkaStreams(builder.build(), getProperties());
streams.cleanUp();
streams.start();
Runtime.getRuntime().addShutdownHook(new Thread(streams::close));
```


**计算异常数据**

![image](/images/user-guide/integrations/kafka/latex.png)
 
```java
private static boolean isAnomalyModule(SolarModuleAggregatorJoiner module) {
    double currentZ = Math.abs(module.getSumPower() - module.getSolarPanelAggregator().getAvgPower()) / module.getSolarPanelAggregator().getDeviance();
    return currentZ > Z;
}
```

**示例应用输出**

```text
...SolarConsumer - PerSolarModule: [1572447720|Panel 1|Module 1]: 30.0:6
...SolarConsumer - PerSolarModule: [1572447720|Panel 1|Module 2]: 30.0:6
...SolarConsumer - PerSolarModule: [1572447720|Panel 1|Module 3]: 21.0:6
...SolarConsumer - PerSolarPanel: [1572447690|Panel 1]: 81.0:3
...SolarConsumer - PerSolarPanelFinal: [1572447660|Panel 1]: power:81.0 count:3 squareSum:54.0 variance:18.0 deviance:4.2
...SolarConsumer - ANOMALY module: [1572447660|Panel 1|Module 3]: sumPower:21.0 panelAvg:27.0 deviance:4.2
```

## 步骤 3. 配置 Kafka Integration

将 ThingsBoard 配置为订阅 “solar-module-anomalies” topic 并创建告警。我们将使用自 ThingsBoard v2.4.2 起可用的 Kafka Integration。

### 配置 Uplink 转换器

在设置 Kafka integration 前，需创建 Uplink 数据转换器。Uplink 数据转换器负责解析传入的异常数据。 

由 Kafka Streams 应用产生的传入消息示例：
```json
{
    "moduleName": "Module 3",
    "panelName": "Panel 1",
    "count": 6,
    "sumPower": 21.0,
    "avgPower": 3.5,
    "solarPanelAggregator": {
        "panelName": "Panel 1",
        "count": 3,
        "sumPower": 81.0,
        "avgPower": 27.0,
        "squaresSum": 54.0,
        "variance": 18.0,
        "deviance": 4.2
    }
}
``` 

以下脚本粘贴到 Decoder 函数区域：

```javascript
// Decode an uplink message from a buffer
// payload - array of bytes
// metadata - key/value object

/** Decoder **/

// decode payload to string
var msg = decodeToJson(payload);

// decode payload to JSON
// var data = decodeToJson(payload);

var deviceName = msg.moduleName;
var deviceType = 'module';

// Result object with device attributes/telemetry data
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
       panel: msg.panelName
   },
   telemetry: {
       avgPower: msg.avgPower,
       sumPower: msg.sumPower,
       avgPowerFromPanel: msg.solarPanelAggregator.avgPower,
       deviance: msg.solarPanelAggregator.deviance
   }
};

/** Helper functions **/

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   // covert payload to string.
   var str = decodeToString(payload);

   // parse string to JSON
   var data = JSON.parse(str);
   return data;
}

return result;
```
{: .copy-code}

decoder 函数的作用是将传入数据和元数据解析为 ThingsBoard 可使用的格式。
**deviceName** 和 **deviceType** 为必填，**attributes** 和 **telemetry** 为可选。
**attributes** 和 **telemetry** 为扁平键值对象，不支持嵌套对象。

![image](/images/samples/analytics/kafka-streams/add-converter.png)

### 配置 Kafka Integration

创建 Kafka integration ，订阅 “solar-module-anomalies” topic。

![image](/images/samples/analytics/kafka-streams/add-integration.png)

## 步骤 4. 配置规则引擎以创建告警

按照现有的[「创建和清除告警」](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/)指南，根据传入遥测中的 "anomaly" 布尔标志创建告警，并参考[「告警时发送邮件」](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)指南发送邮件通知。
探索其他[指南](/docs/{{docsPrefix}}guides/)以了解更多。

## 步骤 5. 关闭调试消息日志

尽管 Debug 模式在开发和故障排查时非常有用，但将其在生产环境中保持启用会显著增加数据库占用的磁盘空间，因为所有调试数据都会存储其中。
强烈建议在完成调试后关闭 Debug 模式。

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
