---
layout: iot-article
title: ᐉ IoT设备管理平台
notitle: "true"
description: "IoT设备管理 ✔ IoT设备控制 ⚫ ThingsBoard ➤ 助力组织通过REST API或Web UI更好地管控和获取各类设备数据"
redirect_from: "/docs/services/device-management/"
---
<section class="hero light-text"></section>
<div id="header-block" class="block-wrapper wrapper-main-color">
    <div class="block-content">
        <div class="text-wrapper">
            <span class="read-info">阅读约 6 分钟</span>
            <h1>IoT设备管理</h1>
            <div class="text-content medium-margin">在快速发展的物联网（IoT）领域，管理大量设备往往颇具挑战。IoT设备管理应运而生，通过提供追踪、监控、控制、管理、防护和运维连接设备的工具，简化这一过程。</div>
            <div class="text-content">它提供设备状态、数据流量等的全面视图，实质上充当您所有IoT设备的控制中心，确保其平稳、安全运行。</div>
        </div>
        <img class="image" srcset="/images/iot-articles/device_management_1_1090x672.webp 1090w, /images/iot-articles/device_management_1_2180x1344.webp 2180w" sizes="(max-width: 1920px) 1090px, (min-width: 1921px) 2180px" src="/images/iot-articles/device_management_1_1090x672.webp" alt="深色主题的IoT解决方案仪表板（含部件）"/>
        <div class="text-wrapper">
            <h2>IoT生态系统是什么？</h2>
            <div class="text-content medium-margin">IoT生态系统是物理硬件与IoT应用相互通信以创造价值的网络，主要包括4个核心组成部分：</div>
            <ul class="list">
                <li>负责数据采集的设备与传感器。</li>
                <li>连接层负责从设备到应用的可靠数据传输。</li>
                <li>数据处理与分析组件定义对采集数据的处理方式，其主要作用是从设备与传感器中提取有价值的信息。</li>
                <li>用户界面——移动应用或Web门户。设备管理仪表板为用户提供与IoT系统交互的工具。</li>
            </ul>
            <div class="text-content medium-margin">根据业务需求，IoT生态系统还可包括自动化工作流引擎、告警与通知、边缘计算、异常检测模块、报表等组件。</div>
            <h2>什么是IoT设备管理？</h2>
            <div class="text-content medium-margin">IoT设备管理从单一位置控制连接设备的方方面面，涵盖传感器、仪表、PLC、连接设备、摄像头、网关和处理器等。IoT设备管理平台支持的服务包括注册与配置、库存管理、远程配置和固件升级。</div>
            <div class="text-content medium-margin">从受管IoT设备采集位置与使用数据是设备管理的核心环节，这些数据用于维护、维修、优化或更换决策。随着更多IoT设备接入关键业务流程，有效的成本管理愈发重要。</div>
            <div class="text-content medium-margin">IoT设备管理系统指与设备的设置、配置和维护相关的任务及相互关联的功能，包括设备设置、设备群的监管与监控以及设备全生命周期管理。</div>
            <h3 class="line-height-small">远程IoT设备控制有何作用？</h3>
            <div class="text-content medium-margin">远程控制是IoT应用的核心功能之一。远程下发命令、修改设备配置、更新固件对设备管理至关重要，这些基础能力是实现设备管理自动化、高效实时管理设备群的关键。</div>
            <div class="text-content medium-margin">例如，预定义的设备配置模板可加快向大量设备推送配置；设备自动接入IoT平台时，系统会自动下发最新固件与配置。这类自动化流程在减少人工参与的同时保证设备安全与效率，避免企业在扩展设备规模时常见的可扩展性问题——尤其当远程设备管理平台缺乏即用型自动化规则时。定时或条件规则可自动向设备群下发所需配置、命令或固件，使运维人员专注于系统效率与事件管理而非手动控制设备。</div>
            <div class="text-content medium-margin">选择IoT管理系统时，建议考虑远程设备管理中常被忽视的另一面：命令重试策略、故障转移配置能力，以及对当前离线设备（命令在其上线后仍需送达）的延迟命令投递。</div>
            <h3 class="line-height-small">IoT设备配置管理所用协议</h3>
            <div class="text-content medium-margin">IoT连接协议可分为以下几类：</div>
            <ul class="list">
                <li><span class="bold-text">通用协议：</span> IoT领域最常用的有MQTT、HTTP、CoAP、LwM2M，轻量且适于实时消息与设备管理，可在资源有限的设备上运行并支持数据加密以保障安全。MQTT凭借发布/订阅模型成为IoT生态系统的事实标准；CoAP更贴近REST模型但针对M2M优化；LwM2M则为简化设备管理与远程控制而设计。</li>
                <li><span class="bold-text">工业与自动化系统：</span> OPC-UA、Modbus、BACnet是工业领域常用协议的典型代表，多为设备专用且设计年代早于“IoT”概念。通常需通过网关或集成服务将此类系统接入远程IoT设备软件。</li>
                <li><span class="bold-text">低功耗广域网（LPWAN）：</span> 适用于需在远距离、低能耗下传输数据以延长电池寿命的场景。NB-IoT、LoRaWAN和Sigfox表现优异。设备固定或位于已知区域（工厂、工地、已有LoRa覆盖的城市）时，通常选择LoRaWAN；若设备需跨地域移动，或不愿自建网关、考虑网络覆盖，则NB-IoT更合适，因其由电信运营商管理。</li>
            </ul>
            <div class="text-content medium-margin">当然还有HTTP、AMQP、WebSocket、BLE等常用协议，大量IoT应用将其作为设备与IoT应用间的通信信道。它们可能对设备资源（电池、CPU、内存）要求略高，但开发者通常更熟悉，软件生态也提供丰富的库、系统与最佳实践。</div>
            <div class="text-content medium-margin">ThingsBoard IoT设备管理应用支持多种直连<a class="article-link" href="/docs/pe/api/">协议</a>，用于设备与IoT平台交互——MQTT、CoAP、HTTP、LWM2M、OPC-UA、Modbus等，均为行业标准。此外还支持SNMP、Kafka、TCP/UDP等选项。</div>
            <div class="text-content">我们还<a class="article-link" href="/docs/user-guide/integrations/">接入</a>来自LoRaWAN、Sigfox、NB-IoT、AWS IoT、Azure IoT、Actility ThingPark、TheThingsStack、OceanConnect等外部连接提供商的设备。</div>
            <h3 class="line-height-small">网关与边缘计算的作用</h3>
            <div class="text-content medium-margin">IoT网关在设备与云之间充当桥梁，承担三大职能：</div>
            <ul class="list">
                <li><span class="bold-text">连接与协议转换：</span> 现场设备可使用短距离协议（Bluetooth、LoRA、ZigBee）或仅适用于本地网络的协议（CAN、Modbus、BACnet等）。为实现集中式、可扩展的设备管理，需要网关连接设备与云之间的数据流。网关管理与本地设备的双向连接，将设备载荷转换为统一格式并上传至云，反之亦然。</li>
                <li><span class="bold-text">现场数据存储与预处理：</span> 本地传感器与设备的数据在网关上采集、持久化、预处理后上传云端。这带来两大好处：一是当现场与云连接中断时，数据可暂存于现场网关，避免丢失，恢复连接后可同步；二是可在网关上预聚合，仅将有价值的数据上传云端，从而降低带宽、云端CPU/RAM/磁盘消耗及IoT设备管理应用的总拥有成本。</li>
                <li><span class="bold-text">边缘计算：</span> 数据本地化原则表明，算法越贴近数据源，处理流水线越高效。将处理逻辑从云下沉至边缘，可显著提升响应速度与降低时延，对大数据流的实时场景尤为关键。例如在预测性维护场景中处理振动数据时，边缘处理能大幅降低网络成本并加快分析。数据在边缘处理后，仅有价值部分上传云端。</li>
            </ul>
            <div class="text-content medium-margin">更多详情请参阅<a href="/docs/iot-gateway/what-is-iot-gateway/">IoT Gateway</a>及<a href="https://thingsboard.io/products/thingsboard-edge/">ThingsBoard边缘计算</a>。</div>
            <h2 class="line-height-small">IoT设备顺畅管理的7个关键步骤</h2>
            <div class="text-content">IoT设备管理包括多个关键步骤，以确保IoT设备平稳运行。</div>
        </div>
        <div class="definitions-block">
            <div class="definitions-list">
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">添加与删除设备</div>
                    <div class="definition">为设备注册唯一标识与凭据后，即可与IoT平台通信并上报数据。反之，设备不再需要或将被替换时，可从系统中删除。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">更新固件</div>
                    <div class="definition">IoT设备常需固件更新以增加功能、修复缺陷或修补安全漏洞。借助IoT设备管理应用，可通过空中升级（OTA）机制远程推送更新。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">监控连接状态</div>
                    <div class="definition">检查设备是否在线及运行是否正常。设备离线或异常时，可配置告警通知相关人员。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">管理设备凭据</div>
                    <div class="definition">凭据管理确保仅授权设备能连接平台，包括为新设备签发证书、为退役设备撤销证书及定期轮换证书等。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">将设备分配给客户</div>
                    <div class="definition">许多场景下，IoT设备由无平台管理权限的客户或终端用户使用。此时可将设备分配给客户，使其查看设备数据并管理部分运行配置。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">浏览设备属性、遥测、告警与事件</div>
                    <div class="definition">管理员可浏览设备的属性、遥测数据、告警和事件等各项信息。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">管理设备关系</div>
                    <div class="definition">在复杂IoT部署中，设备之间及设备与资产之间可能以多种方式关联，这些关系可通过IoT平台管理。</div>
                </div>
            </div>
        </div>
        <div class="text-wrapper">
            <h2>使用IoT设备管理软件的优势</h2>
            <div class="text-content">在企业运营中引入IoT设备管理可带来诸多益处。</div>
        </div>
    </div>
