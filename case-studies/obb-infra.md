---
layout: case-studies
title: 智慧铁路基础设施：ÖBB-Infrastruktur AG 的数字化转型
notitle: "true"
customTitle: "true"
description: 了解 ÖBB-Infrastruktur AG 如何借助 ThingsBoard IoT 平台提升铁路效率与安全——实现实时监控、预测性维护及不经过公网的安全数据流。
---

<div class="case-study-page-wrapper">
    <section class="case-study-hero">
        <div class="card">
            <div class="text">
                <p class="category">智慧基础设施</p>
                <h1>智慧铁路基础设施：ÖBB-Infrastruktur AG 的数字化转型</h1>
                <div class="image inner" style="background-image: url('/images/case-studies/obb.webp')">
                    <img src="/images/case-studies/obb.svg" title="ÖBB-Infrastruktur AG" alt="ÖBB-Infrastruktur AG logo" width="91" height="56">
                </div>
                <p>ÖBB-Infrastruktur AG 是奥地利铁路运输的先驱，负责奥地利铁路基础设施的规划、建设、维护与运营。公司致力于在准点、安全、清洁及铁路系统开放接入方面树立高标准。</p>
                <p>以创新与可持续为目标，ÖBB-Infrastruktur AG 保障数百万乘客舒适出行，并实现奥地利及周边的高效货运。目标简单：让每次出行都是良好体验，打造友好车站，并以每个项目为国家进步贡献力量。</p>
                <p>未来几年的主要挑战将是铁路交通需求上升、时刻表密度增加，导致需要封闭线路的维护作业时间窗口减少。唯有依托更优规划以及基于铁路数字孪生数据的跨业务单元协作，才能应对这些挑战。</p>
            </div>
            <div class="image large" style="background-image: url('/images/case-studies/obb.webp')">
                <img src="/images/case-studies/obb.svg" title="ÖBB-Infrastruktur AG" alt="ÖBB-Infrastruktur AG logo" width="91" height="56">
            </div>
        </div>
    </section>
    <section class="statistics">
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 25888 useMobileMode = true useGrouping = true %}
            </p>
            <p>信号管理<br>控制与安全</p>
        </div>
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 5 %}
            </p>
            <p>运营控制中心<br>监控与管理</p>
        </div>
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 6634 useGrouping = true %}
            </p>
            <p>桥梁维护与<br>降本</p>
        </div>
    </section>
    <section class="authored-quote">
        <img class="h-auto" src="/images/case-studies/Dominic_Winkler.webp" title="ÖBB-Infrastruktur AG IT 企业架构师 Dominic Winkler" alt="Dominic Winkler" width="1316" height="848">
        <div class="text">
            <h2>ÖBB-Infrastruktur AG</h2>
            <p class="quote">“ThingsBoard Edge 让我们能够在无需穿越防火墙与公网的情况下，在自有 IT 网络内实现数据流动，这一能力非常宝贵。”</p>
            <p class="author">Dominic Winkler</p>
            <p class="title">IT 企业架构师</p>
        </div>
    </section>
    <section class="problem">
        <div class="title-block">
            <h2>他们面临哪些问题？</h2>
            <p>ÖBB-Infrastruktur AG 旨在在保持安全、出行舒适与可持续的高水平前提下，提升线路通过能力。铁路资产全生命周期需被主动监控与管理，以确保铁路运营团队的高可用性。这需要集成能应对实时数据处理、安全通信与预测分析的IoT方案，目标是提升出行、减排并优化维护流程。</p>
        </div>
        <div class="cards-row">
            <div class="card">
                <h3>挑战</h3>
                <ul>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>管理全国铁路基础设施上大量IoT设备的实时数据，并在维持数据流动的同时避免将内部系统暴露于公网。</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>借助数据分析从“现状如何？”到“下一步如何？”再到“假设如何？”</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>为 ÖBB 内部用户提供统一、可访问的界面以可视化IoT数据。</p>
                    </li>
                </ul>
            </div>
            <div class="card">
                <h3>主要成果</h3>
                <ul>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>借助全国私有光纤网络与 ThingsBoard Edge，ÖBB-Infrastruktur AG 建立了安全的内网通信通道，数据留在 IT 网络内、降低安全风险，本地系统可在不穿越防火墙、不使用公网的情况下安全连接。</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>ThingsBoard 在奥地利铁路创建铁路资产数字孪生计划中发挥关键作用，提供实时资产状态数据并记录时序数据。借助 ThingsBoard 的数字孪生能力，ÖBB-Infrastruktur AG 可预测潜在问题、模拟场景并主动做出明智决策。</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>部署于 ÖBB Azure 云租户的 ThingsBoard PE 实例提供主界面，使所有内部利益相关方能够访问针对其应用场景定制的仪表盘与洞察。</p>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <section class="tb-power">
        <h2>ThingsBoard 与 ThingsBoard Edge 如何赋能 ÖBB-Infrastruktur AG？</h2>
        <div class="block">
            <div class="text">
                <h3>数字孪生计划</h3>
                <p>ÖBB-Infrastruktur AG 使用数字孪生评估当前状态、做出预测并模拟可能情景。数字孪生是物理系统的数字化表达，此处即铁路基础设施。该方式需要访问实时资产状态数据以及时序记录。ThingsBoard 作为该计划的主要使能技术之一，提供统一的IoT数据接入、处理、可视化与分析平台：</p>
                <ul>
                    <li><p>ThingsBoard 支持通过 MQTT、CoAP、HTTP 等通信协议在铁路基础设施上部署的多种IoT设备无缝集成，实现实时数据采集。</p></li>
                    <li><p>ThingsBoard Edge 支持本地数据处理，将关键数据保留在 ÖBB 私有网络内，并与内部系统安全集成而无需暴露于公网，同时在云与本地网络分离时避免数据丢失。</p></li>
                    <li><p>ThingsBoard Cloud 通过可定制仪表盘提供强大可视化工具，使内部利益相关方能监控资产、跟踪性能并分析趋势。</p></li>
                    <li><p>ThingsBoard 通过对传感器数据与环境参数的分析实现状态监控与预测性维护，基于预定义阈值与条件生成告警，减少非计划停机。</p></li>
                    <li><p>基于数字孪生中处理的数据，评估当前资产状态（“现状如何？”）并预测未来发展（“下一步如何？”）。</p></li>
                </ul>
            </div>
            <img src="/images/case-studies/digital-twin.webp" title="数字孪生计划" alt="笔记本" width="900" height="480">
        </div>
        <div class="block">
            <div class="text">
                <h3>ÖBB-Infrastruktur AG 的安全与弹性数据流</h3>
                <p>ThingsBoard Edge 实例战略部署于 ÖBB-Infrastruktur AG 基础设施内的本地，确保数据流完全在内部 IT 网络内，避免暴露于公网与防火墙穿越。通过在本地缓存IoT数据直至成功传输至 ÖBB Azure 云租户中的 ThingsBoard PE 实例，该架构实现：</p>
                <ul>
                    <li><p>网络解耦：有效分离本地与云环境，降低依赖与潜在中断。</p></li>
                    <li><p>网络问题弹性：在互联网变慢、VPN 问题或云连接故障时保持数据完整性与运营连续性。</p></li>
                    <li><p>优化数据流：在 Site2Site VPN 或 ExpressRoute 连接出现问题时仍可持续处理数据。</p></li>
                </ul>
                <p>该架构不仅提升数据安全与可用性，还支持作为 ÖBB 数字孪生计划一部分的实时监控与预测性维护。</p>
            </div>
            <img src="/images/case-studies/secure-resilient.webp" title="ÖBB-Infrastruktur AG 安全与弹性数据流" alt="服务器" width="900" height="480">
        </div>
    </section>
    <section class="full-width-img bannerMargin">
        <img src="/images/case-studies/railway.webp" title="Railways" alt="铁路" width="1920" height="946">
    </section>
    {% include contact-us-banner.liquid linkLabel='应用场景' link='/iot-use-cases/' %}
    <section class="tb-help">
        <h2>ThingsBoard Edge 如何帮助智慧铁路基础设施管理借助IoT改善运营？</h2>
        <div class="block">
            <div class="text">
                <h3>智慧铁路基础设施管理</h3>
                <p>ThingsBoard Edge 在智慧铁路基础设施管理中可发挥关键作用。凭借边缘计算特性，数据保留在网络内，无需将内部系统暴露于公网即可提升安全。通过在本地缓存IoT数据直至与 ThingsBoard PE 实例成功连接，ThingsBoard Edge 保障数据完整性与运营连续性。</p>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/status-widget.webp" title="ThingsBoard 状态部件" alt="ThingsBoard 状态部件" width="776" height="776">
                <img src="/images/case-studies/notification-widget.webp" title="ThingsBoard 通知部件" alt="ThingsBoard 通知部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>实时数据与主动场景测试</h3>
                <p>平台提供实时数据与时序记录，使组织能评估资产当前状态、预判未来问题并主动测试不同运营场景。该能力对明智决策及提升铁路运营的安全、效率与可持续性至关重要。</p>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/alarms-table-2.webp" title="ThingsBoard 告警表部件" alt="ThingsBoard 告警表部件" width="776" height="776">
                <img src="/images/case-studies/line-chart.webp" title="ThingsBoard 折线图部件" alt="ThingsBoard 折线图部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>支撑预测性维护与运营效率</h3>
                <p>此外，通过对铁路资产采集的传感器数据进行分析，ThingsBoard Edge 支持预测性维护策略，有助于减少非计划停机并提升整体运营效率。</p>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/value-card.webp" title="ThingsBoard 数值卡片部件" alt="ThingsBoard 数值卡片部件" width="776" height="776">
                <img src="/images/case-studies/entities-table-4.webp" title="ThingsBoard 实体表部件" alt="ThingsBoard 实体表部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>集中可视化与增强运营管理</h3>
                <p>ThingsBoard PE 实例在云中提供集中用户界面，提供可定制仪表盘，使利益相关方能可视化与其应用场景相关的IoT数据。该统一可视化能力有助于改善列车调度、容量管理与资产利用，直接助力铁路运营优化。</p>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/maps-widgets.webp" title="ThingsBoard 地图部件" alt="ThingsBoard 地图部件" width="776" height="776">
                <img src="/images/case-studies/bar-chart.webp" title="ThingsBoard 柱状图部件" alt="ThingsBoard 柱状图部件" width="776" height="776">
            </div>
        </div>
        {% include services-banner.liquid %}
    </section>
    <section class="contact">
        <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url(/images/case-studies/handshake.webp)">
            <div class="outer-frame">
                <div class="inner-frame">
                    <img src="/images/case-studies/thingsboard.svg" title="ThingsBoard logo" alt="ThingsBoard logo" width="298" height="56">
                    <img src="/images/case-studies/obb.svg" title="ÖBB-Infrastruktur AG" alt="ÖBB-Infrastruktur AG logo" width="91" height="56">
                </div>
            </div>
        </div>
        <p>真实故事，真实影响——分享您与 ThingsBoard 的经验！</p>
        <a id="CaseStudy_OBB_ContactUs" target="_blank" href="/docs/contact-us/" class="button gtm_button">联系我们</a>
    </section>
</div>
