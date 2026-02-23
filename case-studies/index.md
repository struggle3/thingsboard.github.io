---
layout: case-studies
title: IoT 案例展示 | 企业如何借助 ThingsBoard 取得成功
notitle: "true"
customTitle: "true"
description: 了解零售、能源、物流等行业企业如何借助 ThingsBoard 物联网平台推动数字化转型，提升效率、增长与创新。
formSubject: "General Feedback"
modalTitle: "Tell us about your success"
modalDescription: "Get your brand featured across our global channels — website, social media, and community."
pagination: "true"
containerId: "case-studies-clients"
filterSelector: ".filter[data-container-id='case-studies-clients']"
itemsSelector: ".client-card"
itemsPerPage: "9"

---

<div class="case-studies-wrapper">
    <section class="case-studies-hero">
        <h1>案例展示</h1>
        <h2>了解 ThingsBoard 如何帮助客户构建并改进业务</h2>
        <div class="card">
            <div class="image">
                <a href="/case-studies/schwarz"><img src="/images/case-studies/schwarz.svg" title="Schwarz Group" alt="Schwarz Group logo"></a>
            </div>
            <div class="text">
                <p class="category">智慧零售</p>
                <h3>零售业IoT：Schwarz Group 如何借助 ThingsBoard 加速数字化</h3>
                <div class="image inner">
                    <img src="/images/case-studies/schwarz.svg" alt="Schwarz logo">
                </div>
                <p>Schwarz Group 总部位于德国内卡苏尔姆，是全球最大的零售企业之一，业务遍及 32 个国家，管理约 13,900 家门店，员工约 575,000 人。每天有数百万人在 Schwarz Group 超市购物。</p>
                <a href="/case-studies/schwarz" class="button gtm_button">了解更多 <span class="visually-hidden">Schwarz Group 如何借助 ThingsBoard 加速数字化</span></a>
            </div>
        </div>
    </section>
    {% assign filters = "工业4.0,智慧能源,智慧基础设施,冷链监控,智慧城市,仓库监控,设施管理,智慧物联网方案,智慧农业,电信" | split: "," %}
    {% include filter.html filters = filters mode = "tab" containerId = "case-studies-clients" hyphenSplit = "true" %}
    {% assign linksCount = card.links | size %}
    <div class="links{% if linksCount >= 2 %} partnersCarousel owl-carousel owl-theme{% endif %}"{% if linksCount >= 2 %} data-settings='{"nav":true,"loop":false,"margin":10,"autoWidth":true,"dots":false,"autoplay":false,"smartSpeed":200}'{% endif %}>
        {% for link in card.links %}
            <a href="{{ link[1].href }}">{{ link[1].label }}</a>
        {% endfor %}
    </div>
    <section id="case-studies-clients">
        <div class="client-card" data-category="冷链监控">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/ariot.webp');">
                <a class="content" href="/case-studies/ariot">
                    <img style="height: 75px" class="logo" src="/images/case-studies/ariot.svg" title="ARIOT IOT TEKNOLOJILERI" alt="ARIOT IOT TEKNOLOJILERI logo">
                    <p>智慧医疗：ARIOT IOT TEKNOLOJILERI 与 ThingsBoard 如何助力 Medline Adana 医院保障患者安全与 JCI 合规</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Medline Adana 医院如何借助 ARIOT IOT TEKNOLOJILERI 与 ThingsBoard 保障患者安全与 JCI 合规</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="工业4.0">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/super-bock-group.webp');">
                <a class="content" href="/case-studies/super-bock">
                    <img class="logo" src="/images/case-studies/super-bock-group.svg" title="Super Bock Group" alt="Super Bock Group logo">
                    <p>啤酒配送革新：ThingsBoard 如何赋能 Super Bock Group</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">ThingsBoard 如何赋能 Super Bock Group</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧城市">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%),url('/images/case-studies/kiotera.webp');">
                <a class="content" href="/case-studies/kiotera">
                    <img class="logo" src="/images/case-studies/kiotera.svg" title="KIOTERA" alt="KIOTERA logo">
                    <p>快速落地IoT：KIOTERA 客户如何从基于 ThingsBoard 的标准化IoT方案中获益</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">KIOTERA 基于 ThingsBoard 的快速IoT落地</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧物联网方案">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/onedata.webp');">
                <a class="content" href="/case-studies/onedata">
                    <img class="logo" src="/images/case-studies/onedata.svg" title="OneData" alt="OneData logo">
                    <p>可视化转型：OneData 如何将多专科医院效率提升 60–70%</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">OneData 如何借助 ThingsBoard 提升医院效率</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧城市">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/x-telia.webp');">
                <a class="content" href="/case-studies/xtelia">
                    <img style="height: 35px" class="logo" src="/images/case-studies/x-telia.svg" title="X-TELIA" alt="X-TELIA logo">
                    <p>规模化智慧标牌：X-TELIA 基于 ThingsBoard 部署 LoRaWAN™ 停车管理</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">X-TELIA 基于 ThingsBoard 部署 LoRaWAN™ 停车管理</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%),url('/images/case-studies/oxi.webp');">
                <a class="content" href="/case-studies/oxi">
                    <img class="logo" src="/images/case-studies/oxi.svg" title="OXI Trade" alt="OXI Trade logo">
                    <p>赋能替代能源：OXI TRADE 如何借助 ThingsBoard 简化IoT基础设施</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">OXI TRADE 如何借助 ThingsBoard 简化IoT基础设施</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧城市">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/tjk-solutions.webp');">
                <a class="content" href="/case-studies/tjk-solutions">
                    <img class="logo" src="/images/case-studies/tjk-solutions.svg" title="TJK-Solutions" alt="TJK-Solutions logo">
                    <p>保障关键通信：TJK-Solutions 如何用 ThingsBoard 监控灾害响应中的 Meshtastic 基础设施</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">TJK-Solutions 如何用 ThingsBoard 监控灾害响应中的 Meshtastic 基础设施</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/energenix.webp');">
                <a class="content" href="/case-studies/energenix">
                    <img class="logo" src="/images/case-studies/energenix.svg" title="Energenix" alt="Energenix logo">
                    <p>规模化可再生能源智能：Energenix 如何用 ThingsBoard 监控与优化 120+ MW 光伏资产</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Energenix 如何用 ThingsBoard 监控与优化 120+ MW 光伏资产</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="工业4.0">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/dacor.webp');">
                <a class="content" href="/case-studies/dacor">
                    <img class="logo" src="/images/case-studies/dacor.svg" title="süc//dacor GmbH" alt="süc//dacor GmbH logo">
                    <p>süc//dacor GmbH 基于 ThingsBoard 为汽车供应商实现实时生产监控</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">süc//dacor GmbH 基于 ThingsBoard 的实时生产监控</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/comet.webp');">
                <a class="content" href="/case-studies/comet">
                    <img style="height: 42px" class="logo" src="/images/case-studies/comet.svg" title="co.met" alt="comet logo">
                    <p>赋能公用事业未来：co.met GmbH 与 ThingsBoard 的IoT突破</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">co.met GmbH 与 ThingsBoard 的IoT突破</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧城市">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/iioote.webp');">
                <a class="content" href="/case-studies/iioote">
                    <img style="height: 35px" class="logo" src="/images/case-studies/iioote.svg" title="iiOOTE" alt="iiOOTE logo">
                    <p>从原型到商用服务：iiOOTE 如何借助 ThingsBoard 规模化IoT</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">iiOOTE 基于 ThingsBoard 的 LoRaWAN™ 停车管理部署</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧基础设施">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/obb.webp');">
                <a class="content" href="/case-studies/obb-infra">
                    <img class="logo" src="/images/case-studies/obb.svg" title="ÖBB-Infrastruktur AG" alt="ÖBB-Infrastruktur AG logo">
                    <p>智慧铁路基础设施：ÖBB-Infrastruktur AG 的数字化转型 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">ÖBB-Infrastruktur AG 借助 ThingsBoard 的数字化转型</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="冷链监控">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/senseing.webp');">
                <a class="content" href="/case-studies/senseing">
                    <img class="logo" src="/images/case-studies/senseing.svg" title="SenseING GmbH" alt="SenseING GmbH logo">
                    <p>用IoT驱动的温控监控变革食品物流 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">基于 ThingsBoard 的温控监控变革食品物流</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧城市">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/awake.webp');">
                <a class="content" href="/case-studies/awake">
                    <img style="height: 35px" class="logo" src="/images/case-studies/awake.svg" title="Awake" alt="Awake">
                    <p>Awake：用定制IoT方案统一全球租赁运营 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">用定制IoT方案统一全球租赁运营</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧农业">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/agrolog.webp');">
                <a class="content" href="/case-studies/agrolog">
                    <img class="logo" src="/images/case-studies/agrolog.svg" title="Agrolog" alt="ASG-Tech logo">
                    <p>农业革新：Supertech Agroline 如何借助 ThingsBoard 构建可扩展IoT平台</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Supertech Agroline 与 ThingsBoard 的智慧农业平台</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="设施管理">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/suessco.webp');">
                <a class="content" href="/case-studies/suessco">
                    <img class="logo" src="/images/case-studies/suessco.svg" title="SuessCo Sensors GmbH" alt="SuessCo Sensors GmbH logo">
                    <p>SuessCo：以IoT枢纽为传感器监控平台 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">SuessCo：以IoT枢纽为传感器监控平台</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧物联网方案">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/asg-tech.webp');">
                <a class="content" href="/case-studies/asg-tech">
                    <img class="logo" src="/images/case-studies/asg-tech.svg" title="ASG-Tech" alt="ASG-Tech logo">
                    <p>从概念到上线：ASG Tech 与 ThingsBoard 的快速IoT创新<br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">ASG Tech 与 ThingsBoard 的快速IoT创新</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="电信">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/t-mobile-cz.webp');">
                <a class="content" href="/case-studies/t-mobile-cz">
                    <img style="height: 87px" class="logo" src="/images/case-studies/t-mobile-cz.svg" title="T-Mobile-CZ" alt="T-Mobile-CZ logo">
                    <p>T-Mobile CZ 借助 ThingsBoard 规模化IoT原型验证 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">T-Mobile CZ 借助 ThingsBoard 规模化IoT原型验证</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧农业">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/keners.webp');">
                <a class="content" href="/case-studies/keners">
                    <img class="logo" src="/images/case-studies/keners.svg" title="Keners" alt="Keners logo">
                    <p>从土壤到传感器：Keners 如何借助 ThingsBoard 革新农业<br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Keners 如何借助 ThingsBoard 革新农业</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/berliner-energieinstitut.webp');">
                <a class="content" href="/case-studies/berliner-energieinstitut">
                    <img class="logo" src="/images/case-studies/berliner-energieinstitut.svg" title="Berliner Energieinstitut" alt="Berliner Energieinstitut logo">
                    <p>从想法到IoT数周落地：Berliner Energieinstitut 如何借助 ThingsBoard 快速扩展</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Berliner Energieinstitut 如何借助 ThingsBoard 快速扩展</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/e2cbms.webp');">
                <a class="content" href="/case-studies/e2cbms">
                    <img style="height: 87px" class="logo" src="/images/case-studies/e2cbms.svg" title="Environmental Energy Controls" alt="Environmental Energy Controls logo">
                    <p>智慧建筑更简单：Environmental Energy Controls 选择 ThingsBoard 实现可扩展 BMS 方案</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Environmental Energy Controls 借助 ThingsBoard 实现智慧建筑</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/circutor.webp');">
                <a class="content" href="/case-studies/circutor">
                    <img style="height: 42px" class="logo" src="/images/case-studies/circutor.svg" title="co.met" alt="circutor logo">
                    <p>Circutor 借助 ThingsBoard 物联网平台扩展全球能源管理</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Circutor 借助 ThingsBoard 物联网平台扩展全球能源管理</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="设施管理">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/oneserve.webp');">
                <a class="content" href="/case-studies/oneserve">
                    <img class="logo" src="/images/case-studies/oneserve.svg" title="Oneserve" alt="Oneserve logo">
                    <p>Oneserve 基于 ThingsBoard IoT 构建敏捷 FSM 平台 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Oneserve 如何基于 ThingsBoard IoT 构建敏捷 FSM 平台</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧物联网方案">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/mdeg.webp');">
                <a class="content" href="/case-studies/mdeg">
                    <img style="height: 87px" class="logo" src="/images/case-studies/mdeg.svg" title="mdeg" alt="mdeg logo">
                    <p>mdeg 如何借助 ThingsBoard 规模化安全医疗设备连接 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">mdeg 借助 ThingsBoard 规模化安全医疗设备连接</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧基础设施">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/tps.webp');">
                <a class="content" href="/case-studies/tps">
                    <img style="height: 87px" class="logo" src="/images/case-studies/tps.svg" title="TPS" alt="TPS logo">
                    <p>文化遗产数字化：TPS 如何借助 ThingsBoard 连接博物馆</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">TPS 如何借助 ThingsBoard 连接博物馆</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧能源">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/nettra.webp');">
                <a class="content" href="/case-studies/nettra">
                    <img class="logo" src="/images/case-studies/nettra.svg" title="Nettra" alt="Nettra logo">
                    <p>省时降本：Nettra 的IoT平台成功捷径 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">省时降本：Nettra 的IoT平台成功捷径</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="智慧基础设施">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/kalitec.webp');">
                <a class="content" href="/case-studies/kalitec">
                    <img class="logo" src="/images/case-studies/kalitec.svg" title="Kalitec" alt="Kalitec logo">
                    <p>Kalitec 与 ThingsBoard 如何用IoT创新重新定义城市安全 <br> &nbsp;</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">Kalitec 与 ThingsBoard 用IoT创新重新定义城市安全</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="仓库监控">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/vypin.webp');">
                <a class="content" href="/case-studies/vypin">
                    <img class="logo" src="/images/case-studies/vypin.svg" title="Vypin LLC" alt="Vypin LLC logo">
                    <p>WhereView（ThingsBoard）实现可靠温湿度监控</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">WhereView（ThingsBoard）可靠温湿度监控</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="电信">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/tektelic.webp');">
                <a class="content" href="/case-studies/tektelic">
                    <img style="height: 56px" class="logo" src="/images/case-studies/tektelic.svg" title="TEKTELIC" alt="TEKTELIC logo">
                    <p>从传感器到仪表盘：<br> TEKTELIC 基于 ThingsBoard 的快速IoT部署</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">TEKTELIC 基于 ThingsBoard 的快速IoT部署</span>
                </a>
            </div>
        </div>
        <div class="client-card" data-category="工业4.0">
            <div class="bg-wrap" style="background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.30) 0%, rgba(0, 0, 0, 0.30) 100%), url('/images/case-studies/iona.webp');">
                <a class="content" href="/case-studies/iona">
                    <img class="logo" src="/images/case-studies/iona.svg" title="IONA Tech" alt="IONA Tech logo">
                    <p>保护电子设备与员工：IONA Tech 借助 ThingsBoard 的IoT转型</p>
                    <p class="link">了解更多 <i class="fas fa-arrow-right"></i></p>
                    <span class="visually-hidden">IONA Tech 借助 ThingsBoard 的IoT转型</span>
                </a>
            </div>
        </div>
    </section>
    <div id="successStoryBlock" class="success-story-promo" style="display: none;">
        <div class="content">
            <h2>有成功案例要分享？</h2>
            <p>真实故事，真实影响——分享您与 ThingsBoard 的经验！</p>
        </div>
        <button id="caseStudiesContactUs" class="button gtm_button" onclick="openContactUsModal()">联系我们</button>
    </div>
</div>
