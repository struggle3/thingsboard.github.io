---
layout: use-case
title: ThingsBoard 物联网环境监测解决方案
description: 探索 ThingsBoard 提供的可扩展且安全的物联网环境监测解决方案。连接多种传感器、实现告警自动化并获取实时洞察，以提升工业、商业和智能建筑应用场景中的安全性、效率和舒适度。
notitle: "true"
customTitle: "true"
includeAdvantages: "true"
contactUsModal: "true"

---

{% include usecase-nav.html usecase="environment-monitoring" %}
<div id="scada-fullpage" onclick="this.style.display='none'; document.body.style.overflow='unset'"><div class="image"></div><div class="close-icon"><svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M25.3337 8.5465L23.4537 6.6665L16.0003 14.1198L8.54699 6.6665L6.66699 8.5465L14.1203 15.9998L6.66699 23.4532L8.54699 25.3332L16.0003 17.8798L23.4537 25.3332L25.3337 23.4532L17.8803 15.9998L25.3337 8.5465Z"></path></svg></div></div>
<h1 class="usecase-title">环境监测</h1>
<section class="environment-monitoring-about">
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">环境监测在保障各类设施（从办公楼到工业场所）的安全、舒适和运营效率方面发挥着至关重要的作用。ThingsBoard 完全有能力应对这些挑战。</p>
            </div>
            <div class="demo-button">
                <a id="UseCases_EnvMon_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/dfaef940-8a91-11ec-83d0-83ba2015b874?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button gtm_button">查看实时演示</a>
            </div>
        </div>
        <div class="long">
            <p>ThingsBoard 为<a href="/docs/pe/solution-templates/temperature-humidity-sensors/">环境监测</a>提供可扩展、可靠且安全的平台。内置对 LoRaWAN、NB-IoT 和 Sigfox 的支持，可高效整合大量远距离低功耗传感器，降低基础设施复杂度。平台支持 HTTP、MQTT、CoAP 和 LwM2M 等标准物联网协议，便于连接各类设备并随项目扩展。</p>
            <p>从关键变化实时告警到数据转发到外部分析工具，自动化功能确保主动监测。直观的仪表板、可定制逻辑与无缝集成将原始环境数据转化为可操作的洞察，支持更智能、更快速的决策。</p>        </div>
    </div>
</section>

<section class="environment-monitoring-carousel carousel-padding">
    {% include default-carousel.liquid collectionMap = 'use-cases' collectionKey = 'environment-monitoring' %}
</section> 

{% include contact-us-banner.liquid %}

<section class="environment-monitoring-solution-structure">
    <h2>环境监测解决方案结构</h2>
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">传感器数据通过 HTTP、MQTT、CoAP、LwM2M 等物联网协议，或通过与 LoRaWAN 服务器及其他平台的集成，传输至 ThingsBoard。</p>
            </div>
        </div>
        <div class="long">
            <p>内置流处理引擎即时分析接收的消息、触发事件、生成告警并将数据路由至监测仪表板。采集的数据通过直观仪表板可视化，让用户从单一界面实时掌握告警和性能指标。</p>
        </div>
    </div>
    <div class="scheme">
        <img id="schemeSVG" loading="lazy" src="/images/usecases/environment-monitoring/scheme.svg" alt="环境监测解决方案架构" title="环境监测解决方案架构：物联网设备通过网关连接至云平台进行数据处理、可视化和自动化">
    </div>
</section>

