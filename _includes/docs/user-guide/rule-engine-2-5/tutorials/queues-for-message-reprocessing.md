* TOC
{:toc}

## 应用场景

假设您的设备正在向ThingsBoard发送温度和湿度数据。我们将使用Rest API调用节点模拟将消息发送到外部服务器。

在本教程中，我们将配置ThingsBoard规则引擎，使用具有「重试失败和超时消息」处理策略的队列。
尽管该场景为虚构示例，您将学习如何使用队列在发生处理失败或超时时允许消息重处理，并在实际应用中运用该知识。

## 前置条件

我们假定您已完成以下指南并阅读了所列文章：

  * [快速入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  
此外，您需要在环境中至少预置一个设备。

## 步骤 1：创建规则链

![image](/images/user-guide/rule-engine-2-5/tutorials/reprocessing_rule_chain.png)

我们将添加一个 **「生成器」** 节点，以 1 秒延迟模拟 6 条消息。

![image](/images/user-guide/rule-engine-2-5/tutorials/generator_reprocessing.png)

所有消息将被放入名为 **「HighPriority」** 的队列。该队列使用名为 **「RETRY_FAILED_AND_TIMED_OUT」** 的消息处理策略
{% unless docsPrefix contains "paas/" %}（详见[**配置指南**](/docs/user-guide/install/{{docsPrefix}}config/)）{% endunless %}，即失败或超时的消息将被重新处理。

![image](/images/user-guide/rule-engine-2-5/tutorials/checkpoint_reprocessing.png)

最后，消息将被发送到外部服务器。

![image](/images/user-guide/rule-engine-2-5/tutorials/rest_api.png)

## 步骤 2：配置外部服务器

假设我们有一台用于接收消息的服务器。我们已在Spring Boot应用中创建了一个简单的Controller。
此外，我们模拟了每第三条消息处理失败。

```java
@RestController
@RequestMapping("/api/v1/test")
@Slf4j
public class Controller {

    private AtomicLong atomicLong = new AtomicLong(0);

    @RequestMapping(value = {"/"}, headers = "Content-Type=application/json", method = {RequestMethod.POST})
    @ResponseStatus(value = HttpStatus.OK)
    public DeferredResult<ResponseEntity> processRequest(@RequestBody JsonNode msg) {
        DeferredResult<ResponseEntity> deferredResult = new DeferredResult<>();

        log.info("Received message: {}", msg);

        long counter = atomicLong.incrementAndGet();
        if (counter % 3 == 0) {
            log.warn("Bad request: {}", msg);
            deferredResult.setResult(new ResponseEntity<>("Bad Request", HttpStatus.BAD_REQUEST));
        } else {
            log.info("Success: {}", msg);
            deferredResult.setResult(new ResponseEntity<>("Ok", HttpStatus.OK));
        }

        return deferredResult;
    }
}
```

## 步骤 3：验证规则链逻辑

保存规则链并启动外部服务器以验证我们的逻辑是否正确。生成器将开始产生消息：

**「Checkpoint」** 节点接收了六条消息：

![image](/images/user-guide/rule-engine-2-5/tutorials/checkpoint_reprocessing_events.png)

我们可以看到，下一个Rest API调用节点 **「Send Request」** 处理了八条消息。

![image](/images/user-guide/rule-engine-2-5/tutorials/rest_api_events.png)

每第三条消息（初始六条中的两条）处理失败。

![image](/images/user-guide/rule-engine-2-5/tutorials/error_event.png)

最后两条消息是经过重处理的消息（之前失败的消息）。
这说明我们的逻辑正确无误。

## 快速总结

下载并导入本教程附带的规则链 JSON [**文件**](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/resources/send_request_rule_chain.json)。
别忘了在生成器节点中填写您的具体设备。

## 下一步

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}
