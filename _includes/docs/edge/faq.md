<style>
.edge-faq-wrapper { padding: 20px 15px 80px; max-width: 1200px; margin: 0 auto; }
.edge-faq-sections { display: flex; gap: 40px; }
@media (max-width: 1200px) { .edge-faq-sections { flex-direction: column; } }
.edge-faq-tabs { display: flex; flex-direction: column; align-items: flex-start; padding: 8px; width: fit-content; margin-bottom: 24px; }
@media (max-width: 690px) { .edge-faq-tabs { width: 100%; } }
.edge-faq-tab { width: 100%; font-size: 24px; font-weight: 500; line-height: 36px; padding: 24px 32px; border: 1.5px solid transparent; border-radius: 24px; cursor: pointer; color: #757575; margin: 0; }
.edge-faq-tab:hover { color: #757575; }
.edge-faq-tab.active { color: #000000DE; border-bottom: 1.5px solid #E6F0FC; background: #F4F8FE; }
.edge-faq-answers { flex: 1.5; }
.edge-faq-category { display: none; }
.edge-faq-category.active { display: block; }
.edge-faq-question { border-bottom: 1.5px solid rgba(62,154,248,0.12); margin-bottom: 7px; }
.edge-faq-question-title { 
    font-size: 18px; 
    font-weight: 500; 
    line-height: 30px; 
    color: #212121; 
    padding: 22px 37px 22px 7px; 
    cursor: pointer; 
    position: relative; 
    margin: 0;
    display: block;
}
.edge-faq-question-title:hover { color: rgba(33, 33, 33, 0.78) }
.edge-faq-question-title:after { 
    font-family: "Font Awesome 5 Free"; 
    font-weight: 900; 
    color: rgba(0,0,0,0.38); 
    content: "\f078"; 
    position: absolute; 
    right: 8px; 
    top: 22px; 
    transition: transform 0.3s; 
}
.edge-faq-question.open .edge-faq-question-title:after { transform: rotate(180deg); }
.edge-faq-answer { 
    display: none; 
    padding: 5px 50px 25px 10px; 
    margin: 0 10px 10px; 
    font-size: 14px; 
    line-height: 24px; 
}
.edge-faq-question.open .edge-faq-answer { display: block; }
.edge-faq-answer p, .edge-faq-answer li { font-size: 14px; color: #3D3D3D; line-height: 24px; }
.edge-faq-answer a { color: #2A7DEC; text-decoration: none; }
.edge-faq-answer a:hover { text-decoration: underline; }
.edge-faq-answer ul { margin: 20px 0; padding-left: 30px; list-style: disc; }
.edge-faq-answer li { margin-bottom: .75em; }
.edge-faq-hidden { display: none; }
.edge-faq-load-more { 
    border-bottom: 1.5px solid rgba(62,154,248,0.12);
    overflow: visible;
    margin-bottom: 7px;
    position: relative;
}
.edge-faq-load-more .title { 
    font-size: 18px;
    font-weight: 500;
    line-height: 30px;
    color: #2A7DEC;
    padding: 22px 37px 22px 7px;
    margin: 0;
    cursor: pointer;
    transition: none;
}
.edge-faq-load-more .title:hover { 
    color: #1e5fb8;
}
.edge-faq-load-more .title:after {
    color: #2A7DEC;
    content: "+";
    position: absolute;
    right: 8px;
    top: 22px;
    font-size: 20px;
    font-weight: 300;
    line-height: 1;
}
</style>

<script>
function toggleEdgeFaq(element) {
    var question = element.closest('.edge-faq-question');
    question.classList.toggle('open');
}

function switchEdgeFaqTab(tabId) {
    var tabs = document.querySelectorAll('.edge-faq-tab');
    tabs.forEach(function(tab) {
        tab.classList.remove('active');
    });
    
    var categories = document.querySelectorAll('.edge-faq-category');
    categories.forEach(function(cat) {
        cat.classList.remove('active');
    });
    
    event.target.classList.add('active');
    
    var category = document.getElementById('edge-faq-cat-' + tabId);
    if (category) category.classList.add('active');
    
    // Reset load more button for the new category
    resetEdgeLoadMore(tabId);
}

function loadMoreEdgeFaq(loadMoreDiv) {
    var category = loadMoreDiv.closest('.edge-faq-category');
    var hiddenQuestions = category.querySelectorAll('.edge-faq-question.edge-faq-hidden');
    
    // Show all hidden questions
    hiddenQuestions.forEach(function(question) {
        question.classList.remove('edge-faq-hidden');
    });
    
    // Hide the load more div
    loadMoreDiv.style.display = 'none';
}

function resetEdgeLoadMore(categoryId) {
    var category = document.getElementById('edge-faq-cat-' + categoryId);
    var loadMoreDiv = category.querySelector('.edge-faq-load-more');
    
    if (loadMoreDiv) {
        var hiddenQuestions = category.querySelectorAll('.edge-faq-question.edge-faq-hidden');
        if (hiddenQuestions.length > 0) {
            loadMoreDiv.style.display = 'block';
        }
    }
}
</script>

<h2>边缘计算 - {{edgeName}}</h2>

<div class="edge-faq-wrapper">
    <div class="edge-faq-sections">
        <div class="edge-faq-tabs">
            <div class="edge-faq-tab active" onclick="switchEdgeFaqTab('general')">一般问题</div>
            <div class="edge-faq-tab" onclick="switchEdgeFaqTab('comparison')">版本对比与升级</div>
            <div class="edge-faq-tab" onclick="switchEdgeFaqTab('features')">功能与能力</div>
            <div class="edge-faq-tab" onclick="switchEdgeFaqTab('installation')">安装与配置</div>
            <div class="edge-faq-tab" onclick="switchEdgeFaqTab('support')">支持</div>
        </div>
        <div class="edge-faq-answers">
            <div id="edge-faq-cat-general" class="edge-faq-category active">
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">什么是 ThingsBoard Edge {{edgeName}}？</div>
                    <div class="edge-faq-answer">
                        {% if docsPrefix == "pe/edge/" %}
                        <p>ThingsBoard Edge Professional Edition (PE) 是 ThingsBoard Edge 的商业版本，是专为生产级和企业级环境在边缘管理和处理 IoT 数据而设计的高级IoT平台。</p>
                        <p>它提供包括白标、基于角色的访问控制(RBAC)、高级集成和企业级能力在内的全面功能，同时与 ThingsBoard Server 保持无缝同步。</p>
                        {% else %}
                        <p><b>ThingsBoard Edge Community Edition (CE)</b> 是一款专为边缘计算场景设计的免费开源平台。它提供在边缘管理和分析 IoT 数据的基本能力，同时与 ThingsBoard Server（云或本地部署）保持无缝同步。</p>
                        {% endif %}
                        <p><b>不了解边缘计算？</b>边缘计算是指在数据生成处处理数据，而不是将所有数据都发送到云端。</p> 
                        <p>详见<a href="/docs/{{docsPrefix}}getting-started-guides/what-is-edge/" target="_blank">什么是 Edge？</a>了解详细介绍，或前往<a href="/docs/{{docsPrefix}}getting-started/" target="_blank">入门指南</a>开始使用 ThingsBoard Edge。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">我可以在现场部署 Server，为什么还要部署 Edge？</div>
                    <div class="edge-faq-answer">
                        <p>如果您只有<b>一个站点</b>，在本地部署 ThingsBoard Server 可能就已足够。</p>
                        <p>当您<b>拥有多个或远程站点</b>，需要本地处理、仪表盘和自动化，但不想在每个站点都部署完整的 Server 时，请使用 ThingsBoard Edge。</p>
                        <p><b>Server</b> 作为您的<b>中央枢纽</b>，而<b>Edge</b> 在每个站点的轻量级硬件上运行，<b>可在离线状态下继续工作</b>，然后将数据和配置同步回 Server。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">如何获取 ThingsBoard Edge {{edgeName}}？</div>
                    <div class="edge-faq-answer">
                        {% if docsPrefix == "pe/edge/" %}
                        <p>Edge {{edgeName}} 是<b>ThingsBoard PE 订阅的附加组件</b>。您的套餐包含一定数量的 Edge 实例，可根据需要购买额外实例。</p>
                        <p>查看<a href="/pricing/" target="_blank">定价页面</a>了解各套餐包含内容，或联系系统管理员。</p>
                        {% else %}
                        <p>Edge {{edgeName}} 为<b>开源</b>且<b>可免费下载</b>。请从我们的<a href="/docs/user-guide/install/{{docsPrefix}}installation-options/" target="_blank">文档</a>安装，或访问<a href="https://github.com/thingsboard/thingsboard-edge" target="_blank">GitHub</a>获取源代码。</p>
                        <p>您需要有一个 ThingsBoard Server 实例以供 Edge 连接。完整配置说明请参阅<a href="/docs/{{docsPrefix}}getting-started/" target="_blank">入门指南</a>。</p> 
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以在 Raspberry Pi 或其他边缘设备上运行 ThingsBoard Edge 吗？</div>
                    <div class="edge-faq-answer">
                        <p>可以，<b>ThingsBoard Edge</b> 专为在各种 Edge 硬件平台上运行而设计，包括像<b>Raspberry Pi</b>这样的单板计算机以及其他具备足够处理能力和内存的设备。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">如果网络断开会怎样？</div>
                    <div class="edge-faq-answer">
                        <p>Edge 会继续运行。<b>它在本地处理数据、触发告警并更新仪表盘——无需云端</b>。当网络恢复时，Edge 会自动将所有内容与 ThingsBoard Server 同步。无数据丢失，无需人工干预。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">Edge 能支持多少设备？</div>
                    <div class="edge-faq-answer">
                        <p>基于典型边缘硬件和网络限制，我们建议每个 Edge 实例<b>最多 1,000 台设备</b>。您可以<b>超过</b>此数量；实际性能取决于您的具体硬件和网络条件。</p>
                        <p>如需更高容量，可部署多个 Edge 实例。另外，若您使用<b>4.0 或更高版本</b>，可<a href="/docs/{{docsPrefix}}config/edge-cluster-setup/" target="_blank">将 Edge 节点组成集群</a>以实现高可用。</p>
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">我有使用专有协议的设备，Edge 能连接它们吗？</div>
                    <div class="edge-faq-answer">
                        <p>可以。Edge 原生支持 <a href="/docs/{{docsPrefix}}reference/mqtt-api/" target="_blank">MQTT</a>、<a href="/docs/{{docsPrefix}}reference/coap-api/" target="_blank">CoAP</a>、<a href="/docs/{{docsPrefix}}reference/http-api/" target="_blank">HTTP</a>、<a href="/docs/{{docsPrefix}}reference/snmp-api/" target="_blank">SNMP</a> 和 <a href="/docs/{{docsPrefix}}reference/lwm2m-api/" target="_blank">LwM2M</a>。</p>
                        <p>对于其他协议，可使用 <a href="/docs/iot-gateway/what-is-iot-gateway/" target="_blank">ThingsBoard IoT Gateway</a> 桥接传统设备。Gateway 支持 <a href="/docs/iot-gateway/config/modbus/" target="_blank">Modbus</a>、<a href="/docs/iot-gateway/config/bacnet/" target="_blank">BACnet</a>、<a href="/docs/iot-gateway/config/opc-ua/" target="_blank">OPC-UA</a> 等，且无需额外费用。</p>
                        {% if docsPrefix == "pe/edge/" %}
                        <p>或使用 <a href="/docs/{{docsPrefix}}user-guide/integrations/" target="_blank">平台集成</a>，通过 <a href="/docs/{{docsPrefix}}user-guide/integrations/opc-ua/" target="_blank">OPC-UA</a>、<a href="/docs/{{docsPrefix}}user-guide/integrations/chirpstack/" target="_blank">ChirpStack</a> 及 30+ 其他系统进行连接，并可使用 <a href="/docs/user-guide/integrations/#converters-library" target="_blank">转换器库</a>。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以自定义和修改 Edge {{edgeName}} 吗？</div>
                    <div class="edge-faq-answer">
                        {% if docsPrefix == "pe/edge/" %}
                        <p>不可以，<b>ThingsBoard {{edgeName}}</b> 为商业项目，不可修改。</p>
                        {% else %}
                        <p>可以，源代码已在 GitHub 开放，您可 fork 并修改以满足需求。顺便请考虑给 <a href="https://github.com/thingsboard/thingsboard-edge" target="_blank">我们的仓库</a>加星。</p> 
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-load-more" onclick="loadMoreEdgeFaq(this)">
                    <div class="title">加载更多常见问题</div>
                </div>
            </div>
            <div id="edge-faq-cat-comparison" class="edge-faq-category">
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">Edge 社区版与专业版有何区别？</div>
                    <div class="edge-faq-answer">
                        <p><b>两个版本</b>均提供设备管理、规则引擎、仪表盘及标准协议（MQTT、CoAP、HTTP 等）。</p>
                        <p><b>社区版</b>免费且开源。</p>
                        <p><b>专业版</b>为商业版，额外提供：</p>
                        <ul>
                        <li><b>白标：</b>以您公司品牌部署。</li>
                        <li><b>解决方案模板：</b>即装即用的 IoT 解决方案，含仪表盘、规则链和示例设备。</li>
                        <li><b>转换器库：</b>针对 6 个 LoRaWAN 网络中 100+ 设备的即用解码函数。</li>
                        <li><b>调度器：</b>自动化报告生成、属性更新和设备命令。</li>
                        </ul>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">开发商业产品是否需要 PE Edge？</div>
                    <div class="edge-faq-answer">
                        <p>不一定。<b>社区版已具备生产就绪能力</b>并支持商业部署。您可在 CE 上构建、销售和部署商业产品。</p>
                        <p>选择 CE 或 PE 取决于您的具体需求。</p>
                        <p>若需以下能力可考虑 PE：</p>
                        <ul>
                        <li>向客户交付品牌化产品。</li>
                        <li>通过 OPC-UA 或其他工业协议连接传统设备。</li>
                        <li>部署预置解决方案（灌溉、水表、废物管理等）。</li>
                        <li>通过层级访问控制管理多个终端客户。</li>
                        </ul>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以将 Edge 专业版与社区版 Server 混用吗，反之亦然？</div>
                    <div class="edge-faq-answer">
                        <p>不可以。Edge <b>版本必须与</b>您的 ThingsBoard Server 版本匹配：</p>
                        <ul>
                        <li>CE Edge 连接 ThingsBoard CE Server。</li>
                        <li>PE Edge 连接 ThingsBoard PE Server。</li>
                        </ul>
                        <p>PE 专属功能（白标、解决方案模板、集成等）需要同时使用 PE Edge 和 PE Server 才能工作。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">一个 Server 可连接多少 Edge 实例？</div>
                    <div class="edge-faq-answer">
                        <ul>
                        <li><b>CE Edge：</b>Edge 实例数量不限。</li>
                        <li><b>PE Edge：</b>包含的 Edge 实例数量取决于您的 ThingsBoard PE 套餐。可按月付费增加额外 Edge 实例。请查看套餐详情或联系管理员了解包含的 Edge 实例数量。</li>
                        </ul>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以从 CE Edge 迁移到 PE Edge 吗？</div>
                    <div class="edge-faq-answer">
                        <p>可以，但需要升级整个系统：</p>
                        <ul>
                        <li><b>将 ThingsBoard Server</b> 从 CE 升级到 PE。</li>
                        <li><b>为 PE 许可购买 Edge Computing 附加组件</b>。</li>
                        <li><b>使用 PE 包重新安装 Edge</b>。</li>
                        </ul>
                        <p><b>升级前：</b>备份所有自定义仪表盘、规则链或配置。<a href="/docs/contact-us/" target="_blank">联系</a>我们的支持团队获取帮助，或查看<a href="/docs/pe/user-guide/install/upgrade-instructions/upgrade-from-ce/" target="_blank">迁移指南</a>获取分步说明。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">如何开始免费试用？</div>
                    <div class="edge-faq-answer">
                        <p>社区版免费开源，无需试用。<a href="/docs/user-guide/install/{{docsPrefix}}installation-options/" target="_blank">下载</a>后可无限期免费使用。</p>
                        <p>专业版可从<b>Free</b>套餐开始，该套餐在设备数量上有限制，但 Edge Computing 附加组件永久启用，可免费体验附加功能。</p>
                    </div>
                </div>
            </div>
            <div id="edge-faq-cat-features" class="edge-faq-category">
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">{{edgeName}} 有哪些核心功能？</div>
                    <div class="edge-faq-answer">
                        {% if docsPrefix == "pe/edge/" %}
                        <p>Edge <b>{{edgeName}}</b> 包含所有 <b>社区版</b> 功能，并额外提供：</p>
                        <ul>
                        <li><b>UI 定制：</b><a href="/docs/{{peDocsPrefix}}user-guide/white-labeling/" target="_blank">白标</a>和<a href="/docs/{{peDocsPrefix}}user-guide/custom-menu/" target="_blank">自定义菜单</a>配置。</li>
                        <li><b>解决方案模板：</b><a href="/docs/{{peDocsPrefix}}solution-templates/overview/" target="_blank">即装即用的 IoT 解决方案</a>。</li>
                        <li><b>平台集成：</b><a href="/docs/{{docsPrefix}}user-guide/integrations/" target="_blank">连接</a> OPC-UA 服务器等，支持 100+ 设备的<a href="/docs/user-guide/integrations/#converters-library" target="_blank">即用解码器</a>。</li>
                        <li><b>调度器：</b><a href="/docs/{{docsPrefix}}user-guide/scheduler/" target="_blank">自动化</a>报告、命令和更新。</li>
                        <li><b>客户层级：</b>以隔离访问组织多个终端客户。</li>
                        </ul>
                        {% else %}
                        <p>Edge <b>{{edgeName}}</b> 提供完整的边缘计算功能：</p>
                        <ul>
                        <li><b>设备连接：</b>MQTT、CoAP、HTTP、SNMP 和 LwM2M 协议。</li>
                        <li><b>本地数据处理：</b>规则引擎，用于实时分析和自动化。</li>
                        <li><b>可视化：</b>仪表盘创建与定制。</li>
                        <li><b>数据管理：</b>设备遥测采集与属性管理。</li>
                        <li><b>开源：</b>完全开源，有活跃社区支持。</li>
                        </ul>
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge 是否支持多租户？</div>
                    <div class="edge-faq-answer">
                        <p>不支持，ThingsBoard Edge {{edgeName}} <b>不支持</b>多租户。</p>
                        {% if docsPrefix == 'pe/edge/' %}
                        <p>{{edgeName}} 支持<b>单租户</b>和<b>带层级的多个客户</b>。</p>
                        <p>例如，若 Edge 拥有者为子客户，则该子客户直至租户级别的所有父实体会被配置到 Edge。这意味着同一层级路径下的客户可访问同一 Edge 实例。</p>
                        <p>但您<b>无法</b>在多个租户之间共享一个实例，且来自多个租户的设备<b>无法连接</b>到同一 Edge 实例。若需多租户，请为每个租户配置多个 Edge 实例。</p>
                        {% else %}
                        <p>{{edgeName}} 为<b>单租户</b>和<b>单客户</b>设计。这意味着您<b>无法</b>在多个租户或客户之间共享同一 Edge 实例，来自不同租户的设备<b>也无法连接</b>到同一 Edge 实例。</p>
                        <p>若需多租户，请为每个租户配置多个 Edge 实例。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge {{edgeName}} 是否支持 AI 或机器学习集成？</div>
                    <div class="edge-faq-answer">
                        <p>支持。Edge 规则引擎中包含<a href="/docs/user-guide/rule-engine-2-0/nodes/external/ai-request/" target="_blank">AI Request 节点</a>，可与 OpenAI、Azure OpenAI 及自定义 AI 端点集成。可用于预测性维护、异常检测、自然语言处理及其他 AI 分析。</p>
                        <p>实现细节请参阅<a href="/docs/samples/analytics/ai-predictive-maintenance/" target="_blank">AI 预测性维护示例</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以集成通过 LoRaWAN 等第三方系统连接的设备吗？</div>
                    <div class="edge-faq-answer">
                        <p>社区版不支持开箱即用。要连接 LoRaWAN 网络等第三方平台，需开发自定义集成代码。</p>
                        <p>专业版提供<b>即用平台集成</b>，支持 LoRaWAN 网络（ChirpStack、TTN、Loriot）、OPC-UA 服务器及 30+ 其他平台。详见<a href="/docs/pe/edge/user-guide/integrations/" target="_blank">Edge 集成文档</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge 是否支持集群？</div>
                    <div class="edge-faq-answer">
                        <p>自<b>4.0 版本</b>起支持。可将多个 Edge 节点组成集群以实现高可用。若某节点故障，其他节点继续处理工作负载。</p>
                        <p>更早版本以单实例模式运行。</p>
                        <p>详见<a href="/docs/{{docsPrefix}}config/edge-cluster-setup/" target="_blank">Edge 集群配置文档</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge 支持哪些数据库和上行消息存储？</div>
                    <div class="edge-faq-answer">
                        <p>Edge {{edgeName}} 支持<b>纯 SQL 及 SQL + NoSQL 混合</b>（用于遥测存储）方案：</p>
                        <ul>
                            <li><b>PostgreSQL：</b>默认选项，适用于大多数部署。</li>
                            <li><b>PostgreSQL + Cassandra：</b>适用于大量遥测的混合方案（100 万+ 设备或 >5,000 条/秒）。</li>
                        </ul>
                        <p>Edge 还支持多种<b>上行消息存储</b>：</p>
                        <ul>
                            <li><b>PostgreSQL：</b>内置默认，<b>适用于 PoC 和低负载环境</b>——不推荐用于生产或大量上行消息的集群部署。</li>
                            <li><b>Kafka：</b>推荐用于生产部署。</li>
                        </ul>
                    </div>
                </div>
                {% if docsPrefix == "edge/" %}
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">Edge {{edgeName}} 是否支持白标或自定义菜单等 UI 定制？</div>
                    <div class="edge-faq-answer">
                        <p><a href="/docs/{{peDocsPrefix}}user-guide/white-labeling/" target="_blank">白标</a>和<a href="/docs/{{peDocsPrefix}}user-guide/custom-menu/" target="_blank">自定义菜单</a>配置为<b>专业版</b>功能，无需修改代码即可实现 UI 定制。</p>
                        <p><b>{{edgeName}}</b> 为开源版本，开发者可通过修改源代码定制界面。</p>
                    </div>
                </div>
                {% endif %}
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以自动化设备管理和遥测处理吗？</div>
                    <div class="edge-faq-answer">
                        <p>可以。<a href="/docs/{{docsPrefix}}rule-engine/rule-chain-templates/" target="_blank">规则引擎</a>可基于接收的遥测自动化设备工作流、数据处理和告警。</p>
                        <p>例如，可自动预置设备、转换数据、按阈值触发操作或将遥测转发到外部系统。</p>
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以在 Edge 上运行规则链吗？</div>
                    <div class="edge-faq-answer">
                        <p>可以。Edge 在本地运行规则链以实现实时处理。自<b>4.0 版本</b>起，您可<b>直接在 Edge 上创建和编辑</b>规则链。在<b>更早版本</b>中，规则链需<b>在 Server 上作为模板配置后下发</b>到 Edge。</p>
                        <p>详见<a href="/docs/{{docsPrefix}}rule-engine/rule-chain-templates/" target="_blank">Edge 规则链模板</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">Edge {{edgeName}} 是否支持 OTA（Over-the-Air）固件更新？</div>
                    <div class="edge-faq-answer">
                        <p>支持。可管理固件版本、安排更新并跟踪设备部署状态。配置说明请参阅<a href="/docs/{{docsPrefix}}user-guide/ota-updates/" target="_blank">OTA 更新文档</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge {{edgeName}} 有移动端应用吗？</div>
                    <div class="edge-faq-answer">
                        <p>没有，ThingsBoard Edge 没有专用移动应用。</p>
                        <p>但您可在任何设备（包括手机）上通过浏览器访问和管理 Edge 实例。通常实例<b>运行在 8080 端口</b>。</p>
                    </div>
                </div>
                <div class="edge-faq-load-more" onclick="loadMoreEdgeFaq(this)">
                    <div class="title">加载更多常见问题</div>
                </div>
            </div>
            <div id="edge-faq-cat-installation" class="edge-faq-category">
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">Edge 版本是否与 Server 版本绑定？</div>
                    <div class="edge-faq-answer">
                        <p>部分绑定。Edge X.Y.Z 版本可与以下版本配合使用：</p>
                        <ul>
                        <li>Server X.Y.Z 版本（<b>同版本</b>）。</li>
                        <li>Server X.Y+1 和 X.Y+2 版本（<b>最多超前两个次版本</b>）。</li>
                        </ul>
                        <p><b>Edge 不能与更早的 Server 版本配合使用。</b></p>
                        <p>示例：Edge 3.8.0 可与 Server 3.8.0、3.8.1 和 3.9.0 配合使用，但不能与 Server 3.7.x 或更早版本配合。若 Edge 比 Server 新，请先升级 Server。</p>
                        <p>另见<a href="/docs/{{docsPrefix}}releases/" target="_blank">Edge 版本说明</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">运行 Edge 需要什么硬件？</div>
                    <div class="edge-faq-answer">
                        <p>比您想象的要少。Edge 可运行于：</p>
                        <ul>
                        <li>Raspberry Pi 或类似单板计算机。</li>
                        <li>工业网关。</li>
                        <li>迷你 PC 或嵌入式系统。</li>
                        <li><b>轻负载需 1GB+ 内存，高负载需 4GB+ 内存的任意机器</b>。</li>
                        </ul>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">如何升级到最新版本？</div>
                    <div class="edge-faq-answer">
                        <p>升级到最新版本请参阅<a href="/docs/user-guide/install/{{docsPrefix}}upgrade-instructions/" target="_blank">升级说明</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">如何连接设备？</div>
                    <div class="edge-faq-answer">
                        <p><b>ThingsBoard Edge</b> 支持多种协议，包括 <a href="/docs/{{docsPrefix}}reference/mqtt-api" target="_blank">MQTT</a>、<a href="/docs/{{docsPrefix}}reference/coap-api" target="_blank">CoAP</a>、<a href="/docs/{{docsPrefix}}reference/http-api" target="_blank">HTTP</a> 和 <a href="/docs/{{docsPrefix}}reference/lwm2m-api" target="_blank">LwM2M</a>。</p>
                        <p>传统设备可通过 <a href="/docs/iot-gateway/what-is-iot-gateway/" target="_blank">ThingsBoard Gateway</a> 连接至平台。更多信息请参阅<a href="/docs/{{docsPrefix}}reference/protocols/" target="_blank">连接</a>页面。</p>
                        {% if docsPrefix == 'pe/edge/' %}
                        <p>也可使用 <a href="/docs/user-guide/integrations/" target="_blank">ThingsBoard 集成</a>将不同来源及自定义载荷的设备连接至边缘。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">如何安装 Edge？</div>
                    <div class="edge-faq-answer">
                        <p>Edge 可运行于<b>Docker、Ubuntu、CentOS、Windows 和 Raspberry Pi</b>。分步说明请参阅安装指南。</p>
                        <p>分步说明请参阅<a href="/docs/user-guide/install/{{docsPrefix}}installation-options/" target="_blank">安装选项</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge 有官方 Docker 镜像吗？</div>
                    <div class="edge-faq-answer">
                        {% if docsPrefix == 'pe/edge/' %}
                        <p>有，官方<a href="https://hub.docker.com/r/thingsboard/tb-edge-pe" target="_blank">Docker 镜像</a>可在<b>Docker Hub</b>获取。</p>
                        {% else %}
                        <p>有，官方<a href="https://hub.docker.com/r/thingsboard/tb-edge" target="_blank">Docker 镜像</a>可在<b>Docker Hub</b>获取。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">ThingsBoard Edge 将时序数据存储在哪里？</div>
                    <div class="edge-faq-answer">
                        <p>默认情况下，Edge 将时序数据存储在 <b>PostgreSQL</b> 中，对典型部署可高效处理<b>设备元数据和遥测</b>。</p>
                        <p>对于高负载场景（100 万+ 设备或 >5,000 条/秒），可配置<b>混合方案</b>：<b>时序数据存储在 Cassandra，PostgreSQL 处理设备元数据和属性</b>。</p>
                    </div>
                </div>
                <div class="edge-faq-question edge-faq-hidden">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">是否必须使用软件开发套件（SDK）？</div>
                    <div class="edge-faq-answer">
                        <p>不需要，很多 IoT 设备并非为嵌入第三方 SDK 而设计。</p>
                        <p>ThingsBoard Edge 基于常用 IoT 协议提供<b>简单 API</b>，您可选择任意客户端库甚至使用自有实现。可参考<a href="https://github.com/mqtt/mqtt.github.io/wiki/libraries" target="_blank">MQTT 客户端库列表</a>和<a href="https://libcoap.net/" target="_blank">CoAP 的 C 实现</a>。</p>
                    </div>
                </div>
                <div class="edge-faq-load-more" onclick="loadMoreEdgeFaq(this)">
                    <div class="title">加载更多常见问题</div>
                </div>
            </div>
            <div id="edge-faq-cat-support" class="edge-faq-category">
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">{{edgeName}} 有哪些支持方式？</div>
                    <div class="edge-faq-answer">
                        {% if docsPrefix == "pe/edge/" %}
                        <p>自 4.2 版本起，我们为生产用户提供<a href="/docs/{{docsPrefix}}releases/release-policy/" target="_blank">长期支持（LTS）</a>版本，包含扩展安全更新和稳定性改进。</p>
                        <p>您可随时<a href="/docs/contact-us/" target="_blank">联系我们</a>咨询任何问题。</p>
                        <p>此外，<b>ThingsBoard 社区</b>也可提供支持。</p>
                        {% else %}
                        <p><b>社区版</b>支持主要由社区驱动，包括：</p>
                        {% endif %}
                        <ul>
                        <li><a href="https://stackoverflow.com/questions/tagged/thingsboard" target="_blank">社区论坛：</a>与其他用户和开发者交流。</li>
                        <li><a href="https://github.com/thingsboard/thingsboard-edge/issues" target="_blank">GitHub Issues：</a>报告缺陷或请求新功能。</li>
                        <li><a href="/docs/{{docsPrefix}}" target="_blank">文档：</a>ThingsBoard 文档中的完整指南与 API 参考。</li>
                        </ul>
                    </div>
                </div>
                {% if docsPrefix == "pe/edge/" %}
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">是否提供 24/7 客户支持？</div>
                    <div class="edge-faq-answer">
                        <p>是的，我们提供 24/7 支持。若需此服务，请<a href="/docs/contact-us/" target="_blank">联系我们</a>详谈您的具体需求。</p>
                        <p>此外，自 4.2 版本起，我们为生产用户提供<a href="/docs/{{docsPrefix}}releases/release-policy/" target="_blank">长期支持（LTS）</a>版本，包含扩展安全更新和稳定性改进。</p>
                    </div>
                </div>
                {% else %}
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">在社区版中发现缺陷应如何处理？</div>
                    <div class="edge-faq-answer">
                        <p>可在<a href="https://github.com/thingsboard/thingsboard-edge/issues" target="_blank">GitHub Issues</a>上报告，开源社区可能会协助修复。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">可以为 ThingsBoard Edge 社区版的开发做贡献吗？</div>
                    <div class="edge-faq-answer">
                        <p>可以！欢迎在<a href="https://github.com/thingsboard/thingsboard-edge" target="_blank">GitHub</a>上提交 Pull Request 和贡献。顺便请考虑为我们的仓库加星。</p>
                    </div>
                </div>
                <div class="edge-faq-question">
                    <div class="edge-faq-question-title" onclick="toggleEdgeFaq(this)">社区版是否有官方支持？</div>
                    <div class="edge-faq-answer">
                        <p>没有，<b>社区版</b>不包含官方支持。如需官方支持，可考虑升级至付费版本。</p>
                    </div>
                </div>
                {% endif %}
            </div>
        </div>
    </div>
</div>