<section class="dashboard-structure section-padding">
    <div class="section-header">
        <h2>环境监测仪表板结构</h2>
        <p>
            仪表板包含多种状态。主状态显示传感器列表、地图上的位置及告警列表。点击表格行可钻取至传感器详情。传感器详情状态支持查看温湿度历史、修改传感器设置和位置。实时仪表板是解决方案模板的一部分。
        </p>
    </div>
    <div class="dashboard-structure-block">
        <div class="menu">
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>环境监测状态</h3>
                    </div>
                    <div class="expansion-content">
                        <p>仪表板通过交互式图表实时监测传感器数据（如温湿度）。界面支持配置告警阈值和传感器位置，并显示带严重级别的活动告警。可分析历史数据并管理设备设置。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>传感器 C1 监测状态</h3>
                    </div>
                    <div class="expansion-content">
                        <p>跟踪传感器 C1 的实时温湿度读数及过去一小时的历史数据。比对关键指标（最小/最大/平均值）以维持最佳环境条件。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>传感器 T1 监测状态</h3>
                    </div>
                    <div class="expansion-content">
                        <p>跟踪传感器 T1 的实时温湿度读数及过去一小时的历史数据。比对关键指标（最小/最大/平均值）以维持最佳环境条件。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>添加或编辑传感器</h3>
                    </div>
                    <div class="expansion-content">
                        <p>可配置传感器的关键阈值，包括高温和低湿度告警。可通过经纬度修改精确地理位置。所有更改在点击保存前保持待定，取消可恢复未保存的修改。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="applications applications-additional summary-margin section-padding">
    <div class="section-header">
        <h2>环境监测解决方案的应用场景</h2>
        <p>物联网驱动的环境监测系统可部署于各行各业，以保障安全、合规和可持续性。以下是该解决方案发挥重要价值的重点领域。</p>
    </div>
    <div class="applications-container-large">
        <div class="text-row-top">
            <div class="text-block">
                <h3>智慧城市与城市基础设施</h3>
                <p>监测城市各区域的空气质量、噪音、温湿度，支持环境政策、居民预警和改善城市居住条件。</p>
            </div>
            <div class="text-block">
                <h3>农业与温室设施</h3>
                <p>根据占用情况控制教室、实验室和宿舍的能耗，安排能源使用并确保达成可持续目标。</p>
            </div>
            <div class="text-block">
                <h3>仓库与冷库设施</h3>
                <p>监测温湿度及空气循环，确保易腐品和药品的存储条件适宜。</p>
            </div>
        </div>
        <div class="images-row">
            <div class="application-image"><img src="/images/usecases/environment-monitoring/smart-cities-1.svg" alt="智慧城市" title="智慧城市与城市基础设施"></div>
            <div class="application-image"><img src="/images/usecases/environment-monitoring/laboratory-1.svg" alt="实验室" title="医疗与实验室环境"></div>
            <div class="application-image"><img src="/images/usecases/environment-monitoring/agriculture-1.svg" alt="温室" title="农业与温室设施"></div>
            <div class="application-image"><img src="/images/usecases/environment-monitoring/education-1.svg" alt="学校" title="教育与研究机构"></div>
            <div class="application-image"><img src="/images/usecases/environment-monitoring/warehouse-1.svg" alt="仓库" title="仓库与冷库设施"></div>
        </div>
        <div class="text-row-bottom">
            <div class="text-block">
                <h3>医疗与实验室环境</h3>
                <p>在敏感医疗或实验区域跟踪空气质量、CO₂ 浓度和温度，维持无菌环境与通风。</p>
            </div>
            <div class="text-block">
                <h3>教育与研究机构</h3>
                <p>收集长期环境数据，用于科研、校园可持续项目及环境学科教学。</p>
            </div>
        </div>
    </div>
    <div class="applications-container-small">
        <div class="application-block">
            <div class="image"><img src="/images/usecases/environment-monitoring/smart-cities-2.svg" alt="智慧城市" title="智慧城市与城市基础设施"></div>
            <div class="text-block">
                <h3>智慧城市与城市基础设施</h3>
                <p>监测城市各区域的空气质量、噪音、温湿度，支持环境政策、居民预警和改善城市居住条件。</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>医疗与实验室环境</h3>
                <p>在敏感医疗或实验区域跟踪空气质量、CO₂ 浓度和温度，维持无菌环境与通风。</p>
            </div>
            <div class="image"><img src="/images/usecases/environment-monitoring/laboratory-2.svg" alt="实验室" title="医疗与实验室环境"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/environment-monitoring/agriculture-2.svg" alt="温室" title="农业与温室设施"></div>
            <div class="text-block">
                <h3>农业与温室设施</h3>
                <p>根据占用情况控制教室、实验室和宿舍的能耗，安排能源使用并确保达成可持续目标。</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>教育与研究机构</h3>
                <p>收集长期环境数据，用于科研、校园可持续项目及环境学科教学。</p>
            </div>
            <div class="image"><img src="/images/usecases/environment-monitoring/education-2.svg" alt="学校" title="教育与研究机构"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/environment-monitoring/warehouse-2.svg" alt="仓库" title="仓库与冷库设施"></div>
            <div class="text-block">
                <h3>仓库与冷库设施</h3>
                <p>监测温湿度及空气循环，确保易腐品和药品的存储条件适宜。</p>
            </div>
        </div>
    </div>
</section>


