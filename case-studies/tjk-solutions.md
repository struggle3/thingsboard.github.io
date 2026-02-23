---
layout: case-studies
title: 借助 ThingsBoard 保障关键通信 | TJK-Solutions
notitle: "true"
customTitle: "true"
description: 了解 TJK-Solutions 如何借助 ThingsBoard 监控其基于 Meshtastic 的应急通信网络——在离网情况下仍确保可见性与可靠性。
---

<div class="case-study-page-wrapper">
    <section class="case-study-hero">
        <div class="card">
            <div class="text">
                <p class="category">灾害与民防</p>
                <h1>保障关键通信：TJK-Solutions 如何用 ThingsBoard 监控灾害响应中的 Meshtastic 基础设施</h1>
                <div class="image inner" style="background-image: url('/images/case-studies/tjk-solutions.webp')">
                    <img src="/images/case-studies/tjk-solutions.svg" title="TJK-solutions" alt="TJK-solutions logo" width="126" height="56">
                </div>
                <p>TJK-Solutions 是一家德国IoT与环境技术公司，专注于水务管理、气象观测与关键基础设施的智慧监控方案。除上述领域外，公司还深度参与IoT、LoRaWAN 及智慧乡村/智慧城市相关项目，帮助市政与组织部署可扩展、互联的系统以推动数字化转型。</p>
                <p>出于对弹性、自给通信系统的需求，TJK-Solutions 开发并运营自管IoT平台，在公共基础设施失效时仍保持完全可用。</p>
                <p>在德国勃兰登堡 Am Mellensee 市镇开展的大规模灾害管理演练中，TJK-Solutions 部署了基于 Meshtastic 的应急通信网络，以验证去中心化系统如何在危机条件下保障可靠信息流。为保持对该关键基础设施的完整可见性，公司在本地服务器上部署了 ThingsBoard 专业版（PE）——实现对应急协调与灾害响应至关重要的节点、路由与连接的持续实时监控。</p>
            </div>
            <div class="image large" style="background-image: url('/images/case-studies/tjk-solutions.webp')">
                <img src="/images/case-studies/tjk-solutions.svg" title="TJK-solutions" alt="TJK-solutions logo" width="126" height="56">
            </div>
        </div>
    </section>
    <section class="statistics">
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 33 %}
            </p>
            <p>已部署 Meshtastic 设备</p>
        </div>
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 10 %}
            </p>
            <p>Am Mellensee 范围内自治子网</p>
        </div>
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 104 %}.{% include number-animation.html startNum = 1 targetNum = 4 %}
            </p>
            <p>km² 覆盖面积</p>
        </div>
    </section>
    <section class="authored-quote">
        <img src="/images/case-studies/tom-jonas-krüger.webp" title="TJK-Solutions 创始人兼CEO" alt="Tom Jonas Krüger" width="658" height="424">
        <div class="text">
            <h2>TJK-Solutions</h2>
            <p class="quote">“借助 ThingsBoard，我们可以持续监控整个 Meshtastic 应急网络——即便在公共互联网或电网失效时。它在危机情境下为我们提供了所需的透明与信心。”</p>
            <p class="author">Tom Jonas Krüger</p>
            <p class="title">TJK-Solutions 创始人兼CEO</p>
        </div>
    </section>
    <section class="problem">
        <div class="title-block">
            <h2>他们面临哪些问题？</h2>
            <p>TJK-Solutions 需要可靠、自托管的平台以监控其基于 Meshtastic 的应急通信网络状态。当时没有现成工具能提供实时总览、设备健康检查与告警——尤其能在完全离网运行、独立于公共基础设施的平台。</p>
        </div>
        <div class="cards-row">
            <div class="card">
                <h3>挑战</h3>
                <ul>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>对所有 Meshtastic 设备进行集中、始终可用的总览。</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>对 SenseCAP P1 太阳能路由器的电池电压与连接状态进行持续监控。</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>历史数据趋势与可视化分析以发现薄弱节点。</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>故障或异常时的推送通知。</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>33 台 Meshtastic 设备覆盖 104.4 km²、服务 7,224 名居民，人工监控已不可行。</p>
                    </li>
                </ul>
            </div>
            <div class="card">
                <h3>主要成果</h3>
                <ul>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>ThingsBoard PE 在 10 个片区、104.4 km² 范围内提供 33 台 Meshtastic 设备的统一实时视图，以自动化管控替代人工监督。</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>对电池电压、连接与信号强度的持续监控确保即便在断电时通信仍可靠。</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>ThingsBoard 中的历史遥测有助于及早发现薄弱节点，实现主动维护与更高网络可靠性。</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>规则引擎在设备故障或电压下降时发送即时通知，确保对关键问题快速响应。</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>ThingsBoard PE 本地部署使停电期间所有监控仍可运行，在危机条件下保障数据可用性。</p>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <section class="tb-power mb">
        <h2>ThingsBoard 如何赋能 TJK-Solutions？</h2>
        <p>TJK-Solutions 在安全本地网络中部署了自托管的 ThingsBoard PE 实例，以确保在完全断网时仍能运行。</p>
        <div class="block">
            <div class="text">
                <h3>MQTT 集成</h3>
                <p>Meshtastic 遥测数据（电压、信号强度、跳数、运行时间等）通过专用 MQTT 代理传输至 ThingsBoard。</p>
            </div>
            <img src="/images/case-studies/tjk-solutions-1.webp" title="与工业设备无缝集成" alt="与工业设备无缝集成" width="450" height="240">
        </div>
        <div class="block">
            <div class="text">
                <h3>数据转换器与上行自动化</h3>
                <p>ThingsBoard 的集成引擎在设备一旦上报数据时即自动创建并配置新设备，设备类型、标签、位置等属性动态分配。</p>
            </div>
            <img src="/images/case-studies/tjk-solutions-2.webp" title="ThingsBoard 与 LoRaWAN 实现的无线数据传输" alt="ThingsBoard 与 LoRaWAN 实现的无线数据传输" width="450" height="240">
        </div>
        <div class="block">
            <div class="text">
                <h3>仪表盘可视化</h3>
                <p>定制仪表盘提供实时总览，包括节点总数、在线与离线数量；展示实时状态的交互地图；以及电池电压、RSSI、跳距等遥测数据表。</p>
            </div>
            <img src="/images/case-studies/tjk-solutions-3.webp" title="高级数据汇聚与数字孪生可视化" alt="高级数据汇聚与数字孪生可视化" width="450" height="240">
        </div>
        <div class="block">
            <div class="text">
                <h3>离网弹性架构</h3>
                <p>在本地服务器上运行 ThingsBoard PE，TJK-Solutions 确保在停电期间仍能完整运行，保障关键基础设施的数据安全、自治与持续监控。</p>
            </div>
            <img src="/images/case-studies/tjk-solutions-4.webp" title="实时性能监控" alt="实时性能监控" width="450" height="240">
        </div>
    </section>
    {% include contact-us-banner.liquid linkLabel='应用场景' link='/iot-use-cases/' %}
    <section class="tb-help">
        <h2>ThingsBoard 如何帮助民防用IoT改善运营</h2>
        <div class="block">
            <div class="text">
                <h3>集成与数据转换器</h3>
                <p>实现 Meshtastic 数据无缝接入 ThingsBoard，无需外部脚本或人工配置。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>使用转换器解析 JSON、Base64、二进制或十六进制载荷。</p></li>
                    <li><p>通过集成连接外部系统。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/entities-table.webp" title="ThingsBoard 实体表部件" alt="ThingsBoard 实体表部件" width="776" height="776">
                <img src="/images/case-studies/maps-widgets.webp" title="ThingsBoard 地图部件" alt="ThingsBoard 地图部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>仪表盘与可视化</h3>
                <p>在分布式应急网络上清晰、直观地呈现实时与历史数据。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>用动态地图可视化 GPS 坐标、移动与部署区域。</p></li>
                    <li><p>用时序图对关键信号（电池电压、传感器触发）进行历史分析。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/battery-level.webp" title="ThingsBoard 电量部件" alt="ThingsBoard 电量部件" width="388" height="388">
                <img src="/images/case-studies/time-series-chart.webp" title="ThingsBoard 时序图部件" alt="ThingsBoard 时序图部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>规则引擎与通知</h3>
                <p>用于设备故障或电压下降时的自动告警与推送通知。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>监控低电压或传感器异常等遥测。</p></li>
                    <li><p>通过短信、邮件等触发通知。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/alarms-table.webp" title="ThingsBoard 告警表部件" alt="ThingsBoard 告警表部件" width="776" height="776">
                <img src="/images/case-studies/notification-widget.webp" title="ThingsBoard 通知部件" alt="ThingsBoard 通知部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>本地部署与安全</h3>
                <p>自管 PE 部署确保所有监控在市政保护环境中持续运行且保密。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>支持 TLS、RBAC 与 OAuth2，实现 SSO 与细粒度访问控制。</p></li>
                    <li><p>配置 HA 集群、定期备份与自定义防火墙规则以应对灾害。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/network-status.webp" title="ThingsBoard 网络状态部件" alt="ThingsBoard 网络状态部件" width="388" height="388">
                <img src="/images/case-studies/signal-strength-hop-count.webp" title="ThingsBoard 信号强度部件" alt="ThingsBoard 信号强度部件" width="388" height="388">
            </div>
        </div>
        {% include default-carousel.liquid collectionMap = 'case-studies' collectionKey = 'tjk-solutions' %}
        <br>
        <br>
        {% include services-banner.liquid %}
    </section>
    <section class="contact">
        <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url(/images/case-studies/handshake.webp)">
            <div class="outer-frame">
                <div class="inner-frame">
                    <img src="/images/case-studies/thingsboard.svg" title="ThingsBoard logo" alt="ThingsBoard logo" width="298" height="56">
                    <img src="/images/case-studies/tjk-solutions.svg" title="TJK-solutions" alt="TJK-solutions logo" width="126" height="56">
                </div>
            </div>
        </div>
        <p>真实故事，真实影响——分享您与 ThingsBoard 的经验！</p>
        <a id="CaseStudy_TJK_ContactUs" target="_blank" href="/docs/contact-us/" class="button gtm_button">联系我们</a>
    </section>
</div>
