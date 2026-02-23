<style>
.tb-faq-wrapper { padding: 20px 15px 80px; max-width: 1200px; margin: 0 auto; }
.tb-faq-wrapper h1 { text-align: center; font-size: 36px; font-weight: 500; line-height: 48px; margin-bottom: 48px; color: #212529; }
.tb-faq-sections { display: flex; gap: 40px; }
@media (max-width: 1200px) { .tb-faq-sections { flex-direction: column; } }
.tb-faq-tabs { display: flex; flex-direction: column; align-items: flex-start; padding: 8px; width: fit-content; margin-bottom: 24px; }
@media (max-width: 690px) { .tb-faq-tabs { width: 100%; } }
.tb-faq-tab { width: 100%; font-size: 24px; font-weight: 500; line-height: 36px; padding: 24px 32px; border: 1.5px solid transparent; border-radius: 24px; cursor: pointer; color: #757575; }
.tb-faq-tab:hover { color: #757575; }
.tb-faq-tab.active { color: #000000DE; border-bottom: 1.5px solid #E6F0FC; background: #F4F8FE; }
.tb-faq-answers { flex: 1.5; }
.tb-faq-category { display: none; }
.tb-faq-category.active { display: block; }
.tb-faq-question { border-bottom: 1.5px solid rgba(62,154,248,0.12); margin-bottom: 7px; }
.tb-faq-question-title { 
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
.tb-faq-question-title:hover { color: rgba(33, 33, 33, 0.78); }
.tb-faq-question-title:after { 
    font-family: "Font Awesome 5 Free"; 
    font-weight: 900; 
    color: rgba(0,0,0,0.38); 
    content: "\f078"; 
    position: absolute; 
    right: 8px; 
    top: 22px; 
    transition: transform 0.3s; 
}
.tb-faq-question.open .tb-faq-question-title:after { transform: rotate(180deg); }
.tb-faq-answer { 
    display: none; 
    padding: 5px 50px 25px 10px; 
    margin: 0 10px 10px; 
    font-size: 14px; 
    line-height: 24px; 
}
.tb-faq-question.open .tb-faq-answer { display: block; }
.tb-faq-answer p, .tb-faq-answer li { font-size: 14px; color: #3D3D3D; line-height: 24px; }
.tb-faq-answer a { color: #2A7DEC; text-decoration: none; }
.tb-faq-answer a:hover { text-decoration: underline; }
.tb-faq-answer ul { margin: 20px 0; padding-left: 30px; list-style: disc; }
.tb-faq-answer li { margin-bottom: .75em; }
.tb-faq-hidden { display: none; }
.tb-faq-load-more { 
    border-bottom: 1.5px solid rgba(62,154,248,0.12);
    overflow: visible;
    margin-bottom: 7px;
    position: relative;
}
.tb-faq-load-more .title { 
    font-size: 18px;
    font-weight: 500;
    line-height: 30px;
    color: #2A7DEC;
    padding: 22px 37px 22px 7px;
    margin: 0;
    cursor: pointer;
    transition: none;
}
.tb-faq-load-more .title:hover { 
    color: #1e5fb8;
}
.tb-faq-load-more .title:after {
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
function toggleTbFaq(element) {
    var question = element.closest('.tb-faq-question');
    question.classList.toggle('open');
}

function switchTbFaqTab(tabId) {
    // Remove active from all tabs
    var tabs = document.querySelectorAll('.tb-faq-tab');
    tabs.forEach(function(tab) {
        tab.classList.remove('active');
    });
    
    // Remove active from all categories
    var categories = document.querySelectorAll('.tb-faq-category');
    categories.forEach(function(cat) {
        cat.classList.remove('active');
    });
    
    // Add active to clicked tab
    event.target.classList.add('active');
    
    // Add active to corresponding category
    var category = document.getElementById('tb-faq-cat-' + tabId);
    if (category) category.classList.add('active');
    
    // Reset load more button for the new category
    resetLoadMore(tabId);
}

function loadMoreTbFaq(loadMoreDiv) {
    var category = loadMoreDiv.closest('.tb-faq-category');
    var hiddenQuestions = category.querySelectorAll('.tb-faq-question.tb-faq-hidden');
    
    // Show all hidden questions
    hiddenQuestions.forEach(function(question) {
        question.classList.remove('tb-faq-hidden');
    });
    
    // Hide the load more div
    loadMoreDiv.style.display = 'none';
}

function resetLoadMore(categoryId) {
    var category = document.getElementById('tb-faq-cat-' + categoryId);
    var loadMoreDiv = category.querySelector('.tb-faq-load-more');
    
    if (loadMoreDiv) {
        var hiddenQuestions = category.querySelectorAll('.tb-faq-question.tb-faq-hidden');
        if (hiddenQuestions.length > 0) {
            loadMoreDiv.style.display = 'block';
        }
    }
}
</script>

<h2>开源IoT平台</h2>

<div class="tb-faq-wrapper">
    <div class="tb-faq-sections">
        <div class="tb-faq-tabs">
            <div class="tb-faq-tab active" onclick="switchTbFaqTab('general')">通用</div>
            {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
            <div class="tb-faq-tab" onclick="switchTbFaqTab('private-cloud')">私有云</div>
            <div class="tb-faq-tab" onclick="switchTbFaqTab('addons')">ThingsBoard 插件</div>
            {% endif %}
            <div class="tb-faq-tab" onclick="switchTbFaqTab('ai')">AI 能力</div>
            <div class="tb-faq-tab" onclick="switchTbFaqTab('deployment')">部署与限制</div>
            <div class="tb-faq-tab" onclick="switchTbFaqTab('security')">安全与合规</div>
            <div class="tb-faq-tab" onclick="switchTbFaqTab('support')">支持与帮助</div>
        </div>
        <div class="tb-faq-answers">
            <div id="tb-faq-cat-general" class="tb-faq-category active">
                <div class="tb-faq-question">
                    {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/"%}
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard Cloud是什么？</div>
                    {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard Professional Edition是什么？</div>
                    {% else %}
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard Community Edition是什么？</div>
                    {% endif %}
                    <div class="tb-faq-answer">
                        <p>ThingsBoard 是面向<b>数据采集、处理、可视化及设备管理</b>的IoT平台。通过开箱即用组件和 API 加速开发、降低成本，同时保持对方案和数据的完全掌控。</p>
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/"%}
                        <p>ThingsBoard Cloud 是面向 IoT 应用的<b>全托管、可扩展、高容错 Platform-as-a-Service (PaaS)</b>。提供 Professional Edition 全部高级功能，无需手工安装、维护或基础设施更新，可专注于构建方案。</p>
                        <p>详见<a href="/docs/{{docsPrefix}}getting-started-guides/what-is-thingsboard/" target="_blank">ThingsBoard是什么</a>了解平台架构，或直接参阅<a href="/docs/{{docsPrefix}}getting-started-guides/helloworld/" target="_blank">快速入门指南</a>搭建首个项目。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>ThingsBoard Professional Edition (PE) 是企业级IoT平台，面向<b>生产就绪部署</b>。提供白标、高级安全、多客户管理及官方技术支持等关键功能，适合需要可靠、专业支持的企业。</p>
                        <p>详见<a href="/docs/{{docsPrefix}}getting-started-guides/what-is-thingsboard/" target="_blank">ThingsBoard是什么</a>了解架构，或参阅<a href="/docs/getting-started-guides/helloworld-pe/" target="_blank">快速入门指南</a>搭建首个项目。</p>
                        {% else %}
                        <p>ThingsBoard社区版(CE)是<b>免费开源IoT平台</b>，用于采集、存储和分析 IoT 设备数据。面向希望完全掌控自身 IoT 基础设施和源码、无许可费用的开发者和组织。</p>
                        <p>详见<a href="/docs/{{docsPrefix}}getting-started-guides/what-is-thingsboard/" target="_blank">ThingsBoard是什么</a>了解架构，或参阅<a href="/docs/getting-started-guides/helloworld/" target="_blank">快速入门指南</a>搭建首个项目。</p>
                       {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard Professional Edition免费吗？</div>
                    {% else %}
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard社区版免费吗？</div>
                    {% endif %}
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" %}
                        <p>可从免费计划开始，更高级计划需<b>付费订阅</b>。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>否，Professional Edition需<b>付费订阅</b>。</p>
                        {% else %}
                        <p>是，<b>完全免费</b>，无许可费或隐性成本。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">Community Edition与Professional Edition有何区别？</div>
                    <div class="tb-faq-answer">
                        <p><b>Community Edition (CE)</b> 为免费开源平台，适用于开发、测试和生产，无许可费。具备 IoT 设备管理、数据采集、可视化及规则处理等核心功能。</p>
                        <p><b>Professional Edition (PE)</b> 涵盖 CE 全部功能，并增加<a href="/docs/pe/user-guide/white-labeling/" target="_blank">白标</a>、<a href="/docs/pe/user-guide/rbac/" target="_blank">基于角色的访问控制 (RBAC)</a>、<a href="/docs/user-guide/integrations/" target="_blank">平台集成</a>、<a href="/docs/pe/solution-templates/overview/" target="_blank">方案模板</a>、<a href="/docs/pe/user-guide/scheduler/" target="_blank">调度器</a>及企业支持。</p>
                        <p>详见<a href="/products/thingsboard-pe/" target="_blank">PE 产品页</a>的<b>功能对比表</b>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">如何开始使用 ThingsBoard？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/"%}
                        <p>注册<a href="https://thingsboard.cloud/signup" target="_blank">ThingsBoard Cloud</a>即可使用。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>注册<a href="https://thingsboard.cloud/signup" target="_blank">ThingsBoard Cloud</a>或按<a href="/docs/pe/user-guide/install/installation-options/" target="_blank">安装指南</a>在自有基础设施上部署 PE。</p>
                        {% else %}
                        <p>按<a href="/docs/user-guide/install/installation-options/" target="_blank">安装指南</a>在本地安装 ThingsBoard CE。</p>
                        {% endif %}
                        <p>连接首个设备并构建仪表盘，请参阅<a href="/docs/{{docsPrefix}}getting-started-guides/helloworld/" target="_blank">快速入门指南</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否有 API 速率限制？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" %}
                        <p>有。各 ThingsBoard Cloud 计划包含特定用量配额和 API 速率限制。详见<a href="/docs/{{docsPrefix}}subscriptions/" target="_blank">订阅计划</a>页。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>Professional Edition 软件无内置 API 速率限制。实际吞吐量和性能取决于自托管基础设施能力。</p>
                        {% else %}
                        <p>ThingsBoard社区版无内置 API 速率限制；系统性能与请求处理受所托管基础设施限制。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否有设备数量限制？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" %}
                        <p>限制取决于所选订阅计划。ThingsBoard Cloud 计划从 5 台设备（Maker）到 1,000 台设备（Business）不等。<b>Business</b> 计划可按需购买额外设备容量。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>设备限制由许可类型决定。自托管 Professional Edition 订阅通常为 10 台（Maker）至 1,000 台（Business）设备。<b>Business</b> 许可可购买额外设备包。</p>
                        {% else %}
                        <p>Community Edition无设备限制可连接设备数仅受服务器硬件资源限制。</p>
                        {% endif %}
                        {% unless docsPrefix contains 'paas/' %}
<p>ThingsBoard平台设计为<b>水平可扩展</b>。通过在集群节点间使用<a href="https://en.wikipedia.org/wiki/Consistent_hashing" target="_blank">一致性哈希</a>负载均衡算法，保障高可用与性能。实际容量取决于使用场景及数据吞吐需求。</p>
        <p>例如，普通硬件集群也可通过 MQTT 支持<a href="/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#1-million-smart-meters-tco" target="_blank">数百万</a>设备。</p>
                        {% endunless %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">如何连接设备？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard 支持 <a href="/docs/{{docsPrefix}}reference/mqtt-api" target="_blank">MQTT</a>、<a href="/docs/{{docsPrefix}}reference/coap-api" target="_blank">CoAP</a>、<a href="/docs/{{docsPrefix}}reference/http-api" target="_blank">HTTP</a> 和 <a href="/docs/{{docsPrefix}}reference/lwm2m-api" target="_blank">LwM2M</a>。<b>现有</b>设备可通过<b><a href="/docs/iot-gateway/what-is-iot-gateway/" target="_blank">ThingsBoard Gateway</a></b>连接平台。更多见<a href="/docs/{{docsPrefix}}reference/protocols/" target="_blank">连接</a>页。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">必须使用 SDK 吗？</div>
                    <div class="tb-faq-answer">
                        <p>否。许多 IoT 设备难以嵌入第三方 SDK。ThingsBoard 通过常见 IoT 协议提供简易 API，可选择任意客户端库或自研。参考：</p>
                        <ul>
                            <li><a href="https://github.com/mqtt/mqtt.github.io/wiki/libraries" target="_blank">List of MQTT client-side libraries</a></li>
                            <li><a href="https://libcoap.net/" target="_blank">C-implementation for CoAP</a></li>
                        </ul>
                    </div>
                </div>
                {% unless docsPrefix contains 'paas/' %}
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 可部署在哪里？</div>
                    <div class="tb-faq-answer">
                        <p>可将 ThingsBoard 部署在云端、本地机房或笔记本、PC 甚至树莓派上。建议以 Docker 安装开始：</p>
                        <ul>
                            <li><a href="/docs/user-guide/install/{{docsPrefix}}docker/" target="_blank">Linux & macOS</a></li>
                            <li><a href="/docs/user-guide/install/{{docsPrefix}}docker-windows/" target="_blank">Windows</a></li>
                        </ul>
                        <p>也可参阅<a href="/docs/user-guide/install/{{docsPrefix}}cluster-setup/" target="_blank">集群搭建</a>指南。</p>
                    </div>
                </div>
                {% endunless %}
                {% unless page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">可将 Community Edition 用于商业项目吗？</div>
                    <div class="tb-faq-answer">
                        <p>可以。CE 采用 <a href="https://github.com/thingsboard/thingsboard/blob/master/LICENSE" target="_blank">Apache 2.0</a> 许可，商业使用无限制。可在 CE 上构建、销售和部署商业产品。</p>
                    </div>
                </div>
                {% endunless %}
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">可从 CE 迁移到 PE 吗？</div>
                    <div class="tb-faq-answer">
                        <p>可以。从 ThingsBoard社区版迁移至 Professional Edition <b>不会丢失遥测数据及配置</b>。升级会保留现有设置，实现平滑过渡。</p>
                        <p>请注意：对 Community Edition 源码的<b>任何自定义修改</b>在升级过程中<b>将被移除</b>。</p>
                        <p>见<a href="/docs/pe/user-guide/install/upgrade-instructions/upgrade-from-ce/" target="_blank">从 CE 升级说明</a>。升级前请备份数据。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">如何查看当前使用的 ThingsBoard 版本？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" %}
                        <p>ThingsBoard Cloud 为全托管平台，由 ThingsBoard 团队定期更新至最新版本，您无需关心维护或升级。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>ThingsBoard Professional Edition 中可通过多种方式查看平台版本。最简单的方式是以 SysAdmin 身份登录，在首页屏幕左下角会有一个部件显示当前平台版本及是否有可用升级。</p>
                        <p>若无 SysAdmin 账户权限，可从侧边栏打开 <a href="/docs/{{docsPrefix}}user-guide/white-labeling/" target="_blank">白标</a>选项卡，启用<b>显示平台名称和版本</b>即可查看当前版本。</p>
                        {% else %}
                        <p>最简单的方式是以 SysAdmin 身份登录，在首页屏幕左下角会有一个部件显示当前平台版本及是否有可用升级。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否与第三方系统集成？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>可以，通过 REST API、规则引擎以及平台集成（PE 独有，含 30+ 内置连接器，支持 OPC-UA、LoRaWAN 网络、云平台等）。</p>
                        {% else %}
                        <p>可以，可通过 REST API 或规则引擎将 ThingsBoard 社区版与第三方系统集成。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 是否支持白标？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>支持，白标自<b>Pilot</b>计划及以上可用。</p>
                        {% else %}
                        <p>不支持，白标仅在 Professional Edition 中提供。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否替换菜单中的默认 ThingsBoard logo？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" %}
                        <p>在 ThingsBoard Cloud 中，所有品牌可在用户界面中通过内置 <a href="/docs/{{docsPrefix}}user-guide/white-labeling/#customize-thingsboard-web-interface" target="_blank">白标</a>模块直接配置。</p>
                        <p>您只需几步即可完成：</p>
                        <ul>
                            <li>用自有企业视觉替换 ThingsBoard logo 和 favicon；</li>
                            <li>自定义登录页和系统页，从首次访问起展示您的品牌；</li>
                            <li>调整配色与样式（主色、强调色、logo 尺寸、CSS 微调）以贴合品牌形象；</li>
                            <li>应用前实时预览更改；</li>
                            <li>配置自定义域名：映射自有域名（如 portal.company.com），使用户通过您的品牌 URL 访问平台。</li>
                        </ul>
                        <p>不仅限于 logo。使用 ThingsBoard Cloud 您还可以：</p>
                        <ul>
                            <li>设置自定义<a href="/docs/{{docsPrefix}}user-guide/mail-templates/" target="_blank">邮件模板</a>，使平台通知体现您的品牌；</li>
                            <li>添加<a href="/docs/{{docsPrefix}}user-guide/custom-translation/" target="_blank">自定义翻译</a>，让平台 “说”用户的语言；</li>
                            <li>创建<a href="/docs/{{docsPrefix}}user-guide/custom-menu/" target="_blank">自定义菜单</a>，使导航适配业务工作流。</li>
                        </ul>
                        <p>从而获得完全品牌化的平台：用户看到的是您的 logo、配色、邮件和定制菜单。</p>
                        {% elsif page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>在 Professional Edition 中，所有品牌可在用户界面中通过内置 <a href="/docs/{{docsPrefix}}user-guide/white-labeling/#customize-thingsboard-web-interface" target="_blank">白标</a>模块直接配置。</p>
                        <p>您只需几步即可完成：</p>
                        <ul>
                            <li>用自有企业视觉替换 ThingsBoard logo 和 favicon；</li>
                            <li>自定义登录页和系统页，从首次访问起展示您的品牌；</li>
                            <li>调整配色与样式（主色、强调色、logo 尺寸、CSS 微调）以贴合品牌形象；</li>
                            <li>应用前实时预览更改；</li>
                            <li>配置自定义域名：映射自有域名（如 portal.company.com），使用户通过您的品牌 URL 访问平台。</li>
                        </ul>
                        <p>不仅限于 logo。使用 PE 您还可以：</p>
                        <ul>
                            <li>设置自定义<a href="/docs/{{docsPrefix}}user-guide/mail-templates/" target="_blank">邮件模板</a>，使平台通知体现您的品牌；</li>
                            <li>添加<a href="/docs/{{docsPrefix}}user-guide/custom-translation/" target="_blank">自定义翻译</a>，让平台 “说”用户的语言；</li>
                            <li>创建<a href="/docs/{{docsPrefix}}user-guide/custom-menu/" target="_blank">自定义菜单</a>，使导航适配业务工作流。</li>
                        </ul>
                        <p>从而获得完全品牌化的平台：用户看到的是您的 logo、配色、邮件和定制菜单。</p>
                        {% else %}
                        <p>Community Edition 不包含内置白标功能。但技术上可通过修改源码并重新构建平台来替换默认 ThingsBoard logo，需具备开发能力并熟悉 ThingsBoard 代码库；每次平台升级后此类修改需重新应用。</p>
                        <p>若需更简便、可配置的方案，建议考虑 Professional Edition。使用 PE 可直接在界面中上传自有 logo 和 favicon、自定义登录与系统页、调整配色与品牌调色板，并可定制<a href="/docs/pe/user-guide/mail-templates/" target="_blank">邮件模板</a>、<a href="/docs/pe/user-guide/custom-translation/" target="_blank">翻译</a>和<a href="/docs/pe/user-guide/custom-menu/" target="_blank">自定义菜单</a>，无需改代码，即可为客户和租户提供完全品牌化的专业体验。</p>
                        <p>更多说明见<a href="/docs/pe/user-guide/white-labeling/#customize-thingsboard-web-interface" target="_blank">PE 白标指南</a>。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">购买前能否试用 Professional Edition？</div>
                    <div class="tb-faq-answer">
                        <p>可以，使用<b>免费计划</b>即可。该计划包含所有 PE 功能的评估权限，包括插件：Edge 计算与 Trendz。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">在哪里可以找到源码？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>Professional Edition 为专有软件，源码不对外公开。</p>
                        {% else %}
                        <p>源码托管于 <a href="https://github.com/thingsboard/thingsboard" target="_blank">GitHub</a>，您可在 <a href="https://github.com/thingsboard/thingsboard/blob/master/LICENSE" target="_blank">Apache 2.0 许可</a>下 fork、修改和贡献，个人与商业使用均免费，可部署于任意环境。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否为 ThingsBoard 做贡献？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>Professional Edition 为闭源软件，不接受外部贡献。</p>
                        {% else %}
                        <p>可以。欢迎在 <a href="https://github.com/thingsboard/thingsboard/" target="_blank">GitHub</a> 上提交 Pull Request 或参与贡献。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-load-more" onclick="loadMoreTbFaq(this)">
                    <div class="title">加载更多 FAQ</div>
                </div>
            </div>
            {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
            <div id="tb-faq-cat-addons" class="tb-faq-category">
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">什么是 ThingsBoard 插件？</div>
                    <div class="tb-faq-answer">
                        <p>插件是<b>扩展</b> ThingsBoard Professional Edition 能力的互补产品，与您的 ThingsBoard 实例无缝集成，需 PE 订阅方可使用。插件包括 <b>ThingsBoard PE Edge</b>（边缘计算）和 <b>Trendz Analytics</b>（高级分析/AI）。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 有哪些插件？</div>
                    <div class="tb-faq-answer">
                        <p><a href="/docs/pe/edge/getting-started-guides/what-is-edge/" target="_blank">ThingsBoard PE Edge</a> 与 <a href="/docs/trendz/what-is-trendz/" target="_blank">Trendz Analytics</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">什么是 ThingsBoard Edge？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard Edge 是一种<b>边缘计算方案</b>，在远端现场本地运行，以更低延迟处理数据并与中心 ThingsBoard 服务器保持同步，支持离线运行并在恢复连接后自动同步。</p>
                        <p>Edge Professional Edition 作为 ThingsBoard PE 订阅的插件提供，在边缘计算核心能力之上增加白标、方案模板、平台集成、调度器及客户层级管理等企业功能。</p>
                        <p>所含 Edge 实例数量<b>取决于订阅计划</b>，额外实例可单独购买。详情请查看您的计划或<a href="/docs/contact-us/" target="_blank">联系我们</a>。</p>
                        <p>设置与配置详见 <a href="/docs/pe/edge/" target="_blank">Edge 文档</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">什么是 Trendz Analytics？</div>
                    <div class="tb-faq-answer">
                        <p>Trendz Analytics 是面向 ThingsBoard PE 的<b>高级分析平台</b>，将异常检测、预测分析、计算字段、AI 助手、Metric Explorer 与丰富可视化整合于统一工作区。</p>
                        <p>支持分析 IoT 数据、发现异常并预测结果，与 ThingsBoard 环境无缝集成。</p>
                        <p>更多信息见 <a href="/docs/trendz/" target="_blank">Trendz 文档</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否在 ThingsBoard Community Edition 上使用 Edge 和/或 Trendz 插件？</div>
                    <div class="tb-faq-answer">
                        <ul>
                            <li><b>Edge：</b>不能。Edge 版本须与 ThingsBoard Server 版本一致，PE Edge 连接 ThingsBoard PE Server。但可使用 <b>CE Edge</b> 配合 ThingsBoard CE Server，CE Edge 与 ThingsBoard CE 一样免费开源。</li>
                            <li><b>Trendz Analytics：</b>不能，Trendz 需要 ThingsBoard Professional Edition。</li>
                        </ul>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否在没有 ThingsBoard 的情况下使用 Edge 和/或 Trendz？</div>
                    <div class="tb-faq-answer">
                        <p>不能。二者均用于增强 ThingsBoard 能力，不能作为独立方案运行：</p>
                        <ul>
                            <li><b>PE Edge：</b>需连接并与 ThingsBoard PE Server（Cloud、Private Cloud 或自托管）同步。</li>
                            <li><b>Trendz Analytics：</b>需以 ThingsBoard PE 为数据源。</li>
                        </ul>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">购买前能否试用插件？</div>
                    <div class="tb-faq-answer">
                        <p>可从<b>免费</b>计划开始，该计划在设备数量上有限制，但永久启用 Edge 计算与 Trendz 插件，可免费体验插件功能。</p>
                        <p>更大规模部署可升级至付费计划，获得更高设备上限与更多功能。</p>
                    </div>
                </div>
                <div class="tb-faq-load-more" onclick="loadMoreTbFaq(this)">
                    <div class="title">加载更多 FAQ</div>
                </div>
            </div>
            <div id="tb-faq-cat-private-cloud" class="tb-faq-category">
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">什么是 ThingsBoard 私有云？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard 私有云是由我们团队为您部署和运维的<b>全托管、隔离的 ThingsBoard Professional Edition 集群</b>。</p>
                        <p>我们提供基础设施、7×24 补丁与监控、自动备份，并提供 SLA 保障的可用性（99%–99.99%，依计划而定）。入驻时可选择符合合规或延迟要求的区域：欧盟、北美或亚太。</p>
                        <p><b>所有环境均托管于通过 ISO 27001/PCI-DSS 认证的数据中心。</b>工程师可专注于构建 IoT 应用，无需管理 DevOps。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">私有云与 ThingsBoard Cloud 有何不同？</div>
                    <div class="tb-faq-answer">
                        <p>私有云为您的组织提供专属、隔离环境，ThingsBoard Cloud 则为共享多租户 SaaS 平台。</p>
                        <p>私有云为合规敏感行业提供<b>更强安全、定制 SLA</b>与<b>基础设施隔离</b>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">私有云相比自托管有哪些优势？</div>
                    <div class="tb-faq-answer">
                        <p>私有云降低运维复杂度：</p>
                        <ul>
                        <li><b>零 DevOps 负担</b>：无需自行管理基础设施或 DevOps。</li> 
                        <li><b>可用性保障</b>：99.9–99.99% 可用性 SLA，含服务抵扣。</li> 
                        <li><b>更快上线</b>：1–2 小时即可部署，自托管则需数周。</li>
                        <li><b>可扩展</b>：Kubernetes 基础设施随流量扩展。</li> 
                        <li><b>成本可预期</b>：单一月费替代基础设施与人力成本。</li>
                        </ul>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">什么是“可用时间”以及如何计算？</div>
                    <div class="tb-faq-answer">
                        <p>可用时间按计费月内服务正常运行时间占比衡量。</p>
                        <p><b>公式：</b>可用时间 (%) = ((总时间 – 停机时间) / 总时间) × 100。</p>
                        <p>计划内维护、安全补丁及客户配置导致的问题不计入停机时间。</p>
                        </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否选择私有云托管区域？</div>
                    <div class="tb-faq-answer">
                        <p>可以，私有云可部署在您选择的 AWS、Azure 或 GCP 区域，以满足数据属地与延迟要求。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">谁负责管理私有云基础设施？</div>
                    <div class="tb-faq-answer">
                        <p><b>ThingsBoard 团队负责全部基础设施、更新、监控与维护</b>。您专注 IoT 应用，我们负责平台运维。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">私有云包含哪些支持？</div>
                    <div class="tb-faq-answer">
                        <p>私有云包含<b>优先支持、专属成功管理与定制 SLA 选项</b>，支持级别在服务协议中约定。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否自定义私有云配置？</div>
                    <div class="tb-faq-answer">
                        <p>可以，私有云支持白标、自定义域名及按需扩展基础设施等自定义配置。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">私有云是否符合安全标准？</div>
                    <div class="tb-faq-answer">
                        <p>私有云设计支持<b>GDPR、HIPAA 与 ISO 27001</b>等合规要求，具体认证取决于部署配置与服务协议。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">如何开始使用私有云？</div>
                    <div class="tb-faq-answer">
                        <p><a href="/docs/contact-us/" target="_blank">联系我们</a>沟通需求，我们将协助设计适合您场景的私有云配置。</p>
                    </div>
                </div>
                <div class="tb-faq-load-more" onclick="loadMoreTbFaq(this)">
                    <div class="title">加载更多 FAQ</div>
                </div>
            </div>
            {% endif %}
            <div id="tb-faq-cat-ai" class="tb-faq-category">
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 是否支持 AI 集成？</div>
                    <div class="tb-faq-answer">
                        <p>支持。ThingsBoard 规则引擎提供<a href="/docs/user-guide/rule-engine-2-0/nodes/external/ai-request/" target="_blank">AI Request 节点</a>，可与 OpenAI、Azure OpenAI 及自定义 AI 端点集成。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否用 AI 做预测性维护？</div>
                    <div class="tb-faq-answer">
                        <p>可以。ThingsBoard 具备内置 AI 集成能力，可使用<a href="/docs/user-guide/rule-engine-2-0/nodes/external/ai-request/" target="_blank">AI Request 节点</a>将遥测数据发送给机器学习模型，用于预测分析、异常检测与维护排程。</p>
                        <p>实现细节见预测性维护示例。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">支持哪些 AI 服务商？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard 支持多种 AI 服务商，包括但不限于 OpenAI、Azure OpenAI 及自定义 API 端点。详见<a href="/docs/{{docsPrefix}}samples/analytics/ai-models/" target="_blank">AI 模型</a>页。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否用 ThingsBoard 数据训练自定义 ML 模型？</div>
                    <div class="tb-faq-answer">
                        <p>可以。通过<a href="/docs/{{docsPrefix}}api/" target="_blank">REST API</a>或<a href="/docs/pe/user-guide/csv-xls-data-export/" target="_blank">数据导出功能 (PE)</a>导出历史遥测并在外部训练模型，将训练好的模型部署为 API 端点后，用<a href="/docs/user-guide/rule-engine-2-0/nodes/external/ai-request/" target="_blank">AI Request 节点</a>集成。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否有 AI 用例示例？</div>
                    <div class="tb-faq-answer">
                        <p>有，文档中有示例，包括<a href="/docs/{{docsPrefix}}samples/analytics/ai-predictive-maintenance/" target="_blank">异常检测</a>与<a href="/docs/{{docsPrefix}}samples/analytics/ai-models/" target="_blank">自然语言处理</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否需要单独的 AI 订阅？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard 集成已包含，若使用 OpenAI、Azure 等外部 AI 服务则需单独订阅；自定义 AI 端点完全由您掌控。</p>
                    </div>
                </div>
            </div>
            <div id="tb-faq-cat-deployment" class="tb-faq-category">
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard可以安装在哪里？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>Professional Edition 提供三种部署方式：</p>
                        <ul>
                        <li><b>ThingsBoard Cloud：</b>全托管SaaS（北美或欧盟区域）。</li>
                        <li><b>私有云：</b>在您选择的区域内的专属托管实例。</li>
                        <li><b>自托管：</b>在自有基础设施上（本地或云：AWS、Azure、GCP、DigitalOcean），支持Docker或Kubernetes。</li>
                        </ul>
                        {% else %}
                        <p>Community Edition可安装于：</p>
                        <ul>
                        <li><b>本地</b>服务器或虚拟机，支持 Docker与Kubernetes部署。</li>
                        <li><b>云平台：</b>AWS、Microsoft Azure、DigitalOcean、Google Cloud Platform。</li>
                        </ul>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard是否支持集群？</div>
                    <div class="tb-faq-answer">
                        <p>支持，所有部署方式均支持集群。</p>
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>配置详见<a href="/docs/user-guide/install/pe/cluster-setup/" target="_blank">集群搭建指南</a>。</p>
                        {% else %}
                        <p>配置详见<a href="/docs/user-guide/install/cluster-setup/" target="_blank">集群搭建指南</a>。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">硬件要求是什么？</div>
                    <div class="tb-faq-answer">
                        <p><b>最低：</b>2 核 CPU、4GB 内存用于测试。</p>
                        <p><b>生产建议：</b>8+ 核 CPU、16GB+ 内存随设备数与消息量扩展。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard可支持多少设备？</div>
                    <div class="tb-faq-answer">
                    {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>设备容量由具体部署与订阅档位决定：</p>
                        <ul>
                            <li><b>ThingsBoard Cloud：</b>按计划限定（如免费5台Business最多1000 台），<b>Business</b> 计划可增购设备容量。</li>
                            <li><b>私有云：</b>面向大规模，典型为5000至 100000+ 台设备。</li>
                            <li><b>自托管 (PE)：</b>受许可限制（如Maker10台Business最多1000台），<b>Business</b>许可可购买额外设备包。</li>
                        </ul>
                    {% else %}
                        <p>Community Edition 在设备数量上<b>无软件层面限制</b>，实际容量完全取决于硬件、数据库配置与部署架构（单机或集群）。</p>
                        <p>单台现代服务器通常可支撑数万设备，<b>集群部署</b>可扩展至数百万并发连接。</p>
                    {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard数据存储在哪里？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard支持两种数据库方案：</p>
                        <ul>
                        <li><b>纯 SQL：</b>PostgreSQL默认且推荐用于负载适中（&lt; 5000 条/秒）的开发与生产环境。</li>
                        <li><b>混合数据库：</b>PostgreSQL + Cassandra适用于生产环境100万+设备或高写入（&gt; 5000 条/秒）。</li>
                        </ul>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard是否支持多租户？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>支持。ThingsBoard Cloud支持多租户，每个<b>租户需单独订阅</b>。</p>
                        <p>租户内可建立客户层级，租户管理员可在同一订阅下管理多个客户，兼顾灵活性与访问控制。</p>
                        <p>ThingsBoard自托管订阅在同一计划内支持多租户。</p>
                        {% else %}
                        <p>支持，ThingsBoard社区版开箱即支持多租户。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard是否支持 OTA（空中）固件更新？</div>
                    <div class="tb-faq-answer">
                        <p>支持ThingsBoard支持 OTA（Over-the-Air）固件更新。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">API请求是否收费？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>是否收费取决于部署类型：</p>
                        <ul>
                        <li><b>ThingsBoard Cloud与私有云：</b>API请求包含在订阅内无额外费用。</li>
                        <li><b>自托管：</b>不收取API费用也无程序化限制。</li>
                        </ul>
                        {% else %}
                        <p>不收费。Community Edition对API请求不收费且无限制，性能取决于服务器与基础设施。</p>
                        {% endif %}
                    </div>
                </div>
                {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" %}
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">超出计划的API限制会怎样？</div>
                    <div class="tb-faq-answer">
                        <p>API 访问可能被限流直至下一计费周期，或可升级到更高档计划。</p>
                    </div>
                </div>
                {% endif %}
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 有移动端应用吗？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>有。Professional Edition提供<a href="/products/mobile-pe/" target="_blank">PE移动应用</a>，具备企业功能与白标。</p>
                        {% else %}
                        <p>有。ThingsBoard <a href="/products/mobile/" target="_blank">移动应用</a>免费开源（Apache 2.0 许可），支持iOS与Android可与ThingsBoard CE Server配合使用。</p>
                        {% endif %}
                    </div>
                </div>
                {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">取消订阅后数据会怎样？</div>
                    <div class="tb-faq-answer">
                        <p>取消后数据处理取决于部署模式：</p>
                        <ul>
                            <li><b>ThingsBoard Cloud 与私有云：</b>取消后，您的数据将从我们的服务器永久删除。</li>
                            <li><b>自托管 (PE)：</b>平台在您自有基础设施上，所有数据仍保留在您的环境中，您拥有完全所有权并可选择保留、导出或删除。</li>
                        </ul>
                    </div>
                </div>
                {% endif %}
                <div class="tb-faq-load-more" onclick="loadMoreTbFaq(this)">
                    <div class="title">加载更多</div>
                </div>
            </div>
            <div id="tb-faq-cat-security" class="tb-faq-category">
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">我的ThingsBoard实例是否安全？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>安全性取决于部署类型：</p>
                        <ul>
                        <li><b>Cloud/私有云</b>部署于符合ISO27001/SOC2的基础设施。</li>
                        <li><b>自托管</b>安全取决于您的基础设施配置，需自行管理基础设施安全、网络与SSL/TLS。</li>
                        </ul>
                        {% else %}
                        <p>可以做到安全但取决于您的部署与基础设施配置。</p>
                        {% endif %}
                        <p>ThingsBoard提供设备认证、加密通信（SSL/TLS）、基于角色的访问控制与审计日志。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 是否支持加密？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>支持传输加密（TLS/SSL）更多加密能力可能取决于订阅与部署类型。</p>
                        <p>静态数据加密需在数据库层配置详见<a href="/docs/pe/user-guide/ui/security-settings/" target="_blank">安全文档</a>。</p>
                        {% else %}
                        <p>支持，Community Edition包含传输加密（TLS/SSL）。</p>
                        <p>静态数据加密需在数据库层配置，详见<a href="/docs/user-guide/ui/security-settings/" target="_blank">安全文档</a>。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 是否支持 SSO/OAuth？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>支持，PE 中提供 SSO 与 OAuth 及更多企业功能。</p>
                        <p>配置说明见<a href="/docs/pe/user-guide/ui/security-settings/" target="_blank">安全文档</a>。</p>
                        {% else %}
                        <p>支持，Community Edition 包含 SSO（单点登录）与 OAuth。</p>
                        <p>配置说明见<a href="/docs/user-guide/ui/security-settings/" target="_blank">安全文档</a>。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否在指定区域存储 ThingsBoard 数据？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <ul>
                        <li><b>Cloud：</b>数据存储在北美或欧盟，取决于您选择的云区域（美国或欧洲）。</li>
                        <li><b>私有云/自托管：</b>可以，您可完全控制数据存储位置。</li>
                        </ul>
                        {% else %}
                        <p>可以，数据存储位置完全由您控制。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">设备如何认证？</div>
                    <div class="tb-faq-answer">
                        <p>ThingsBoard 支持多种认证方式：访问令牌、X.509 证书及用户名/密码，每台设备具有独立凭证。详见<a href="/docs/{{docsPrefix}}user-guide/device-credentials/" target="_blank">设备认证选项</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 是否支持基于角色的访问控制 (RBAC)？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>支持，ThingsBoard 提供 <a href="/docs/pe/user-guide/rbac/" target="_blank">RBAC</a>。</p>
                        <p>Professional Edition 提供高级 RBAC：自定义角色、层级权限与基于组的访问控制。</p>
                        {% else %}
                        <p>Community Edition 采用<b>简明安全模型</b>，含三种主要角色：系统管理员、租户管理员与客户用户。系统管理员管理租户；租户管理员管理该租户下的设备、仪表盘、客户等实体；客户用户可查看仪表盘并控制分配给该客户的设备。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 是否符合法规（如 GDPR）？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <ul>
                        <li><b>Cloud：</b>基础设施符合ISO27001/SOC2。</li>
                        <li><b>私有云：</b>GDPR合规取决于您如何配置与使用平台。</li>
                        <li><b>自托管：</b>合规取决于您的基础设施与实践。</li>
                        </ul>
                        {% else %}
                        <p>合规取决于您的托管环境与数据安全实践。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否与外部认证提供商集成？</div>
                    <div class="tb-faq-answer">
                        <p>可以，ThingsBoard支持OAuth2、LDAP与SAML集成。</p>
                    </div>
                </div>
                <div class="tb-faq-question tb-faq-hidden">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否有审计日志？</div>
                    <div class="tb-faq-answer">
                        <p>有ThingsBoard会记录用户操作。</p>
                    </div>
                </div>
                <div class="tb-faq-load-more" onclick="loadMoreTbFaq(this)">
                    <div class="title">加载更多</div>
                </div>
            </div>
            <div id="tb-faq-cat-support" class="tb-faq-category">
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">ThingsBoard 有哪些支持？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>自 4.2 版本起，我们为生产用户提供<a href="/docs/pe/releases/release-policy/" target="_blank">长期支持 (LTS)</a>版本含扩展安全更新与稳定性改进。</p>
                        <p>如有问题可随时<a href="/docs/contact-us/" target="_blank">联系我们</a>，社区支持面向所有用户。</p>
                        {% else %}
                        <p>ThingsBoard团队不为Community Edition用户提供专属支持。支持以社区形式通过 <a href="https://github.com/thingsboard/thingsboard" target="_blank">GitHub</a>（问题反馈与贡献）、<a href="https://stackoverflow.com/questions/tagged/thingsboard" target="_blank">Stack Overflow</a>（开发问题）、<a href="/docs/{{docsPrefix}}" target="_blank">文档</a>（指南与教程）、<a href="https://www.youtube.com/thingsboard" target="_blank">YouTube 频道</a>（视频教程）获取。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否提供专业服务？</div>
                    <div class="tb-faq-answer">
                        <p>提供。ThingsBoard提供咨询、<a href="/services/development-services/" target="_blank">定制开发</a>、<a href="/services/trainings/" target="_blank">学习资源</a>与部署支持。<a href="/docs/contact-us/" target="_blank">联系我们</a>沟通需求。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">如何反馈Bug？</div>
                    <div class="tb-faq-answer">
                        {% if page.docsPrefix contains "paas/" or docsPrefix contains "paas/" or page.docsPrefix == "pe/" or docsPrefix == "pe/" %}
                        <p>付费用户可通过 Support Portal 反馈，或在 <a href="https://github.com/thingsboard/thingsboard/issues" target="_blank">GitHub</a>提交。请提供复现步骤、日志与系统信息。</p>
                        {% else %}
                        <p>请在 <a href="https://github.com/thingsboard/thingsboard/issues" target="_blank">GitHub Issues</a>提交并附上复现步骤、日志与系统信息，社区成员与维护者会跟进。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">是否有培训资源？</div>
                    <div class="tb-faq-answer">
                        <p>有提供完整文档、视频教程与示例项目，专业服务含定制培训<a href="/services/trainings/" target="_blank">学习资源</a>。</p>
                    </div>
                </div>
                <div class="tb-faq-question">
                    <div class="tb-faq-question-title" onclick="toggleTbFaq(this)">能否获得部署方面的帮助？</div>
                    <div class="tb-faq-answer">
                        <p>可以专业服务包含部署支持、架构评审与生产环境搭建。<a href="/docs/contact-us/" target="_blank">联系我们</a>沟通部署需求。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>