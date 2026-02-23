---
layout: docwithnav-pe
assignees:
- ashvayka
title: ThingsBoard 专业版安装选项
description: 适用于各种操作系统和云平台的 ThingsBoard 专业版安装说明
notitle: "true"
redirect_from: "/docs/pe/user-guide/install/installation-options/"
---

<div class="installation-options">
    <div class="install-options-header">
       <div class="install-options-hero">
          <div class="container">
            <div class="install-options-hero-content">
                <h1>ThingsBoard 专业版安装选项</h1>
                <div class="install-options-description">
                    <p>
                        ThingsBoard 专业版可在多种硬件上运行，从本地树莓派到云端的强大服务器
                    </p>
                </div>
            </div>
            <div class="deployment-container">
                <nav id="install-navigation" class="install-navigation" data-target-id="peInstallType">
                    <ul id="menu-install-navigation-1" class="menu">
                        <li id="menu-item-liveDemo" class="menu-item tb-live-demo" data-tab="liveDemo">
                            <p>
                                <img src="/images/pricing/saas-icon.svg" title="试用 ThingsBoard Cloud" alt="Live demo icon" width="28" height="28">
                                <span>SaaS</span>
                            </p>
                        </li>
                        <li id="menu-item-onPremise" class="menu-item tb-on-premise" data-tab="onPremise">
                            <p>
                                <img src="/images/pricing/self-icon.svg" title="在您自己的服务器上安装 ThingsBoard" alt="On-premise installation icon" width="28" height="28">
                                <span>本地部署</span>
                            </p>
                        </li>
                        <li id="menu-item-cloud" class="menu-item tb-cloud" data-tab="cloud">
                            <p>
                                <img src="/images/pricing/cloud-icon.svg" title="在云端使用 ThingsBoard" alt="Cloud deployment icon" width="28" height="28">
                                <span>云端</span>
                            </p>
                        </li>
                    </ul>
                </nav>
                <div class="deployment-div">
                    {% include installation-options-cards.liquid installationOptions="installation-options-pe" %}
                </div>
            </div>
          </div>
       </div>
    </div>
</div>

