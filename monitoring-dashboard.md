---
layout: iot-article
title: IoT 监控仪表盘
notitle: "true"
description: "IoT 监控仪表盘 ✔ IoT 控制面板 ⚫ ThingsBoard ➤ 支持创建与管理仪表盘 ✔ 提供丰富部件"
redirect_from: "/docs/services/monitoring-dashboard/"
---

<section class="hero light-text"></section>
<div id="header-block" class="block-wrapper wrapper-main-color">
    <div class="block-content">
        <div class="text-wrapper">
            <span class="read-info">阅读约 11 分钟</span>
            <h1>IoT 监控仪表盘</h1>
            <div class="text-content medium-margin">在数字化与物联网(IoT)的发展中，数据管理与监控的重要性不言而喻。IoT 监控仪表盘不仅能简化海量数据的可视化，还能让展示更高效、更有信息量。</div>
            <div class="text-content"><span class="bold">在 ThingsBoard 平台中，仪表盘</span>是IoT应用用户界面的核心组成部分，为IoT项目的快速开发、管理与扩展提供支撑。</div>
        </div>
        <img class="image" srcset="/images/iot-articles/monitoring_dashboard_1_1090x742.webp 1090w, /images/iot-articles/monitoring_dashboard_1_2180x1484.webp 2180w" sizes="(max-width: 1920px) 1090px, (min-width: 1921px) 2180px" src="/images/iot-articles/monitoring_dashboard_1_1090x742.webp" alt="IoT 能源管理办公监控"/>
        <div class="text-wrapper">
            <h2>IoT 监控系统如何工作？</h2>
            <div class="text-content small-margin">第一步是选择能采集并上报所需数据的设备，根据待监控的IoT监控系统或流程的特性进行选择。</div>
            <div class="text-content medium-margin">下一步是使用所支持的协议之一（如MQTT、HTTP、LoRaWAN、OPC-UA、CoAP、LwM2M 等）将IoT设备接入监控应用。完整协议列表见<a class="article-link" href="/docs/pe/api/">ThingsBoard API 参考</a>或<a class="article-link" href="/docs/pe/guides/#AnchorIDConnectYourDevice">连接指南</a>。</div>
            <div class="text-content medium-margin">设备接入并向平台上报数据后，遥测会写入数据库，即可根据<a class="article-link" href="/docs/pe/guides/#AnchorIDDataVisualization">IoT 仪表盘开发指南</a>构建实时与历史监控仪表盘。</div>
            <div class="text-content medium-margin">仪表盘应支持钻取导航：从系统总览逐级下钻，了解当前状态并分析历史数据。</div>
            <h2>什么是端到端 IoT 性能可见性？</h2>
            <div class="text-content small-margin">IoT 监控方案提供远程系统的端到端可见性，即系统行为的当前、历史与预测等各方面均可被运维人员远程实时掌握。借助这些数据，运维可更好理解与优化系统、做根因分析并预防潜在瓶颈。来自IoT传感器的数据用于实时监控系统；结合ML/AI模型的数据趋势分析可识别并突出可能故障或需维护的部件。在安全与合规要求高的场景下，实时IoT告警与数据记录可保障安全与合规。</div>
            <h2>IoT 监控工具</h2>
            <h3>数据采集常用设备类型</h3>
            <div class="text-content small-margin">按特性可将IoT设备分为几类：</div>
            <ul class="list">
                <li><span class="bold-text">供电方式：</span>可为内置电池设备，此时需考虑能效以降低换电池频率，可通过选用低功耗网络与通信协议、数据上报频率与载荷大小等实现。另一大类为外接电源（电网、可再生能源等）。还有较新的小类——无源IoT设备，无需电源即可将传感器数据传到IoT系统，常见技术包括RFID与NFC。</li>
                <li><span class="bold-text">连接类型：</span>远距离低功耗设备可长距离传输且耗能很少（LPWAN 如 LoRaWAN、NB-IoT 等）；无线还包括短距（BLE、Bluetooth、WiFi、ZigBee 等）与广域（4G/5G、卫星等）；有线则通过网线或工业总线（Ethernet、Modbus、OPC-UA 等）与IoT系统通信。</li>
            </ul>
            <div class="text-content small-margin">还可按设备功能（传感器、执行器、控制器）或行业（工业设备、智能家居、医疗、汽车、能源管理、物流等）分类。</div>
            <h3>IoT 设备通常采集哪些数据？</h3>
            <div class="text-content small-margin">一般而言，IoT设备与传感器采集并测量所监控环境或对象的物理量，也可上报其控制的系统、流程或硬件的状态。依业务领域不同：能源管理/BEMS 为能耗、电压等电气量；工业IoT监控可为PLC与现场设备上的传感器数据（振动、压力、状态码、故障、生产节奏等），以及温度、湿度、占用、照明、电池电量、RSSI 等。若涉及网关与边缘服务，还可监控其RAM、CPU、磁盘及网络参数。</div>
            <h3>遥测采集的三种方式</h3>
            <ul class="list">
                <li><span class="bold-text">方式一：</span>IoT设备内置多类传感器，按设定频率上报遥测（温度、湿度、压力等）。</li>
                <li><span class="bold-text">方式二：</span>数据采集器无内置传感器，但知道从何处、以何种方式获取待监控数据，例如通过Modbus、模拟口、CAN 等采集。</li>
                <li><span class="bold-text">方式三：</span>PLC——安装在各类设备中用于控制与监控的控制器，可采集并上报所需遥测、状态变化或事件通知。</li>
            </ul>
            <h3>IoT 数据可视化与通知</h3>
            <div class="text-content small-margin">在连接成千上万设备的大型IoT方案中，无法逐台监控每台设备。业务方希望在设备需要关注时收到通知，例如在电池电量低于 3.1V 时收到告警。此时IoT应用将当前电量与阈值比较，并通过配置的通知渠道向责任人发送告警。ThingsBoard 通过通知中心与可配置告警规则支持此类场景。</div>
            <h2>什么是边缘计算？</h2>
            <div class="text-content small-margin">边缘计算将处理逻辑从中心云下放到靠近数据采集设备的边缘，以加速数据处理；同时减少设备到云的数据传输，降低系统成本与网络压力。ThingsBoard 提供边缘产品（https://thingsboard.io/products/thingsboard-edge/），可对多套边缘部署进行配置、下发与控制。ThingsBoard 云作为集中配置点，用户在此定义处理逻辑、数据保留策略、工作流与可视化仪表盘，并下发到边缘。边缘侧 ThingsBoard 与本地设备/传感器通信、处理数据，并将所需部分上报至云。</div>
            <h2>IoT 安全监控说明</h2>
            <div class="text-content medium-margin">保障IoT应用安全可从三个维度入手：</div>
            <ul class="list">
                <li>物理安全：防止未授权用户接触IoT设备并篡改配置或注入故障。</li>
                <li>中间人(MitM)攻击防护：为防止利用软件漏洞对IoT基础设施的外部攻击，需对通信通道加密，并定期更新固件与软件以修补可被利用的安全缺口。</li>
                <li>配置基于角色的访问控制，明确权限与认证机制，包括应用用户的数据可见性与权限、审计日志、会话管理、多因素认证与密码策略。</li>
            </ul>
            <h2>IoT 设备管理仪表盘基础</h2>
            <div class="text-content small-margin">物联网仪表盘作为联网设备的指挥中心，以可视化方式呈现数据并便于控制，也称IoT控制面板。</div>
            <h3 class="small-padding">IoT 平台仪表盘的主要组成部分包括：</h3>
            <ul class="list">
                <li>部件：作为基本单元，呈现单项信息。</li>
                <li>数据源：IoT 传感器仪表盘从网关、云服务等多种源拉取数据，经部件处理与展示。</li>
                <li>用户控件：交互元素使用户可与仪表盘互动，如向设备下发命令或调整设置。</li>
                <li>告警：良好的IoT仪表盘平台提供实时告警，帮助发现异常与问题。</li>
            </ul>
            <div class="text-content">这些部分协同工作，使仪表盘从数据中提供有价值洞察，企业可基于可视化数据制定策略与规划。</div>
            <h2>IoT 监控仪表盘的重要性</h2>
            <div class="text-content medium-margin">IoT 监控仪表盘在提升运营效率、优化资源利用与支撑数据驱动决策方面至关重要。以下是集成IoT仪表盘的五个重要原因：</div>
            <ul class="list">
                <li>实时洞察：IoT 数据仪表盘提供联网设备与流程的在线可见性，便于对关键事件及时响应并预防潜在故障。</li>
                <li>数据驱动决策：通过汇聚与分析多源数据，IoT 数据仪表盘支持企业做出数据驱动决策。</li>
                <li>高效资源管理：采用IoT仪表盘可减少停机、提升运营效率。</li>
                <li>发现业务机会：企业可对比实时与历史数据，发现新的增长与拓展机会。</li>
                <li>成本节约：通过监控能耗与设备表现，企业可优化运营、降低成本。</li>
            </ul>
            <h2 class="line-height-small">不可或缺的IoT控制面板：您会认可的特性</h2>
            <div class="text-content medium-margin">ThingsBoard 解决方案模板是平台的重要功能，可显著缩短IoT产品的上市时间。以下为其成为IoT部署基石的主要特点：</div>
            <ul class="list">
                <li>ThingsBoard 的IoT控制面板界面直观易用。</li>
                <li>我们的IoT传感器仪表盘提供强大的<a class="article-link" href="/device-management/">IoT 设备管理</a>能力。</li>
                <li>使用 ThingsBoard 可轻松按需定制仪表盘。</li>
                <li>ThingsBoard 控制面板内置规则引擎，可根据预定义条件执行自动化动作。</li>
                <li>我们的IoT设备仪表盘提供完善的数据分析与可视化工具。</li>
                <li>安全在IoT部署中至关重要，我们提供细粒度访问控制，确保仅授权人员可访问敏感信息与关键功能。</li>
            </ul>
            <div class="text-content">如需了解 ThingsBoard 解决方案模板的详细概览，请参阅<a class="article-link" href="/docs/pe/solution-templates/overview/">IoT 解决方案模板概览</a>。</div>
            <h2>IoT 监控仪表盘助您达成业务目标</h2>
            <div class="text-content medium-margin">实现可衡量的业务目标需要策略支撑。IoT 仪表盘应用是其中的关键，为IoT落地中的常见挑战提供实用方案：</div>
        </div>
    </div>
