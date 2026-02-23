---
layout: thingsboard-edge
title: ThingsBoard Edge
description: 面向边缘计算的综合软件解决方案，在数据产生源头提供数据分析与管理。
---

<section id="intro">
        <div class="stats-container">
            <div class="stat-block">
                <div class="stat-number">5</div>
                <div class="stat-label">边缘领域经验年限</div>
            </div>
            <div class="stat-block">
                <div class="stat-number">150+</div>
                <div class="stat-label">客户数</div>
            </div>
            <div class="stat-block">
                <div class="stat-number">∞</div>
                <div class="stat-label">单边缘设备数</div>
            </div>
            <div class="stat-block">
                <div class="stat-number">100%</div>
                <div class="stat-label">现场处理数据占比</div>
            </div>
        </div>
</section>

<section id="product">
        <div class="background">
           <div class="small1"></div><div class="small3"></div>
        </div>
    <h2 class="product-title">物联网架构对比</h2>
    <div class="scenario-wrapper">
        <div class="scenario-tabs">
            <div class="scenario-tab" onclick="switchProductTab('gateway', event)">
                <div class="tab-header">
                    <h3 class="tab-name">IoT Gateway</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                      <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="tab-tags">
                  <span class="tag">设备连接</span>
                  <span class="tag">数据路由</span>
                  <span class="tag">多协议支持</span>
                  <span class="tag">传统设备集成</span>
                  <p>物联网网关将本地设备桥接至边缘或服务器，处理多协议转换和数据路由。它支持传统设备集成及跨多种通信协议的无云依赖实时数据流。</p>
                </div>
            </div>
            <div class="scenario-tab active" onclick="switchProductTab('edge', event)">
                <div class="tab-header">
                    <h3 class="tab-name">ThingsBoard Edge</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                      <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="tab-tags">
                  <span class="tag">本地处理</span>
                  <span class="tag">离线运行</span>
                  <span class="tag">低延迟</span>
                  <span class="tag">远程站点</span>
                  <span class="tag">现场分析</span>
                  <p>ThingsBoard Edge 在网络边缘本地处理和可视化数据，在连接中断期间实现自主运行。通过在云端传输前过滤数据降低带宽成本，同时为关键自动化保持亚秒级响应时间。</p>
                </div>
            </div>
            <div class="scenario-tab" onclick="switchProductTab('server', event)">
                <div class="tab-header">
                    <h3 class="tab-name">ThingsBoard Server</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                      <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="tab-tags">
                    <span class="tag">云基础设施</span>
                    <span class="tag">集中式平台</span>
                    <span class="tag">多租户</span>
                    <span class="tag">可扩展架构</span>
                    <p>ThingsBoard Server 提供集中式数据处理、存储和具有企业级可扩展性的高级分析。它支持多租户、从本地到云的灵活部署选项，以及面向大规模物联网基础设施的无限制设备连接。</p>
                </div>
            </div>
        </div>
        <div id="scenario-cat-gateway" class="scenario-category">
            <div>
                <div class="image-container">
                    <div class="image-background"></div>
                    <div class="image-background"></div>
                    <div class="image">
                        <img src="/images/edge/tb-edge-gw.webp" alt="ThingsBoard Gateway block" width="615" height="719" loading="lazy">
                    </div>
                </div>
                <a href="/docs/iot-gateway/getting-started/" target="_blank" class="cta-button gtm_button">连接您的设备</a>
            </div>
        </div>
        <div id="scenario-cat-edge" class="scenario-category active">
            <div>
                <div class="image-container">
                    <div class="image-background"></div>
                    <div class="image-background"></div>
                    <div class="image">
                        <img src="/images/edge/tb-edge.webp" alt="ThingsBoard Edge block" loading="lazy">
                    </div>
                </div>
                <a href="/docs/edge/getting-started/" target="_blank" class="cta-button gtm_button">立即试用 Edge</a>
            </div>
        </div>
        <div id="scenario-cat-server" class="scenario-category">
            <div>
                <div class="image-container">
                    <div class="image-background"></div>
                    <div class="image-background"></div>
                    <div class="image">
                        <img src="/images/edge/tb-cloud.webp" alt="ThingsBoard Cloud block" loading="lazy">
                    </div>
                </div>
                <a href="/docs/getting-started-guides/helloworld/" target="_blank" class="cta-button gtm_button">快速开始</a>
            </div>
        </div>
    </div>
</section>