</div>
<div id="details-block" class="block-wrapper wrapper-accent-color">
    <div class="block-content">
        <div class="detail">
            <div class="detail-name">高效设备追踪</div>
            <div class="detail-description">IoT设备管理支持企业实时追踪与监控所有连接的IoT设备。 </div>
        </div>
        <div class="detail">
            <div class="detail-name">更好的组织管理</div>
            <div class="detail-description">IoT设备管理工具帮助用户以高效、有序的方式组织所有设备。</div>
        </div>
        <div class="detail">
            <div class="detail-name">成本节约</div>
            <div class="detail-description">通过集中平台管理设备，可减少现场人工维护与排障需求，将资源释放给其他任务。</div>
        </div>
        <div class="detail">
            <div class="detail-name">提升可靠性与一致性</div>
            <div class="detail-description">优秀的IoT设备管理方案将灵活的设备结构、实时访问及对设备状态与性能的全面可见性，统一于自助式平台。</div>
        </div>
        <div class="detail">
            <div class="detail-name">主动维护</div>
            <div class="detail-description">通过监控IoT设备的健康、连接与安全状况，IoT设备管理有助于保障网络平稳运行。</div>
        </div>
        <div class="detail">
            <div class="detail-name">增强安全</div>
            <div class="detail-description">通过管理设备凭据与权限，IoT设备控制可提升IoT生态系统的安全性。</div>
        </div>
    </div>
