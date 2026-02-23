---
layout: case-studies
title: 智慧城市停车 - X-TELIA 借助 ThingsBoard 快速扩展
notitle: "true"
customTitle: "true"
description: 了解 X-TELIA 如何与 ThingsBoard 合作，基于太阳能 LoRaWAN™「禁止停车」标牌与实时仪表盘交付智慧标牌系统。
---

<div class="case-study-page-wrapper">
    <section class="case-study-hero">
        <div class="card">
            <div class="text">
                <p class="category">智慧城市</p>
                <h1>规模化智慧标牌：X-TELIA 基于 ThingsBoard 部署 LoRaWAN™ 停车管理</h1>
                <div class="image inner" style="background-image: url('/images/case-studies/x-telia.webp')">
                    <img src="/images/case-studies/x-telia.svg" title="X-TELIA" alt="X-TELIA logo" width="126" height="56">
                </div>
                <p>X-TELIA 是 LoRaWAN® IoT 方案设计与制造的全球领先者。以简化IoT部署为使命，X-TELIA 提供包含高性能网关、传感器与网络基础设施的端到端无线方案。其产品以运营商级可靠性、可扩展性与效率著称，支持从智慧城市到工业IoT的多种应用。</p>
                <p>产品组合涵盖智慧停车、路灯、空气质量监测、资产追踪及其他关键应用。凭借基础设施自有、集成能力与垂直领域专长的独特结合，X-TELIA 在推动加拿大IoT普及方面扮演关键角色。</p>
            </div>
            <div class="image large" style="background-image: url('/images/case-studies/x-telia.webp')">
                <img src="/images/case-studies/x-telia.svg" title="X-TELIA" alt="X-TELIA logo" width="126" height="56">
            </div>
        </div>
    </section>
    <section class="statistics">
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 976 %}K+
            </p>
            <p>接入点</p>
        </div>
        <div class="block">
            <p>
                {% include number-animation.html startNum = 1 targetNum = 4 %}M+
            </p>
            <p>消息/天</p>
        </div>
        <div class="block">
            <p>
                {% include number-animation.html startNum = 0 targetNum = 800 %}+
            </p>
            <p>传感器类型</p>
        </div>
    </section>
    <section class="authored-quote">
        <img src="/images/case-studies/eric-bourbeau.webp" title="创始总裁兼CEO" alt="Eric Bourbeau" width="658" height="424">
        <div class="text">
            <h2>X-TELIA</h2>
            <p class="quote">“我们正在寻找一款稳健、可扩展的物联网平台，以部署基于 LoRaWAN™ 的前沿IoT项目。<br>我们拿下一份合同，部署全市范围的太阳能/无线可变「禁止停车」标牌，用于除雪期间的路侧停车管理。从开发、测试到部署整体方案的交期非常紧，且包含延迟交付的罚则……<a target="_blank" href="/industries/smart-buildings/?company=xtelia">阅读更多</a></p>
            <p class="author">Eric Bourbeau</p>
            <p class="title">创始总裁兼CEO</p>
        </div>
    </section>
    <section class="problem">
        <div class="title-block">
            <h2>他们面临哪些问题？</h2>
            <p>X-TELIA 拿下一份合同，部署全市范围的太阳能、无线「禁止停车」标牌系统，用于除雪期间的路侧停车管理。从网络通信到控制仪表盘，整套方案需在紧张时限内完成开发、测试与部署，延迟交付将面临经济罚则。</p>
        </div>
        <div class="cards-row">
            <div class="card">
                <h3>挑战</h3>
                <ul>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>交付窗口极短，延迟将承担合同罚则</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>X-TELIA 的 LoRaWAN™ 网络与稳健物联网平台之间需可靠集成</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>动态「禁止停车」标牌的实时控制与监控</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>用户友好的仪表盘界面快速开发</p>
                    </li>
                    <li>
                        <i class="far fa-question-circle"></i>
                        <p>生产就绪平台的顺利部署与测试</p>
                    </li>
                </ul>
            </div>
            <div class="card">
                <h3>主要成果</h3>
                <ul>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>在 X-TELIA 网络与 ThingsBoard 间建立了基于 MQTT 的稳健协议</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>设计并实现了用于控制标牌的定制仪表盘部件</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>成功部署针对该应用场景定制的 ThingsBoard PE 实例</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>按时交付完整方案，避免任何合同罚则</p>
                    </li>
                    <li>
                        <i class="far fa-check-circle"></i>
                        <p>对平台与团队建立信心，为后续项目铺平道路</p>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <section class="tb-power mb">
        <h2>ThingsBoard 如何赋能 X-TELIA？</h2>
        <div class="block">
            <div class="text">
                <h3>无缝 MQTT 集成</h3>
                <p>ThingsBoard 工程师与 X-TELIA 开发人员直接协作，构建了基于 MQTT 的 resilient 通信协议，实现 LoRaWAN™ 基础设施与物联网平台之间的快速、实时数据交换。</p>
            </div>
            <img src="/images/case-studies/x-telia-1.webp" title="无缝 MQTT 集成" alt="无缝 MQTT 集成" width="450" height="240">
        </div>
        <div class="block">
            <div class="text">
                <h3>定制部件开发</h3>
                <p>ThingsBoard 团队为直观的标牌控制开发了专用仪表盘部件。操作人员可一键在全市范围内启用或关闭「禁止停车」标牌，并拥有完整可见性。</p>
            </div>
            <img src="/images/case-studies/x-telia-2.webp" title="定制部件开发" alt="定制部件开发" width="450" height="240">
        </div>
        <div class="block">
            <div class="text">
                <h3>开箱即用的 PE 实例部署</h3>
                <p>ThingsBoard 专业版在紧张时限内以生产级可靠性完成部署。其可扩展架构在保证稳定与性能的前提下支持快速部署。</p>
            </div>
            <img src="/images/case-studies/x-telia-3.webp" title="开箱即用的 PE 实例部署" alt="开箱即用的 PE 实例部署" width="450" height="240">
        </div>
        <div class="block">
            <div class="text">
                <h3>专家级技术支持</h3>
                <p>项目全程，ThingsBoard 团队提供高触达的技术支持。其专注与紧密协作是方案成功、按时上线的重要保障。</p>
            </div>
            <img src="/images/case-studies/x-telia-4.webp" title="专家级技术支持" alt="专家级技术支持" width="450" height="240">
        </div>
    </section>
    {% include contact-us-banner.liquid linkLabel='应用场景' link='/iot-use-cases/' %}
    <section class="tb-help">
        <h2>ThingsBoard 如何帮助智慧城市方案用IoT改善运营？</h2>
        <div class="block">
            <div class="text">
                <h3>智慧路灯</h3>
                <p>路灯是城市中能耗最高的服务之一。通过 ThingsBoard 连接的智慧照明系统可降低能耗、维护成本与碳排放，同时提升公共安全。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>支持IoT的路灯上报状态、亮度、能耗与故障。</p></li>
                    <li><p>根据环境光、计划或运动检测自动调节亮度。</p></li>
                    <li><p>故障单元自动向维护人员告警。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/maps-widgets.webp" title="ThingsBoard 地图部件" alt="ThingsBoard 地图部件" width="776" height="776">
                <img src="/images/case-studies/hp-scada-energy.webp" title="ThingsBoard HP SCADA 能源部件" alt="ThingsBoard HP SCADA 能源部件" width="388" height="388">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>智慧垃圾管理</h3>
                <p>高效的垃圾清运对卫生、节油和环境卫生至关重要。ThingsBoard 帮助城市部署智慧垃圾桶，在满溢时发出信号并优化清运路线。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>超声波或重量传感器检测桶内填充量。</p></li>
                    <li><p>达到阈值时 ThingsBoard 触发告警。</p></li>
                    <li><p>与路线优化软件集成，提升清运效率。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/time-series-chart.webp" title="ThingsBoard 时序图部件" alt="ThingsBoard 时序图部件" width="776" height="776">
                <img src="/images/case-studies/hp-scada-energy.webp" title="ThingsBoard HP SCADA 能源部件" alt="ThingsBoard HP SCADA 能源部件" width="388" height="388">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>交通与停车管理</h3>
                <p>城市出行依赖高效的交通与停车系统。ThingsBoard 支持对车辆移动、交通密度与停车位可用性的实时追踪。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>连接道路传感器、ANPR 摄像头与停车位检测器。</p></li>
                    <li><p>监控实时交通流、停车占用与违规。</p></li>
                    <li><p>用实时数据优化信号、引导驾驶员、缓解拥堵。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/entities-table-3.webp" title="ThingsBoard 实体表部件" alt="ThingsBoard 实体表部件" width="776" height="776">
                <img src="/images/case-studies/parking-status-widget.webp" title="ThingsBoard 停车状态部件" alt="ThingsBoard 停车状态部件" width="582" height="582">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>环境与空气质量监测</h3>
                <p>为营造更健康的城市空间，城市需监测空气质量、噪声与气象。ThingsBoard 为环境健康提供实时可见性与长期趋势分析。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>IoT 站点监测 CO₂、PM2.5、NO₂、温湿度与噪声。</p></li>
                    <li><p>仪表盘展示实时读数并对危险阈值告警。</p></li>
                    <li><p>城市规划者用历史数据满足合规与政策规划。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/digital_gauges.webp" title="ThingsBoard 数字表盘部件" alt="ThingsBoard 数字表盘部件" width="776" height="776">
                <img src="/images/case-studies/hp-curcuit-breaker.webp" title="ThingsBoard HP 断路器部件" alt="ThingsBoard HP 断路器部件" width="582" height="582">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>智慧水务与公用事业管理</h3>
                <p>水是关键资源。ThingsBoard 支持对水务基础设施的远程监控，帮助城市减少泄漏、提高计费准确性并节约资源。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>IoT 表计追踪流量、压力、用量与水质。</p></li>
                    <li><p>规则引擎检测管道爆裂、回流或篡改等异常。</p></li>
                    <li><p>SCADA 仪表盘支持运维人员远程控制泵与阀门。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/bar-chart.webp" title="ThingsBoard 柱状图部件" alt="ThingsBoard 柱状图部件" width="776" height="776">
                <img src="/images/case-studies/hp-centrifugal-pump.webp" title="ThingsBoard HP 离心泵部件" alt="ThingsBoard HP 离心泵部件" width="776" height="776">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>公共安全与应急响应</h3>
                <p>城市需要对紧急事件、灾害与安全威胁的实时态势感知。ThingsBoard 为公共安全运营提供集中告警与设备协同。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>连接火灾传感器、紧急按钮、CCTV、公共报警。</p></li>
                    <li><p>实时告警发送至应急队伍。</p></li>
                    <li><p>可视化仪表盘支持事件中更快决策。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/notification-widget.webp" title="ThingsBoard 通知部件" alt="ThingsBoard 通知部件" width="776" height="776">
                <img src="/images/case-studies/map-widget.webp" title="ThingsBoard 地图部件" alt="ThingsBoard 地图部件" width="582" height="582">
            </div>
        </div>
        <div class="block">
            <div class="text">
                <h3>市民与楼宇参与</h3>
                <p>城市可基于同一 ThingsBoard 后端，为居民、企业与楼宇运营方提供交互式仪表盘与服务。</p>
                <p>运作方式：</p>
                <ul>
                    <li><p>每栋楼或干系人可访问包含相关数据的定制仪表盘。</p></li>
                    <li><p>市民获取空气质量、能耗或交通延误的实时更新。</p></li>
                    <li><p>多租户支持保证数据隔离与安全。</p></li>
                </ul>
            </div>
            <div class="image-container">
                <img src="/images/case-studies/hierarchy-widget.webp" title="ThingsBoard 层级部件" alt="ThingsBoard 层级部件" width="776" height="776">
                <img src="/images/case-studies/roles-table.webp" title="ThingsBoard 角色表部件" alt="ThingsBoard 角色表部件" width="776" height="776">
            </div>
        </div>
        {% include services-banner.liquid %}
    </section>
    <section class="contact">
        <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url(/images/case-studies/handshake.webp)">
            <div class="outer-frame">
                <div class="inner-frame">
                    <img src="/images/case-studies/thingsboard.svg" title="ThingsBoard logo" alt="ThingsBoard logo" width="298" height="56">
                    <img src="/images/case-studies/x-telia.svg" title="X-TELIA" alt="X-TELIA logo" width="126" height="56">
                </div>
            </div>
        </div>
        <p>真实故事，真实影响——分享您与 ThingsBoard 的经验！</p>
        <a id="CaseStudy_Xtelia_ContactUs" target="_blank" href="/docs/contact-us/" class="button gtm_button">联系我们</a>
    </section>
</div>
