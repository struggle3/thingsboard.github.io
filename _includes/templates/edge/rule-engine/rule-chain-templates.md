### 什么是 Edge 规则链模板？

**Edge 规则链模板**是 **ThingsBoard** 中预定义的 [Rule Chain](/docs/user-guide/rule-engine-2-0/overview/#rule-chain){: target="_blank"}，专为与 **ThingsBoard Edge** 配合使用而设计。
**规则链模板**不会在 **Server** 上运行。
它仅作为模板使用。

对于 **较早版本的 ThingsBoard Edge**，使用前需先将 **规则链** 分配给 **Edge** 实例。分配后才会生效并按配置处理设备数据。

从 **Edge 4.0** 版起，可直接在 **Edge** 实例上创建和编辑 **规则链**。

### 在 Edge 上创建规则链模板

{% assign sinceVersion = "4.0" %}
{% include templates/edge/since-edge.md %}

{% assign createRuleChainTemplatePE = '
    ===
        image: /images/pe/edge/rule-engine/1-edge-rule-chain.webp,
        title: 登录 <b>ThingsBoard Edge PE</b> 实例，进入 <b>Rule chains</b> 部分。要添加新 <b>规则链</b>，点击右上角 <b>"+"</b> 按钮，选择 <b>"Create new rule chain"</b> 选项。
    ===
        image: /images/pe/edge/rule-engine/2-create-rule-chain-template.webp,
        title: 在弹出窗口中输入新规则链的 <b>name</b>，点击 <b>"Add"</b> 按钮继续配置规则链。
    ===
        image: /images/pe/edge/rule-engine/3-in-the-list.webp,
        title: 规则链已出现在列表中，通常位于顶部。点击即可开始编辑。
    ===
        image: /images/pe/edge/rule-engine/4-configure-and-safe.webp,
        title: 配置 <a href="/docs/pe/user-guide/rule-engine-2-0/overview/#rule-node" target="_blank">rule nodes</a> 和流程。配置完成后，点击 <b>"Apply changes"</b> 按钮。
'%}

{% assign createRuleChainTemplateCE = '
    ===
        image: /images/edge/rule-engine/1-edge-rule-chain.webp,
        title: 登录 <b>ThingsBoard Edge CE</b> 实例，进入 <b>Rule chains</b> 部分。要添加新 <b>规则链</b>，点击右上角 <b>"+"</b> 按钮，选择 <b>"Create new rule chain"</b> 选项。
    ===
        image: /images/edge/rule-engine/2-create-rule-chain-template.webp,
        title: 在弹出窗口中输入新规则链的 <b>name</b>，点击 <b>"Add"</b> 按钮继续配置规则链。
    ===
        image: /images/edge/rule-engine/3-in-the-list.webp,
        title: 规则链已出现在列表中，通常位于顶部。点击即可开始编辑。
    ===
        image: /images/edge/rule-engine/4-configure-and-safe.webp,
        title: 配置 <a href="/docs/user-guide/rule-engine-2-0/overview/#rule-node" target="_blank">rule nodes</a> 和流程。配置完成后，点击 <b>"Apply changes"</b> 按钮。
'%}

{% if docsPrefix == "pe/edge/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=createRuleChainTemplatePE %}
{% else %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=createRuleChainTemplateCE %}
{% endif %}

### 在服务器上创建规则链模板

{% assign createRuleChainTemplatePE = '
    ===
        image: /images/pe/edge/rule-engine/create-rule-chain-template-step-1.webp,
        title: 登录 <b>ThingsBoard PE</b> 实例，进入 <b>Edge Management > Rule chain templates</b> 部分。要添加新 <b>规则链</b>，点击右上角 <b>"+"</b> 按钮，选择 <b>"Create new rule chain"</b> 选项。
    ===
        image: /images/pe/edge/rule-engine/create-rule-chain-template-step-2.webp,
        title: 输入规则链名称，如 <b>"Remote Farm"</b>。点击 <b>"Add"</b> 按钮继续配置规则链。
    ===
        image: /images/pe/edge/rule-engine/create-rule-chain-template-step-3.webp,
        title: 规则链模板已出现在列表中，通常位于顶部。点击即可开始编辑。
    ===
        image: /images/pe/edge/rule-engine/create-rule-chain-template-step-4.webp,
        title: 在模板内配置 <a href="/docs/pe/user-guide/rule-engine-2-0/overview/#rule-node" target="_blank">rule nodes</a> 和流程。配置完成后，点击 <b>"Apply changes"</b> 按钮。<i>注意：此步骤不会在服务器上激活规则链，仅为部署到 Edge 做准备。</i>
'%}

{% assign createRuleChainTemplateCE = '
    ===
        image: /images/edge/rule-engine/create-rule-chain-template-step-1.webp,
        title: 登录 <b>ThingsBoard CE</b> 实例，进入 <b>Edge Management > Rule chain templates</b> 部分。要添加新 <b>规则链</b>，点击右上角 <b>"+"</b> 按钮，选择 <b>"Create new rule chain"</b> 选项。
    ===
        image: /images/edge/rule-engine/create-rule-chain-template-step-2.webp,
        title: 输入规则链名称，如 <b>"Remote Farm"</b>。点击 <b>"Add"</b> 确认创建新规则链模板。
    ===
        image: /images/edge/rule-engine/create-rule-chain-template-step-3.webp,
        title: 规则链模板已出现在列表中，通常位于顶部。点击即可开始编辑。
    ===
        image: /images/edge/rule-engine/create-rule-chain-template-step-4.webp,
        title: 在模板内配置 <a href="/docs/user-guide/rule-engine-2-0/overview/#rule-node" target="_blank">rule nodes</a> 和流程。配置完成后，点击 <b>"Apply changes"</b> 按钮。<i>注意：此步骤不会在服务器上激活规则链，仅为部署到 Edge 做准备。</i>
'%}

{% if docsPrefix == "pe/edge/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=createRuleChainTemplatePE %}
{% else %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=createRuleChainTemplateCE %}
{% endif %}

### 将规则链模板分配给 Edge

{% assign assignRuleChainTemplateToEdgePE = '
    ===
        image: /images/pe/edge/rule-engine/assign-rule-chain-template-step-1.webp,
        title: 进入 <b>Edge management > Instances</b> 部分，点击 <b>"Manage rule chains"</b> 按钮。
    ===
        image: /images/pe/edge/rule-engine/assign-rule-chain-template-step-2.webp,
        title: 要将规则链模板分配给 Edge，点击 <b>"+"</b> 按钮。
    ===
        image: /images/pe/edge/rule-engine/assign-rule-chain-template-step-3.webp,
        title: 在弹出窗口中从下拉菜单选择规则链，点击 <b>"Assign"</b> 按钮。
    ===
        image: /images/pe/edge/rule-engine/assign-rule-chain-template-step-4.webp,
        title: 已分配的规则链模板将显示在列表顶部。将规则链模板分配给 Edge 实例后，规则链将根据模板配置处理 Edge 设备的数据。
'%}

{% assign assignRuleChainTemplateToEdgeCE = '
    ===
        image: /images/edge/rule-engine/assign-rule-chain-template-step-1.webp,
        title: 进入 <b>Edge management > Instances</b> 部分，点击 <b>"Manage edge rule chains"</b> 按钮。
    ===
        image: /images/edge/rule-engine/assign-rule-chain-template-step-2.webp,
        title: 要将规则链模板分配给 Edge，点击 <b>"+"</b> 按钮。
    ===
        image: /images/edge/rule-engine/assign-rule-chain-template-step-3.webp,
        title: 在弹出窗口中从下拉菜单选择规则链，点击 <b>"Assign"</b> 按钮。
    ===
        image: /images/edge/rule-engine/assign-rule-chain-template-step-4.webp,
        title: 已分配的规则链模板将显示在列表顶部。将规则链模板分配给 Edge 实例后，规则链将根据模板配置处理 Edge 设备的数据。
'%}

{% if docsPrefix == "pe/edge/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=assignRuleChainTemplateToEdgePE %}
{% else %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=assignRuleChainTemplateToEdgeCE %}
{% endif %}

## 在 Edge 上验证已分配的规则链

{% assign verifyRuleChainPE = '
    ===
        image: /images/pe/edge/rule-engine/verify-rule-chain-template-step-1.webp,
        title: 登录 <b>ThingsBoard Edge PE</b> 实例，进入 <b>Rule chains</b> 部分。要查看规则链配置，点击该规则链。
    ===
        image: /images/pe/edge/rule-engine/verify-rule-chain-template-step-2.webp,
        title: 确认所有设置和配置已正确反映。
'%}

{% assign verifyRuleChainCE = '
    ===
        image: /images/edge/rule-engine/verify-rule-chain-template-step-1.webp,
        title: 登录 <b>ThingsBoard Edge PE</b> 实例，进入 <b>Rule chains</b> 部分。要查看规则链配置，点击该规则链。
    ===
        image: /images/edge/rule-engine/verify-rule-chain-template-step-2.webp,
        title: 确认所有设置和配置已正确反映。
'%}

{% if docsPrefix == "pe/edge/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=verifyRuleChainPE %}
{% else %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=verifyRuleChainCE %}
{% endif %}
