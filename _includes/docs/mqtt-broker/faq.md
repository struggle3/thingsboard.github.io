<style>
.tbmq-faq-wrapper { padding: 20px 15px 80px; max-width: 1200px; margin: 0 auto; }
.tbmq-faq-wrapper h1 { text-align: center; font-size: 36px; font-weight: 500; line-height: 48px; margin-bottom: 48px; color: #212529; }
.tbmq-faq-sections { display: flex; gap: 40px; }
@media (max-width: 1200px) { .tbmq-faq-sections { flex-direction: column; } }
.tbmq-faq-tabs { display: flex; flex-direction: column; align-items: flex-start; padding: 8px; width: fit-content; margin-bottom: 24px; }
@media (max-width: 690px) { .tbmq-faq-tabs { width: 100%; } }
.tbmq-faq-tab { width: 100%; font-size: 24px; font-weight: 500; line-height: 36px; padding: 24px 32px; border: 1.5px solid transparent; border-radius: 24px; cursor: pointer; color: #757575; }
.tbmq-faq-tab:hover { color: #757575; }
.tbmq-faq-tab.active { color: #000000DE; border-bottom: 1.5px solid #E6F0FC; background: #F4F8FE; }
.tbmq-faq-answers { flex: 1.5; }
.tbmq-faq-category { display: none; }
.tbmq-faq-category.active { display: block; }
.tbmq-faq-question { border-bottom: 1.5px solid rgba(62,154,248,0.12); margin-bottom: 7px; }
.tbmq-faq-question-title { 
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
.tbmq-faq-question-title:hover { color: rgba(33, 33, 33, 0.78) }
.tbmq-faq-question-title:after { 
    font-family: "Font Awesome 5 Free"; 
    font-weight: 900 ; 
    color: rgba(0,0,0,0.38); 
    content: "\f078"; 
    position: absolute; 
    right: 8px; 
    top: 22px; 
    transition: transform 0.3s; 
}
.tbmq-faq-question.open .tbmq-faq-question-title:after { transform: rotate(180deg); }
.tbmq-faq-answer { 
    display: none; 
    padding: 5px 50px 25px 10px; 
    margin: 0 10px 10px; 
    font-size: 14px; 
    line-height: 24px; 
}
.tbmq-faq-question.open .tbmq-faq-answer { display: block; }
.tbmq-faq-answer p, .tbmq-faq-answer li { font-size: 14px; color: #3D3D3D; line-height: 24px; }
.tbmq-faq-answer a { color: #2A7DEC; text-decoration: none; }
.tbmq-faq-answer a:hover { text-decoration: underline; }
.tbmq-faq-answer ul { margin: 20px 0; padding-left: 30px; list-style: disc; }
.tbmq-faq-answer li { margin-bottom: .75em; }
</style>

<script>
function toggleTbmqFaq(element) {
    var question = element.closest('.tbmq-faq-question');
    question.classList.toggle('open');
}

function switchTbmqFaqTab(tabId) {
    // Remove active from all tabs
    var tabs = document.querySelectorAll('.tbmq-faq-tab');
    tabs.forEach(function(tab) {
        tab.classList.remove('active');
    });
    
    // Remove active from all categories
    var categories = document.querySelectorAll('.tbmq-faq-category');
    categories.forEach(function(cat) {
        cat.classList.remove('active');
    });
    
    // Add active to clicked tab
    event.target.classList.add('active');
    
    // Add active to corresponding category
    var category = document.getElementById('tbmq-faq-cat-' + tabId);
    if (category) category.classList.add('active');
}
</script>

<h2>TBMQ - {{tbmqName}}</h2>

<div class="tbmq-faq-wrapper">
    <div class="tbmq-faq-sections">
        <div class="tbmq-faq-tabs">
            <div class="tbmq-faq-tab active" onclick="switchTbmqFaqTab('start')">入门指南</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('configuration')">配置与部署</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('connectivity')">连接性</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('usage')">功能与使用</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('security')">安全与可靠性</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('subscriptions')">订阅与消息</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('performance')">性能与扩展</div>
            <div class="tbmq-faq-tab" onclick="switchTbmqFaqTab('licensing')">许可与支持</div>
        </div>
        <div class="tbmq-faq-answers">
            <div id="tbmq-faq-cat-start" class="tbmq-faq-category active">
               {% if docsPrefix == null %}
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">什么是 TBMQ 社区版 (CE)？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 是 ThingsBoard 开发的高性能 MQTT broker，可在 MQTT 客户端与 IoT 应用之间实现高效、可靠、可扩展的通信。TBMQ 支持 <b>MQTT 3.x</b> 和 <b>MQTT 5.0</b>，可与多种设备和行业用例兼容。</p>
                        <p>Broker 提供两个版本：<b>社区版 (CE)</b> 和 <b>专业版 (PE)</b>。</p>
                        <p><b>社区版</b>为<b>免费开源</b>，适合希望探索、原型验证和测试 MQTT 方案的开发者和团队，无许可成本。它提供可在本地、本地部署或云上运行的 MQTT broker。CE 具备可靠消息、可扩展性和监控等核心功能，是学习与生产级用例的理想起点。</p>
                        <p>若首次使用 TBMQ，建议阅读 <a href="/docs/{{docsPrefix}}mqtt-broker/getting-started-guides/what-is-thingsboard-mqtt-broker/" target="_blank">什么是 TBMQ</a> 和 <a href="/docs/{{docsPrefix}}mqtt-broker/getting-started/" target="_blank">入门指南</a>，了解其架构、部署和主要功能。</p>
                    </div>
                </div>
                {% endif %}
                {% if docsPrefix == "pe/" %}
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">什么是 TBMQ 专业版 (PE)？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 是 ThingsBoard 开发的高性能 MQTT broker，可在 MQTT 客户端与 IoT 应用之间实现高效、可靠、可扩展的通信。TBMQ 支持 <b>MQTT 3.x</b> 和 <b>MQTT 5.0</b>，可与多种设备和行业用例兼容。</p>
                        <p>Broker 提供两个版本：<b>社区版 (CE)</b> 和 <b>专业版 (PE)</b>。</p>
                        <p><b>专业版 (PE)</b> 为<b>企业级</b>版本，面向<b>商业 IoT 部署</b>和大规模生产环境。除社区版全部能力外，还包含：</p>
                        <ul>
                            <li><b>白标品牌</b>及 UI 定制</li>
                            <li><b>高级安全与访问控制</b></li>
                            <li><b>增强监控、分析与报表</b></li>
                            <li><b>专业支持与维护</b></li>
                        </ul>
                        <p>PE 面向需要高吞吐、运行可靠性和高级管理能力以支撑关键 IoT 基础设施的组织。</p>
                        <p>若首次使用 TBMQ，建议阅读 <a href="/docs/{{docsPrefix}}mqtt-broker/getting-started-guides/what-is-thingsboard-mqtt-broker/" target="_blank">什么是 TBMQ</a> 和 <a href="/docs/{{docsPrefix}}mqtt-broker/getting-started/" target="_blank">入门指南</a>，详细了解其功能与部署选项。</p>
                    </div>
                </div>
                {% endif %}
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何开始使用？</div>
                    <div class="tbmq-faq-answer">
                        <p>建议使用 <b>Docker</b> 在本地 PC 上<a href="/docs/{{docsPrefix}}mqtt-broker/install/installation-options/" target="_blank">安装</a> TBMQ，并按照 <a href="/docs/{{docsPrefix}}mqtt-broker/getting-started/" target="_blank">入门指南</a>操作。该指南涵盖安装、配置和初步测试，帮助您快速可靠地建立首次 MQTT 连接。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何安装 TBMQ？</div>
                    <div class="tbmq-faq-answer">
                        <p>可使用 <b>Docker</b>、<b>Kubernetes 脚本</b>或 <b>Helm</b> 在本地或云上安装 TBMQ。<a href="/docs/{{docsPrefix}}mqtt-broker/install/installation-options/" target="_blank">安装指南</a>中有详细步骤说明，包括 Kafka、Redis 和 PostgreSQL 等依赖的配置。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何用 Docker 或 Helm 启动 TBMQ？</div>
                    <div class="tbmq-faq-answer">
                        <p>使用 <b>Docker</b> 时，运行提供的 Docker Compose 文件，可一键启动所有必需服务（Kafka、Redis、PostgreSQL 和 MQTT broker）。
                            使用 <b>Kubernetes</b> 时，使用官方 Helm  chart 将 TBMQ 部署为可扩展、高可用的集群。Helm chart 支持配置持久化、资源限制和监控等参数。
                            无论测试还是生产，两种方式均可在数分钟内让 TBMQ 运行起来。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 的系统要求是什么？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 可在一般硬件上运行，适用于测试或小规模评估。<b>最低要求</b>为：</p>
                        <ul>
                            <li><b>CPU：</b>1 核</li>
                            <li><b>内存：</b>2 GB RAM</li>
                        </ul>
                        <p>在典型环境中为获得稳定、顺畅的运行，<b>推荐配置</b>为：</p>
                        <ul>
                            <li><b>CPU：</b>4 核</li>
                            <li><b>内存：</b>8 GB RAM</li>
                            <li><b>存储：</b>50 GB 可用磁盘空间</li>
                            <li><b>操作系统：</b>Linux（x86-64 架构）</li>
                        </ul>
                        <p>集群或生产环境下的硬件需求取决于客户端数量和消息吞吐量。</p>
                        <p>高负载部署应为 <b>Kafka</b>、<b>Redis</b> 和 <b>PostgreSQL</b> 分配独立节点，以保障最佳可扩展性与可靠性。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何将 TBMQ 升级到更新版本？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 升级流程简单。<a href="/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/" target="_blank">升级指南</a>提供各版本的升级说明，以及兼容性变更和配置更新说明。</p>
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-configuration" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何配置 TBMQ 用于生产环境？</div>
                    <div class="tbmq-faq-answer">
                        <p>生产环境中，TBMQ 应针对性能、安全和容错进行配置。建议：</p>
                        <ul>
                            <li>为 MQTT 和 WebSocket 连接启用 <b>SSL/TLS</b> 加密。</li>
                            <li>配置 <b>认证提供方</b>以安全验证客户端。</li>
                            <li>为各 topic 配置合适的 <b>Kafka 分区</b>数量，调整生产者和消费者参数，并调整 <b>Redis 有状态连接</b>以获得最佳吞吐量。</li>
                            <li>根据系统资源调整 JVM 内存和线程池设置。</li>
                        </ul>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">能否在 Kubernetes 中部署 TBMQ？</div>
                    <div class="tbmq-faq-answer">
                        <p>可以。TBMQ 通过官方 <b>Helm chart</b> 或 k8s 清单全面支持 <b>Kubernetes 部署</b>，可实现轻松扩缩容、自动恢复和滚动更新。可通过 Helm values 直接配置节点角色、持久卷和监控集成，适用于云或混合环境。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何在 TBMQ 中设置集群？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 通过集群支持<b>横向扩展</b>。集群中各节点分担 MQTT 客户端和消息流量，保证可靠性和负载均衡。集群协调通过 <b>Kafka</b> 实现消息路由。</p>
                        <p>要启用集群，需部署多个连接到相同 Kafka、Redis 和 PostgreSQL 服务的 TBMQ 实例，并为每个节点在环境变量中配置唯一的 broker ID（<code>TB_SERVICE_ID</code>）。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 使用哪些端口？</div>
                    <div class="tbmq-faq-answer">
                        <p>默认情况下，TBMQ 监听以下端口：</p>
                        <ul>
                            <li><b>1883</b> – MQTT（明文 TCP）</li>
                            <li><b>8883</b> – MQTT over SSL/TLS</li>
                            <li><b>8084</b> – MQTT over WebSocket</li>
                            <li><b>8085</b> – MQTT over 安全 WebSocket (WSS)</li>
                            <li><b>8083</b> - HTTP Web UI 访问</li>
                        </ul>
                        <p>这些端口可在 TBMQ 配置文件中或通过环境变量修改，需在启动前完成。请确保防火墙或 Kubernetes Ingress 规则允许访问所选端口。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何启用 TLS/SSL 安全连接？</div>
                    <div class="tbmq-faq-answer">
                        <p>在 TBMQ 配置中提供有效的 <b>服务器证书</b>和<b>私钥</b>即可启用 SSL/TLS。TBMQ 支持仅服务端加密，以及更安全的 <b>客户端证书认证 (X.509)</b>。证书可由受信任 CA 签发或内部生成用于测试。配置完成后重启 broker 以生效。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何在 TBMQ 中配置认证提供方？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 采用<b>可插拔认证模型</b>，可自定义客户端认证方式。可选：</p>
                        <ul>
                            <li><b>基本认证</b>（client ID、用户名和密码）</li>
                            <li><b>基于 SSL 的认证</b>（X.509 证书链）</li>
                            <li><b>JWT 认证</b>（JSON Web Token）</li>
                            <li><b>增强认证</b>（MQTT 5.0）</li>
                        </ul>
                        <p>认证规则在数据库中定义，在每次连接尝试时评估。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 数据存储在哪里？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 与 <a href="https://kafka.apache.org/" target="_blank">Kafka</a>、<a href="https://redis.io/" target="_blank">Redis</a> 和 <a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a> 集成，实现可靠、高性能的数据存储：</p>
                        <ul>
                            <li><b>Kafka</b> – 处理未处理的 PUBLISH 消息、Application 客户端的持久消息，并存储客户端会话和订阅。</li>
                            <li><b>Redis</b> – 存储 Device 持久消息，用于快速访问和恢复。</li>
                            <li><b>PostgreSQL</b> – 存储用户凭据、MQTT 客户端凭据、系统统计等元数据。</li>
                        </ul>
                        <p>该混合架构确保数据持久性、高可用性和分布式系统内的高效投递。</p>
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-connectivity" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">支持哪些 MQTT 协议版本？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 完整支持 <b>MQTT 3.1.1</b> 和 <b>MQTT 5.0</b>，兼容主流 MQTT 客户端和库。MQTT 5.0 支持包括 <b>共享订阅</b>、<b>用户属性</b>、<b>主题别名</b>、<b>增强认证</b>和<b>原因码</b>等高级特性，为开发者提供更大的灵活性和控制。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 支持 MQTT over WebSocket 吗？</div>
                    <div class="tbmq-faq-answer">
                        <p>支持。TBMQ 支持 <b>MQTT over WebSocket</b> 和 <b>Secure WebSocket (WSS)</b>，使基于浏览器的应用和 Web 仪表盘能实时发布和订阅主题。默认 WebSocket 端点为：</p>
                        <ul>
                            <li><b>8084</b> – MQTT over WebSocket</li>
                            <li><b>8085</b> – MQTT over Secure WebSocket (WSS)</li>
                        </ul>
                        <p>WebSocket 支持便于将 MQTT 通信集成到现代 Web 应用和 IoT 门户中。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何配置 Keep Alive 和 Clean Start 选项？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 按 MQTT 规范支持 <b>Keep Alive</b> 和 <b>Clean Start</b>。</p>
                        <ul>
                            <li><b>Keep Alive</b> 定义客户端消息之间的最大空闲时间。 若在此间隔内无数据包发送，broker 将视为连接已断开。</li>
                            <li><b>Clean Start</b>（MQTT 5.0）或 <b>Clean Session</b>（MQTT 3.1.1）决定 broker 是否在断开后保留客户端会话状态。</li>
                        </ul>
                        <p>这些选项可在客户端配置。TBMQ 会根据所选设置自动处理会话持久化和消息队列，保证可靠的重连行为。</p>
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-usage" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 能做什么？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 支持 MQTT 客户端之间的无缝通信, ensuring secure and efficient message exchange. It supports advanced MQTT 5.0 features such as <b>shared subscriptions</b>, <b>enhanced authentication</b>, <b>topic aliasing</b>, and <b>flow control</b>, providing flexibility for IoT applications of any scale. TBMQ is built for performance and scalability — whether you’re running a single instance for testing or a clustered setup serving thousands of clients.</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">可以在哪里托管 TBMQ？</div>
                    <div class="tbmq-faq-answer">
                        <p>可在<b>云环境</b>、<b>本地部署</b>或<b>本地</b> PC 上托管 TBMQ。为快速搭建，推荐使用 <a href="/docs/{{docsPrefix}}mqtt-broker/install/docker/" target="_blank">Docker 安装指南</a>。若计划在生产或集群环境中部署 TBMQ，请参考 <a href="/docs/{{docsPrefix}}mqtt-broker/install/cluster/docker-compose-setup/" target="_blank">集群部署指南</a> 获取基于 Docker Compose 的多节点部署步骤。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">能否替换菜单中的默认 TBMQ logo？</div>
                    <div class="tbmq-faq-answer">
                        {% if docsPrefix == null %}
                        <p>TBMQ <b>社区版</b>不包含内置白标功能。但通过修改源码并重新构建平台，理论上可以替换默认 logo。此方式需要<b>开发经验</b>并<b>熟悉 TBMQ 前端代码库</b>。</p>
                        <p>若需要更简便且完全支持的界面定制方式，可考虑升级到 <b>专业版</b>。专业版支持上传自有 <b>logo</b> 和 <b>favicon</b>、定制 <b>登录</b>和<b>系统页面</b>、调整<b>颜色和品牌配色</b>——均可通过 Web 界面完成，无需改代码。</p>
                        {% endif %}
                        {% if docsPrefix == "pe/" %}
                        <p>Yes. In the <b>Professional Edition</b>, all branding and visual identity settings can be configured directly from the <b>White Label</b> page in the user interface — no code changes required. You can fully adapt the platform to your company’s look and feel with just a few clicks:</p>
                        <ul>
                            <li><b>替换</b>默认 TBMQ logo 和 favicon 为您自己的企业视觉元素。</li>
                            <li><b>定制</b>登录页、仪表板和系统页，从首次交互起即展示您的品牌。</li>
                            <li><b>调整</b>配色、强调色、logo 尺寸及样式（包括 CSS 微调）以匹配企业形象。</li>
                            <li><b>预览</b>所有更改后再发布。</li>
                            <li><b>配置自定义域名</b>——映射您自己的 URL（例如 <code>portal.company.com</code>），使用户通过您的品牌域名访问 TBMQ。</li>
                        </ul>
                        <p>These tools make it easy to deliver a fully branded experience that aligns with your organization’s visual standards.</p>
                        {% endif %}
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-security" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">安全性如何？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 通过 <b>MQTT over SSL/TLS 加密</b>保障消息交换安全，防止未授权访问和数据篡改。支持创建自定义 <b>认证提供方</b>验证客户端凭据，并支持 <b>增强认证（MQTT 5.0）</b>以实现更灵活的安全模型。可与现有证书机构集成或使用用户名/密码认证。这些特性为建设安全可靠的 IoT 通信网络提供坚实基础。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 支持哪些认证方式？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 支持多种认证机制，以保障安全、灵活的客户端验证。可用方式包括：</p>
                        <ul>
                            <li><b>基本认证</b>——验证数据库中存储的 client ID、用户名和密码。</li>
                            <li><b>X.509 证书链认证</b>——使用 SSL/TLS 证书验证客户端。</li>
                            <li><b>增强认证（MQTT 5.0）</b>——支持 MQTT 5.0 规范的 SCRAM 认证流程。</li>
                            <li><b>JWT 认证</b>——通过 TBMQ 认证 API 实现基于令牌的认证及与外部身份系统集成。</li>
                        </ul>
                        <p>可根据部署和安全需求选择最适合的方式。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何启用客户端证书认证 (SSL)？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 支持 <b>SSL/TLS 加密</b>和<b>客户端证书认证</b>（X.509 证书链）。启用该功能需：</p>
                        <ol>
                            <li>在配置文件中提供有效的<b>服务器证书</b>和<b>私钥</b>。</li>
                            <li>启用<b>安全 MQTT 端口</b>（默认 <code>8883</code>）。</li>
                            <li>配置 TBMQ 使用 X.509 证书链凭据验证客户端证书，实现双向认证。</li>
                        </ol>
                        <p>This ensures that both the client and server validate each other’s identity before establishing a connection, adding a strong layer of security for IoT and enterprise deployments.</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 支持 JWT 认证吗？</div>
                    <div class="tbmq-faq-answer">
                        <p>支持。TBMQ 通过认证提供方支持基于 <b>JWT（JSON Web Token）</b> 的认证，客户端可使用签名令牌而非静态凭据安全连接。JWT 适合由外部身份服务签发凭据的动态或短期会话。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何处理未授权的客户端连接？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 自动检测并记录未授权连接尝试。客户端认证失败时，broker 会记录 <b>client ID</b>、<b>IP 地址</b>、<b>用户名</b>和<b>TLS 状态</b>等详情。可在 <b>未授权客户端</b> 仪表盘中查看，或通过 API 查询做进一步分析。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何监控并阻止未授权客户端？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 提供通过 Web 界面或 REST API 直接监控未授权客户端的工具。管理员可筛选、查看和删除记录。还可配置阻止规则，拒绝来自已知恶意 IP 或多次违规者的后续连接尝试。该功能有助于保持系统完整性并监控潜在安全风险。</p>
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-subscriptions" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 如何管理订阅？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 使用<b>基于 Trie 的数据结构</b>管理客户端订阅，实现快速且内存高效的 topic 查找。所有客户端订阅从 Kafka 主题消费并存入内存中的 Trie，每个节点代表 topic 过滤器层级的一级。</p>
                        <p>Trie 结构支持<b>基于前缀的匹配</b>，使 TBMQ 能快速识别与已发布消息匹配的 topic 的订阅客户端。从 Kafka 读取 <b>PUBLISH</b> 消息时，TBMQ 使用 Trie 确定有相关订阅的客户端集，并将消息转发给每个客户端。</p>
                        <p>该方式确保<b>高性能消息路由</b>，查找时间取决于 topic 长度而非订阅总数，即便在有<b>数百万活跃订阅</b>的大规模环境中仍能高效扩展。虽然 Trie 的内存存储会略微增加内存占用，但能提供可预测且低延迟的消息投递。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 支持共享订阅吗？</div>
                    <div class="tbmq-faq-answer">
                        <p>支持。TBMQ 支持 MQTT 5.0 规范定义的<b>共享订阅</b>。共享订阅允许多个客户端以<b>负载均衡</b>方式从同一 topic 组消费消息。该特性特别有利于消息处理的水平扩展，例如在多个后端服务间分发遥测数据处理。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 如何处理保留消息？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 支持<b>保留消息</b>，确保新连接的订阅者立即收到该 topic 上最新发布的消息。客户端发布保留消息时，TBMQ 存储该消息并在新订阅者订阅时自动投递。若收到空 payload 的保留消息，TBMQ 按 MQTT 规范清除该 topic 的保留消息。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">持久会话与非持久会话有何区别？</div>
                    <div class="tbmq-faq-answer">
                        <p>A <b>persistent session</b> stores the client’s subscriptions and undelivered QoS 1/2 messages, allowing message delivery to resume after reconnecting. A <b>non-persistent session</b> (Clean Start = true) is temporary — all subscriptions and queued messages are discarded when the client disconnects. TBMQ fully supports both modes and automatically handles session recovery for persistent clients after reconnecting.</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 如何处置 Last Will and Testament (LWT)？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 遵循 MQTT 标准处理<b>遗嘱消息（LWT）</b>。客户端连接时可指定 LWT 消息，若客户端意外断开，broker 将自动发布该消息。该特性有助于通知其他客户端或监控系统异常断开情况，提升 IoT 系统的可见性与可靠性。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何监控发布和接收的消息数量？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ 提供消息吞吐量的详细指标，包括<b>已发布</b>、<b>已接收</b>和<b>已丢弃</b>消息数量。这些统计数据可通过内置<b>监控仪表板</b>查看。管理员可利用这些洞察追踪 broker 性能并优化系统配置。</p>
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-performance" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 可支持多少客户端和每秒消息数？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ offers <b>horizontal scalability</b>, meaning it can grow seamlessly with your workload. Each broker node in a cluster handles a portion of the load, ensuring balanced message processing and uninterrupted performance. Actual throughput depends on hardware, configuration, and message characteristics (size, QoS level, persistence). Optimized setups can handle <b>millions of simultaneous client connections</b> and <b>millions of messages per second</b>. For detailed metrics and benchmarks, visit the <a href="/docs/{{docsPrefix}}mqtt-broker/reference/100m-connections-performance-test/" target="_blank">Performance Test Page</a>.</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何监控 TBMQ 性能？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ exposes detailed performance metrics through its <b>monitoring dashboard</b> and <b>Prometheus endpoint</b>. You can track key indicators such as:</p>
                        <ul>
                            <li>已连接客户端数量</li>
                            <li>消息发布与接收速率</li>
                            <li>队列大小与处理延迟</li>
                            <li>Redis 与 Kafka 性能</li>
                        </ul>
                        <p>这些指标可在 <b>Grafana</b> 或其他可观测性平台中可视化，以实时洞察系统健康与吞吐趋势。</p>
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">客户端处理慢时 TBMQ 如何处理背压？</div>
                    <div class="tbmq-faq-answer">
                        <p>TBMQ implements an internal <b>backpressure management mechanism</b> to maintain stable performance when clients are unable to consume messages quickly. When a client’s network channel becomes non-writable, TBMQ temporarily pauses message delivery for that client. Once the channel becomes writable again, queued messages are delivered in the correct order. This design prevents slow consumers from impacting other clients, ensuring consistent throughput across the cluster.</p>
                    </div>
                </div>
            </div>
            <div id="tbmq-faq-cat-licensing" class="tbmq-faq-category">
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">TBMQ 使用何种许可类型？</div>
                    <div class="tbmq-faq-answer">
                        {% if docsPrefix == null %}
                        <p>TBMQ CE 基于 <b>Apache 2.0 License</b> 分发，支持个人和商业使用。可在任意环境中自由部署、修改和分发，无额外许可费用。</p>
                        {% endif %}
                        {% if docsPrefix == "pe/" %}
                        <p>TBMQ PE 为商业许可版本，采用订阅制许可。包含额外企业级功能、支持服务与维护。使用 PE 版本需与 ThingsBoard, Inc. 签订有效许可协议。</p>
                        {% endif %}
                    </div>
                </div>
                <div class="tbmq-faq-question">
                    <div class="tbmq-faq-question-title" onclick="toggleTbmqFaq(this)">如何获取支持？</div>
                    <div class="tbmq-faq-answer">
                        <p>可查阅社区故障排除指南和文档，或<a href="/docs/{{docsPrefix}}mqtt-broker/help" target="_blank">联系我们</a>获取技术帮助。了解更多<a href="/services/" target="_blank">我们提供的服务</a>。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>