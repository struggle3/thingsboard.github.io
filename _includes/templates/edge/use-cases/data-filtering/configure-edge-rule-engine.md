我们将更新「Edge Root Rule Chain」，使其在 Edge 上保存 10 个传感器读数。在规则链中添加规则节点，用于转换传入消息，仅将包含 distance 读数的消息推送至云端。以下是 Edge root 规则链的最终配置：

{% include images-gallery.html imageCollection="rootRuleChainPreview" %}

下一步将创建 [TBEL](https://thingsboard.io/docs/user-guide/tbel/) 节点进行数据过滤。[TBEL](https://thingsboard.io/docs/user-guide/tbel/) 脚本语言节点将创建空对象 *newMsg*，
添加名为「distance」的属性，其值来自「In-vehicle monitoring system」，然后将 *newMsg* 作为新消息发送。

{% highlight javascript %}
var newMsg = {};
newMsg.distance = msg.distance;
return { msg: newMsg, metadata: metadata, msgType: msgType }; {% endhighlight %}

以下为使用所提供的规则链更新默认 Edge「Root Rule Chain」的步骤：

{% include images-gallery.html imageCollection="updateRootRuleChain" showListImageTitles="true" %}

现在打开 ThingsBoard **Edge** UI 查看更新后的 Root Rule Chain：

{% include images-gallery.html imageCollection="updateRootRuleChainEdge" showListImageTitles="true" %}