</div>
<div class="details-cards-block-wrapper">
    <div class="details-cards-block">
        <div class="details-card">
            <span class="header">主动问题处理</span>
            <span class="content">支持预防性维护，在问题影响运营前予以解决。</span>
        </div>
        <div class="details-card">
            <span class="header">可扩展与面向未来</span>
            <span class="content">保证可扩展性，便于随技术演进无缝接入新设备与技术。</span>
        </div>
        <div class="details-card">
            <span class="header">全球市场触达</span>
            <span class="content">打破地域限制，支持企业向全球提供产品与服务。</span>
        </div>
    </div>
</div>
<div class="block-wrapper wrapper-main-color medium-padding">
    <div class="block-content">
        <div class="text-wrapper">
            <div class="text-content">通过应对这些常见业务挑战，IoT 仪表盘不仅使业务目标可达成，还能在市场中赢得竞争优势。</div>
            <h2>IoT 仪表盘示例</h2>
            <div class="text-content medium-margin">IoT 仪表盘用途广泛，可针对不同行业与应用定制。以下为常见示例：</div>
            <h3 class="small-padding">设备监控仪表盘：</h3>
            <div class="text-content medium-margin">此类仪表盘将传感器数据可视化，便于制造与设施管理部门实时掌握全厂运行状态、各产线设备及故障设备情况。</div>
        </div>
        <img class="image" srcset="/images/iot-articles/monitoring_dashboard_2_1090x681.webp 1090w, /images/iot-articles/monitoring_dashboard_2_2180x1362.webp 2180w" sizes="(max-width: 1920px) 1090px, (min-width: 1921px) 2180px" src="/images/iot-articles/monitoring_dashboard_2_1090x681.webp" alt="IoT energy management office monitoring"/>
        <div class="text-wrapper">
            <h3 class="small-padding">用电量仪表盘：</h3>
            <div class="text-content">在工厂、仓库等建筑中，可用用电量仪表盘监控能耗；当接近预设值时发出告警，便于采取有效节电措施。</div>
        </div>
        <img class="image" srcset="/images/iot-articles/monitoring_dashboard_3_1090x658.webp 1090w, /images/iot-articles/monitoring_dashboard_3_2180x1316.webp 2180w" sizes="(max-width: 1920px) 1090px, (min-width: 1921px) 2180px" src="/images/iot-articles/monitoring_dashboard_3_1090x658.webp" alt="IoT energy management office monitoring"/>
        <div class="text-wrapper">
            <h3 class="small-padding">预测管理仪表盘：</h3>
            <div class="text-content">该仪表盘监控各产线实际产量与计划的符合度，深入分析偏差原因并用于下一阶段全方位改进。</div>
        </div>
        <img class="image" srcset="/images/iot-articles/monitoring_dashboard_4_1090x672.webp 1090w, /images/iot-articles/monitoring_dashboard_4_2180x1344.webp 2180w" sizes="(max-width: 1920px) 1090px, (min-width: 1921px) 2180px" src="/images/iot-articles/monitoring_dashboard_4_1090x672.webp" alt="IoT energy management office monitoring"/>
        <div class="text-wrapper">
            <h2>如何使用 ThingsBoard 仪表盘</h2>
            <div class="sub-title">使用 ThingsBoard 开源IoT仪表盘可按以下步骤操作：</div>
            <ul class="list">
                <li>登录 ThingsBoard 实例并进入 「实体」部分。</li>
                <li>点击表格右上角「+」图标，选择「添加新仪表盘」。</li>
                <li>为IoT Web 仪表盘输入名称，此处无需其他修改。</li>
                <li>免费创建仪表盘后，即可开始添加部件。</li>
                <li>每个部件可配置为展示一个或多个设备的数据，包括数据类型、展示格式等。</li>
                <li>添加并配置完所有部件后，请保存仪表盘。</li>
            </ul>
            <div class="text-content">更详细的IoT设备仪表盘使用说明请参阅<a class="article-link" href="/docs/pe/user-guide/dashboards/">使用 IoT 仪表盘</a>指南。</div>
            <h2>ThingsBoard IoT 仪表盘实践（案例）</h2>
        </div>
        <div class="definitions-block">
            <div class="definitions-list">
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">资产管理</div>
                    <div class="definition">引入 ThingsBoard IoT 仪表盘后，该设施获得了设备性能与生产指标的实时可见性，预测性维护告警保障及时维修，减少停机。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">提升零售客户体验</div>
                    <div class="definition">ThingsBoard IoT 仪表盘追踪客流、分析客户行为并监控库存，所得洞察支撑选品与个性化营销。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">设备连接与数据采集</div>
                    <div class="definition">通过 ThingsBoard IoT 仪表盘，该供应商实现了设备性能的实时监控与潜在问题的主动告警。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">优化农业实践</div>
                    <div class="definition">农场使用 ThingsBoard IoT 仪表盘监控土壤湿度、温度与作物状况，并实施数据驱动的灌溉与施肥策略。</div>
                </div>
            </div>
        </div>
        <div class="text-wrapper">
            <h2>移动端远程在线查看 IoT 数据</h2>
            <div class="text-content medium-margin">原生移动应用提供对监控系统的快速直观访问，便于快速查找所需信息或响应潜在问题。移动监控应用支持摄像头扫描二维码/条形码，例如快速跳转到指定设备的监控页；移动设备GPS也可提升位置追踪场景下的体验，用户可查看附近设备/系统及状态。ThingsBoard 提供 Flutter 移动 SDK 以快速构建原生应用。仪表盘布局可为PC与移动端分别配置，ThingsBoard 部件与仪表盘适配移动端，同一监控仪表盘可在Web与移动应用中复用。</div>
            <h2>IoT 监控软件与第三方系统集成</h2>
            <div class="text-content medium-margin">企业IT与OT系统的集成是运营效率的重要一环。来自IoT传感器的指标与信号可与客户其他系统集成，提升运营可见性与自动化流程。例如，从IoT电表采集数据的监控应用可与财务系统集成，自动生成账单或成本报表；工业场景中振动与超声波传感器数据可生成维护告警，告警产生后由负责事件管理的第三方系统自动接收，维护团队据此响应。本平台支持通过不同通信通道与API与外部系统双向集成，常用方式包括 REST API、MQTT 及消息代理。</div>
            <h2>总结</h2>
            <div class="text-content medium-margin">在IoT管理领域，ThingsBoard 致力于成为IoT解决方案的领先者。我们凭借成熟团队，打造了能够将复杂挑战转化为直观方案的IoT仪表盘。</div>
            <div class="text-content medium-margin">我们易用的免费IoT仪表盘软件让您轻松应对IoT的复杂性，通过一系列强大工具帮助企业释放联网生态的全部潜力。</div>
            <div class="text-content">我们以前沿技术与易用设计相结合。选择 ThingsBoard，不仅是选择IoT平台，更是选择一位致力于助您实现业务目标的伙伴。</div>
        </div>
    </div>
</div>
<div id="contact-us" class="block-wrapper wrapper-main-color">
    <div class="block-content">
        <div class="contact-us-content">
            <div class="info">
                <div class="title">准备发布您的独特产品？</div>
                <div class="text">留下姓名与邮箱，我们将在 2 个工作日内回复</div>
            </div>
            <form id="Serv_MonitDash_ReadyToLaunch" class="contact-form gtm_form readyToLaunchForm" method="post" onsubmit="return validateContactForm(this)">
                <fieldset>
                    <div class="form-section">
                        <div class="form-element">
                            <label for="name">
                                <input id="name" class="contact-us-form-control" value="" placeholder="您的姓名" name="name" type="text" size="40" maxlength="50">
                                <p>姓名*</p>
                            </label>
                        </div>
                        <div class="form-element">
                            <label for="email">
                                <input id="email" class="contact-us-form-control" value="" placeholder="请输入邮箱" name="email" type="email" size="40" maxlength="80">
                                <p>邮箱地址*</p>
                            </label>
                        </div>
                    </div>
                    <div class="submit-button-container">
                        <input class="contact-us-button" value="提交" type="submit">
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>