<section id="matrix">
    <div class="main-content">
    <h2>哪款 ThingsBoard 产品适合您？</h2>
    <table>
            <colgroup>
                <col class="col-feature">
                <col class="col-gateway">
                <col class="col-edge">
                <col class="col-server">
            </colgroup>
            <thead>
                <tr>
                    <td></td>
                    <th class="gateway">IoT<br>Gateway</th>
                    <th class="edge">ThingsBoard<br>Edge</th>
                    <th class="server">ThingsBoard<br>Server</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>需要 ThingsBoard Server</th>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td>N/A</td>
                </tr>
                <tr>
                    <th><a href="/docs/reference/performance/" target="_blank">数据采集</a></th>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/api/" target="_blank">核心协议支持<br>(MQTT、HTTP、CoAP 等)</a></th>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/iot-gateway/what-is-iot-gateway/" target="_blank">外围基础设施协议支持<br>(Modbus、BACNet、BLE 等)</a></th>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/guides/#AnchorIDDataProcessing" target="_blank">数据处理与分析</a></th>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/user-guide/dashboards/" target="_blank">实时 HMI 仪表板</a><br>与 <a href="/docs/user-guide/scada/" target="_blank">类 SCADA HMI 仪表板</a></th>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/user-guide/alarms/" target="_blank">告警与通知</a></th>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/user-guide/ui/assets/" target="_blank">资产管理</a></th>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/edge/config/management/" target="_blank">离线数据计算与存储<br>(远程站点场景)</a></th>
                    <td>数据采集</td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                </tr>
                <tr>
                    <th><a href="/docs/user-guide/ui/tenants/" target="_blank">多租户支持</a></th>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/unchecked.svg" alt="unchecked"></td>
                    <td><img src="/images/pe/checked.svg" alt="checked"></td>
                </tr>
                <tr>
                    <th>硬件资源占用</th>
                    <td>低</td>
                    <td>中低</td>
                    <td>中高</td>
                </tr>
            </tbody>
    </table>
    </div>
</section>

<section id="authored-quote">
    <div class="background">
        <div class="main1"></div><div class="small3"></div><div class="small4"></div>
    </div>
    <div class="main-content">
        <img class="h-auto" src="/images/case-studies/Dominic_Winkler.webp" title="ÖBB-Infrastruktur AG IT Enterprise Architect Dominic Winkler" alt="Dominic Winkler" width="1316" height="848">
        <div class="text">
            <h2>ÖBB-Infrastruktur AG</h2>
            <p class="quote">「ThingsBoard Edge 让我们能够在无需桥接防火墙和公网的情况下，在 IT 网络内实现数据流动，这是一项宝贵能力。」</p>
            <p class="author">Dominic Winkler</p>
            <p class="title">IT Enterprise Architect</p>
        </div>
    </div>
</section>

<section id="get-in-touch">
    <div class="main-content">
        <div class="block">
            <h2 class="cta">需要支持离线的物联网解决方案？</h2>
            <a id="Lets-Talk-Edge" href="/docs/contact-us/?subject=ThingsBoard%20Products" target="_blank"
               class="button contact-us gtm_button">联系 Edge 团队</a>
        </div>
    </div>
</section>

<section id="local-deployment">
        <h2>Edge 核心功能</h2>
        <div class="block">
            <div class="feature-des"><h3 class="item-heading">本地部署与存储</h3>
                <p>独立于服务器处理并存储来自本地（边缘）设备的数据。连接恢复后与服务器同步更新。</p>
                <a class="read-more-button" href="/docs/edge/getting-started-guides/what-is-edge/">Edge CE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
                <a class="read-more-button" href="/docs/pe/edge/getting-started-guides/what-is-edge/">Edge PE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
            </div>
            <div class="block-img">
                <img src="/images/edge/local-deployment.svg" alt="local deployment">
            </div>
        </div>
</section>

<section id="data-filtering">
        <div class="background">
            <div class="main1"></div><div class="small1"></div><div class="small2"></div><div class="small3"></div>
        </div>
        <div class="block">
            <div class="block-img">
                <img src="/images/edge/data-filtering.svg" alt="data filtering">
            </div>
            <div class="feature-des"><h3 class="item-heading">数据过滤</h3>
                <p>使用 ThingsBoard Edge 服务过滤来自本地（边缘）设备的数据，仅将数据子集转发至服务器进行进一步处理或存储。</p>
                <a class="read-more-button" href="/docs/edge/getting-started-guides/what-is-edge/">Edge CE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
                <a class="read-more-button" href="/docs/pe/edge/getting-started-guides/what-is-edge/">Edge PE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
            </div>
        </div>
</section>

<section id="local-alarms">
        <div class="background">
            <div class="main2"></div><div class="small5"></div><div class="small6"></div><div class="small7"></div>
        </div>
        <div class="block">
            <div class="feature-des"><h3 class="item-heading">本地告警</h3>
                <p>即使无服务器连接，也能在现场即时响应关键情况。</p>
                <a class="read-more-button" href="/docs/edge/getting-started-guides/what-is-edge/">Edge CE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
                <a class="read-more-button" href="/docs/pe/edge/getting-started-guides/what-is-edge/">Edge PE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
            </div>
            <div class="block-img">
                <img src="/images/edge/local-alarms.svg" alt="local alarms">
            </div>
        </div>
</section>

