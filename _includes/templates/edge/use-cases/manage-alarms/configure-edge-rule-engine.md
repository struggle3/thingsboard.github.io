我们将更新「Edge Root Rule Chain」，使其处理「DHT22」传感器的 **Alarm Created** 事件，并向「空调」设备发送相应命令。
以下是 Edge root 规则链的最终配置：

{% include images-gallery.html imageCollection="rootRuleChainPreview" %}

下一步将创建 **TBEL** 脚本语言节点，以生成向 **空调** 设备发送的 RPC 命令。
用于模拟开启空调的脚本节点 JavaScript 代码：

{% highlight javascript %}
var newMsg = {};
newMsg.method = "enabled_air_conditioner";
newMsg.params = {"speed": 1.0};
return { msg: newMsg, metadata: metadata, msgType: msgType }; {% endhighlight %}

若需要，请在后续步骤中使用此代码片段。

以下为将默认 Edge「Root Rule Chain」更新为上述规则链的步骤：

{% include images-gallery.html imageCollection="updateRootRuleChain" showListImageTitles="true" %}

现在打开 ThingsBoard **Edge** UI 查看更新后的 root 规则链：

{% include images-gallery.html imageCollection="updateRootRuleChainEdge" showListImageTitles="true" %}