<section class="summary">
    <div class="summary-text">
        <h2>环境监测总结</h2>
        <p>以下交互式仪表板代表环境监测组件，可轻松嵌入您的物联网解决方案。该仪表板支持用户监测温湿度传感器，并可快速适配空气质量或其他传感器及远程控制场景。</p>
    </div>
    <div class="summary-icon">
        <img src="/images/usecases/health-care/summary.svg" alt="文本总结图标" title="文本总结图标">
    </div>
</section>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.card-link').forEach((link) => {
            link.classList.add('linkDefault');
        });

        const expansionBlocks = document.querySelectorAll('.expansion-block');
        const structureBlock = document.querySelector('.dashboard-structure-block');
        const smallImageBlock = createImageBlock('small');
        const largeImageBlock = createImageBlock('large');

        expansionBlocks[0].appendChild(smallImageBlock);
        structureBlock.appendChild(largeImageBlock);

        const largeImageElement = document.querySelector('.image-block-large > .image-container > .image');
        const smallImageElement = document.querySelector('.image-block-small > .image-container > .image');

        let currentExpandedIndex = 0;

        expansionBlocks[0].classList.add('expanded');

        expansionBlocks.forEach((panel, index) => {
            panel.addEventListener('click', function() {
                if (index === currentExpandedIndex) {
                    return; 
                }

                smallImageElement.innerHTML = getImage(index);
                this.appendChild(smallImageBlock);
                largeImageElement.style.height = largeImageElement.firstChild.getBoundingClientRect().height + 'px';
                largeImageElement.innerHTML = getImage(index);

                expansionBlocks.forEach(item => {
                    item.classList.remove('expanded');
                });

                this.classList.add('expanded');
                currentExpandedIndex = index; 
                if (window.screen.width < 600) {
                    const blockRect = expansionBlocks[index].getBoundingClientRect();
                    const target = blockRect.top + window.scrollY - 80;
                    window.scrollTo(0, target);
                    setTimeout(()=> document.getElementById("nav").style.top = "-78px");
                }
                if (index === 4) {
                    window.scrollTo(0, window.scrollY +1);
                }
            });
        });

        window.onscroll = function() {
            const elemCoor = document.querySelector('.dashboard-structure').getBoundingClientRect();
            const large = document.querySelector('.image-block-large');

            if (Math.abs(elemCoor.top) < elemCoor.height / 2 - 400 && elemCoor.top < 0) {
                large.style.marginTop = Math.abs(elemCoor.top) + 20 + 'px';
            }
        };

        if (window.screen.width > 960) {
            const fullPage = document.querySelector('#scada-fullpage');
            largeImageElement.addEventListener('click', function(image) {
                fullPage.children[0].innerHTML = `<img src=${image.currentTarget.children[0].src} />`;
                fullPage.style.display = 'block';
                fullPage.style.top = window.scrollY + 'px';
                document.querySelector('body').style.overflow = 'hidden';
            });
        }

        function createImageBlock(layout) {
            let block = document.createElement('div');
            block.className = `image-block-${layout}`;
            block.innerHTML = `
            <div class="image-container image-background">
                <div class="image-background"></div>
                <div class="image-background"></div>
                <div class="image-background"></div>
                <div class=image>${getImage(0)}</div>
            </div>
            <div class="buttons-block">
                <a id="UseCases_EnvMon_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/dfaef940-8a91-11ec-83d0-83ba2015b874?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button gtm_button">查看实时演示</a>
                <a id="UseCases_EnvMon_ContactUs" target="_blank" href="/docs/contact-us/?subject=Custom%20Development" class="button contact-us gtm_button">联系我们</a>
            </div>`;
    
            return block;
        }

        function getImage(index) {
            const images = [
                "<img src='/images/usecases/environment-monitoring/environment-monitoring-2.webp' alt='包含传感器状态、严重告警和地图位置的仪表板' title='ThingsBoard 仪表板展示传感器实时指标、告警状态和地理位置'/>",
                "<img src='/images/usecases/environment-monitoring/environment-monitoring-3.webp' alt='传感器 C1 的温湿度图表及位置' title='传感器 C1 实时监测：温湿度数据及地图上的传感器位置'/>",
                "<img src='/images/usecases/environment-monitoring/environment-monitoring-4.webp' alt='传感器 T1 的温湿度图表及位置' title='传感器 T1 实时读数：温湿度图表及地图标记'/>",
                "<img src='/images/usecases/environment-monitoring/environment-monitoring-1.webp' alt='ThingsBoard 中带阈值和地图位置的传感器配置面板' title='编辑传感器 T1：设置温湿度阈值并查看地图上的传感器位置'/>",
            ];
            return images[index];
        }
    });
</script>