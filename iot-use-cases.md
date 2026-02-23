---
layout: use-case
title: IoT 应用场景
description: ThingsBoard 物联网平台应用场景
notitle: "true"
contactUsModal: "true"


---

<div class="iot-use-cases-hero">
    <div class="iot-use-cases-hero-left">
        <h1 class="iot-use-cases-title">IoT 应用场景</h1>
        <div class="iot-use-cases-description">
            <p>ThingsBoard 物联网平台稳定、可扩展且易用，通过开箱即用的灵活强大功能支持多种IoT应用场景，助您缩短联网产品与智能方案的上线时间。平台与设备无关，可接入并分析来自任意传感器、联网设备或应用的遥测数据。ThingsBoard 的功能与丰富API可让您节省常规IoT工作的时间与资源，专注于解决方案的差异化能力。</p>
            <p>下方列出了ThingsBoard已成功落地的部分行业场景，每个场景均配有PoC仪表盘与参考架构。</p>
            <p>若您的场景需要更多功能或定制实现，可了解我们的<a href="/services/development-services/">物联网定制开发服务</a>。</p>
        </div>
    </div>
    <div class="iot-use-cases-hero-right">
        {% include contact-us-card.liquid modal="true" %}
    </div>
</div>
{% assign filters = "General,SCADA" | split: "," %}
{% include filter.html filters = filters mode = "tab" containerId = "usecase-list" %}

{% include use-cases-cards.html %}

