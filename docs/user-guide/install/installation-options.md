---
layout: docwithnav
assignees:
- ashvayka
title: ThingsBoard 安装选项
description: 适用于多种操作系统和云平台的 ThingsBoard 安装说明
notitle: "true"
---

<div class="installation-options">
    <div class="install-options-header">
       <div class="install-options-hero">
          <div class="container">
            <div class="install-options-hero-content">
                <h1>ThingsBoard 安装选项</h1>
                <div class="install-options-description">
                    <p>
                        ThingsBoard 设计可在多种硬件上运行使用，从本地 Raspberry PI 到云端强劲服务器
                    </p>
                </div>
            </div>
            <div class="deployment-container">
                <nav id="install-navigation" class="install-navigation" data-target-id="ceInstallType">
                    <ul id="menu-install-navigation-1" class="menu">
                        <li id="menu-item-liveDemo" class="menu-item tb-live-demo" data-tab="liveDemo">
                            <p>
                                <img src="/images/livedemo-icon.svg" title="试用 ThingsBoard Cloud" alt="Live demo icon" width="28" height="28">
                                <span>SaaS</span>
                            </p>
                        </li>
                        <li id="menu-item-onPremise" class="menu-item tb-on-premise" data-tab="onPremise">
                            <p>
                                <img src="/images/pricing/self-icon.svg" title="在自有服务器上安装 ThingsBoard" alt="On-premise installation icon" width="28" height="28">
                                <span>On-premises</span>
                            </p>
                        </li>
                        <li id="menu-item-cloud" class="menu-item tb-cloud" data-tab="cloud">
                            <p>
                                <img src="/images/pricing/cloud-icon.svg" title="在云端使用 ThingsBoard" alt="Cloud deployment icon" width="28" height="28">
                                <span>Cloud</span>
                            </p>
                        </li>
                    </ul>
                </nav>
                <div class="deployment-div">
                    {% include installation-options-cards.liquid installationOptions="installation-options-ce" %}
                </div>
            </div>
          </div>
       </div>
    </div>
</div>


<script type="text/javascript">

</script>