</div>
<div class="block-wrapper wrapper-main-color medium-padding">
    <div class="block-content">
        <div class="text-wrapper">
            <h2>企业何时应使用IoT设备管理软件</h2>
            <div class="text-content medium-margin">当企业拥有大量设备（数十、数百乃至数千台），并需要从远程或集中位置安全访问以进行固件更新和获取设备健康洞察时，应考虑使用IoT设备管理软件。</div>
            <div class="text-content small-margin">以下场景下IoT设备管理软件尤为实用：</div>
            <ul class="list">
                <li><span class="bold-text">大规模部署。</span> 若业务涉及大量IoT设备，逐台管理难度大。IoT设备管理软件可从单一平台统一管理所有设备，提高效率、节省时间。</li>
                <li><span class="bold-text">安全顾虑。</span> 随着网络威胁增多，保护IoT设备至关重要。设备管理IoT平台提供设备认证、加密等安全能力，抵御潜在威胁。</li>
                <li><span class="bold-text">复杂网络。</span> 若IoT网络中设备间交互复杂，人工管理难度大。设备管理应用可帮您管理设备关系、保障设备间通信顺畅。</li>
            </ul>
            <div class="text-content">总之，若业务重度依赖IoT设备，投入IoT设备管理软件可显著提升运营效率与安全性。</div>
            <h2>企业IoT设备管理可扩展性</h2>
            <div class="text-content">企业通常面对大量IoT设备与传感器，设备管理系统须支持数十万至数百万连接设备。为此应遵循以下最佳实践：</div>
            <ul class="list">
                <li>采用微服务架构，按需支持各组件水平扩展。</li>
                <li>与云厂商集成，利用其基础设施与服务降低系统管理、维护与扩展成本。</li>
                <li>采用边缘计算，在靠近设备处处理数据，降低带宽与时延。</li>
                <li>使用数据分区与分布式数据库，便于按需扩展系统持久层。</li>
                <li>确保安全机制可扩展且系统符合监管要求。</li>
                <li>配置实时监控栈，追踪系统性能与健康状态。</li>
            </ul>
            <h2>全面的设备管理产品</h2>
            <div class="text-content">ThingsBoard提供全面的IoT设备管理功能。我们的设备管理平台支持分布式基础设施的软件、硬件、通信组件以及数据流与数据质量的管理、控制与监控。</div>
            <h3 class="small-padding">我们的解决方案包括：</h3>
            <ul class="list">
                <li>以唯一标识与凭据便捷添加新设备。</li>
                <li>管理设备固件与软件版本，包括批量固件OTA更新工作流及远程推送更新。</li>
                <li>向设备组发送命令与配置更新，实现远程IoT设备控制。</li>
                <li>实时跟踪设备连接状态。</li>
                <li>管理设备凭据，确保仅授权设备可连接您的网络。</li>
                <li>将设备分配给无平台管理权限的客户或终端用户。</li>
                <li>浏览设备属性、遥测数据、告警与事件等各项信息。</li>
            </ul>
            <div class="text-content">我们提供设备与云之间端到端路径的跨层图状视图，助您全面掌握整个IoT生态系统。</div>
        </div>
        <img class="image" srcset="/images/iot-articles/device_settings_1_1090x658.webp 1090w, /images/iot-articles/device_settings_1_2180x1316.webp 2180w" sizes="(max-width: 1920px) 1090px, (min-width: 1921px) 2180px" src="/images/iot-articles/device_settings_1_1090x658.webp" alt="深色主题的IoT解决方案仪表板（含部件）"/>
        <div class="text-wrapper">
            <h2 class="center-text">我们的案例</h2>
            <div class="text-content">ThingsBoard已在多种场景下成功部署IoT设备监控与管理解决方案。</div>
        </div>
        <div class="definitions-block">
            <div class="definitions-list side-paddings">
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">医疗健康</div>
                    <div class="definition">如同运动手环追踪用户活动，我们的解决方案已用于医疗行业，实现患者健康远程监测及血细胞分析仪、血压计、心率仪、血糖传感器等医疗设备接入。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">制造业</div>
                    <div class="definition">在制造业，我们的产品用于监控和管理工业IoT设备，包括机器状态追踪、维护需求预测及生产过程优化。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold padding-top">智慧城市</div>
                    <div class="definition">我们的解决方案已部署于智慧城市项目，管理交通传感器、废物管理系统、智能照明等IoT设备，帮助城市管理者更高效地监控与管理基础设施。</div>
                </div>
                <div class="definitions-list-item one-to-one-and-half align-start">
                    <div class="term bold">能源</div>
                    <div class="definition">我们的工具已用于能源行业管理智能电表、太阳能板等设备，助力能源企业实时监控能耗与产能，提升能源管理效率。</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="contact-us" class="block-wrapper wrapper-main-color">
    <div class="block-content">
        <div class="contact-us-content">
            <div class="info">
                <div class="title">准备好发布您的独特产品了吗？</div>
                <div class="text">留下您的姓名和邮箱，我们将在2个工作日内回复</div>
            </div>
            <form id="Serv_DeviceManage_ReadyToLaunch" class="contact-form gtm_form readyToLaunchForm" method="post" onsubmit="return validateContactForm(this)">
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