<section id="batch-update">
        <div class="block">
            <div class="block-img">
                <img src="/images/edge/batch-update.svg" alt="batch update">
            </div>
            <div class="feature-des"><h3 class="item-heading">批量更新与可视化</h3>
                <p>一键更新数千个边缘配置。使用实时仪表板监控本地事件和时序数据。</p>
                <a class="read-more-button" href="/docs/edge/getting-started-guides/what-is-edge/">Edge CE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
                <a class="read-more-button" href="/docs/pe/edge/getting-started-guides/what-is-edge/">Edge PE<img class="arrow first" src="/images/pe/read-more-arrow.svg" alt="arrow first"><img class="arrow second" src="/images/pe/read-more-arrow.svg" alt="arrow second"><img class="arrow third" src="/images/pe/read-more-arrow.svg" alt="arrow third"></a>
            </div>
        </div>
</section>

<section id="bottom-features">
    <div class="main-content">
        <div class="background">
            <div class="main3"></div><div class="small8"></div>
        </div>
        <h2>Edge 为何有效</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/opensource-icon.svg" alt="100% Open-source">
                    </div>
                    <h3 class="feature-title">100% 开源</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>采用 Apache 2.0 许可。可自由用于商业产品、作为 SaaS/PaaS 托管或修改以满足您的需求。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/customizable-icon.svg" alt="Customizable">
                    </div>
                    <h3 class="feature-title">可定制</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>灵活的规则引擎和可定制的仪表板让您可根据具体工作流和业务需求定制 Edge。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/robust-icon.svg" alt="Robust and Efficient">
                    </div>
                    <h3 class="feature-title">稳健可靠</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>每个 Edge 实例可处理最多 1,000 台设备，通过持久化本地存储和自动同步确保零数据丢失。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/scalable-icon.svg" alt="Scalable">
                    </div>
                    <h3 class="feature-title">可扩展</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>在分布式站点部署数千个 Edge 实例，实现水平扩展和分布式数据处理。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/visualization-icon.svg" alt="Real-Time">
                    </div>
                    <h3 class="feature-title">实时</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>即时访问关键数据支持快速决策。本地告警无需服务器连接即可在现场触发。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/offline-edge.svg" alt="Offline Capable">
                    </div>
                    <h3 class="feature-title">支持离线</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>断开连接时可独立运行。本地存储数据，连接恢复时自动同步——零数据丢失。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/low-latency.svg" alt="Responsive">
                    </div>
                    <h3 class="feature-title">响应迅速</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>本地处理实现亚秒级响应时间，对工业自动化和实时控制系统至关重要。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/engine-icon.svg" alt="Logic-Driven">
                    </div>
                    <h3 class="feature-title">逻辑驱动</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>拖拽式规则链设计器让您定义数据处理、外部集成和告警通知的自定义逻辑。</p>
                </div>
            </div>
            <div class="feature-card">
                <div class="feature-header" onclick="toggleFeature(this)">
                    <div class="feature-icon">
                        <img src="/images/edge/friendly-icon.svg" alt="User-Friendly">
                    </div>
                    <h3 class="feature-title">用户友好</h3>
                    <svg class="chevron" width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="feature-content">
                    <p>直观界面及多协议支持（MQTT、CoAP、HTTP）可在多样化设备生态中快速部署。</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="bottom">
    <div class="contact-us-banner">
        <div class="contact-us-banner-content">
            <h2>准备将智能带到网络边缘？</h2>
            <div class="contact-us-banner-buttons">
                <a id="Products_Edge_TryEdgeNow" href="/docs/edge/getting-started/" target="_blank" class="bottom-button gtm_button">立即开始</a>
            </div>
        </div>
        <img src="/images/edge/offline-edge.svg" alt="Edge icon">
    </div>
</section>


<script>
function switchProductTab(tabId, event) {
  var tabs = document.querySelectorAll('.scenario-tab');
  tabs.forEach(function(tab) {
    tab.classList.remove('active');
  });
  var categories = document.querySelectorAll('.scenario-category');
  categories.forEach(function(cat) {
    cat.classList.remove('active');
  });
  event.target.closest('.scenario-tab').classList.add('active');
  var category = document.getElementById('scenario-cat-' + tabId);
  if (category) category.classList.add('active');
}

function toggleFeature(headerElement) {
  var card = headerElement.closest('.feature-card');
  var allCards = document.querySelectorAll('.feature-card');
  var cardsArray = Array.from(allCards);

  if (window.innerWidth <= 1000) {
    allCards.forEach(function(c) {
      if (c !== card) {
        c.classList.remove('open');
        c.classList.remove('active');
      }
    });
    card.classList.toggle('open');
    card.classList.toggle('active');
  } else {
    var cardIndex = cardsArray.indexOf(card);
    var rowIndex = Math.floor(cardIndex / 3);

    var rowStart = rowIndex * 3;
    var rowEnd = Math.min(rowStart + 3, cardsArray.length);
    var rowCards = cardsArray.slice(rowStart, rowEnd);

    var isRowOpen = rowCards.some(function(c) { return c.classList.contains('open'); });

    rowCards.forEach(function(c) {
      if (isRowOpen) {
        c.classList.remove('open');
      } else {
        c.classList.add('open');
      }
    });

    allCards.forEach(function(c) { c.classList.remove('active'); });
    if (!isRowOpen) {
      card.classList.add('active');
    }
  }
}
</script>