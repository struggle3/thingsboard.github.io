---
layout: use-case
title: 城市与工业空气监测的物联网与仪表板方案
description: 使用 ThingsBoard 实时监测、分析并响应空气质量——面向城市、工业和研究的灵活物联网平台。
notitle: "true"
customTitle: "true"
includeAdvantages: "true"
contactUsModal: "true"

---

{% include usecase-nav.html usecase="air-quality-monitoring" %}

<div id="scada-fullpage" onclick="this.style.display='none'; document.body.style.overflow='unset'"><div class="image"></div><div class="close-icon"><svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M25.3337 8.5465L23.4537 6.6665L16.0003 14.1198L8.54699 6.6665L6.66699 8.5465L14.1203 15.9998L6.66699 23.4532L8.54699 25.3332L16.0003 17.8798L23.4537 25.3332L25.3337 23.4532L17.8803 15.9998L25.3337 8.5465Z"></path></svg></div></div>
<h1 class="usecase-title">空气质量监测解决方案</h1>
<section class="air-quality-about">
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">城市区域、工业区和交通繁忙区持续面临空气污染——这是影响公众健康和法规合规的关键问题。从细颗粒物（PM2.5、PM10）到 SO₂、CO 等有害气体，监测这些环境威胁需要强大且响应迅速的系统。ThingsBoard 以无与伦比的灵活性和可靠性应对这一挑战。</p>
            </div>
            <div class="demo-button">
                <a id="UseCases_AirQM_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/ec564620-82b2-11ed-a624-8360a2a6cb0e?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button gtm_button">查看实时演示</a>            
            </div>
        </div>
        <div class="long">
            <p>ThingsBoard 物联网平台专为应对此挑战而设计，具备可扩展架构、多协议支持（MQTT、HTTP、CoAP、LwM2M）和强大的规则引擎。它无缝连接分布式空气质量传感器，确保安全可靠的数据采集，并在大型部署中实现实时分析和告警。</p>
            <p>凭借可定制的仪表板、灵活的数据可视化工具和低代码规则配置，ThingsBoard 帮助组织更快部署空气质量监测系统、高效管理并主动响应环境变化。无论是智慧城市、工业合规还是社区健康倡议，ThingsBoard 都提供掌控空气质量所需的性能和适应性。</p>
        </div>
    </div>
</section>

<section class="air-quality-carousel carousel-padding">
    {% include default-carousel.liquid collectionMap = 'use-cases' collectionKey = 'air-quality-monitoring' %}
</section> 

{% include contact-us-banner.liquid %}

<section class="air-quality-solution-structure">
    <h2>空气质量监测解决方案结构</h2>
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">ThingsBoard 驱动的<a href="/docs/pe/solution-templates/air-quality-monitoring/">空气质量监测解决方案</a>由采集 PM2.5、PM10、CO、SO₂、NO₂ 和 O₃ 等污染物实时数据的物联网传感器组成。这些设备通过 MQTT、HTTP/HTTPS、CoAP 和 LwM2M 等行业标准通信协议向平台传输遥测数据——实现跨行业灵活集成。</p>
            </div>
        </div>
        <div class="long">
            <p>数据在 ThingsBoard 接收后，经处理存入时序数据库，并通过交互式仪表板可视化。自定义规则链在 AQI 超过阈值或传感器电量降至临界以下时触发自动告警。</p>
        </div>
    </div>
    <div class="scheme">
        <img id="schemeSVG" loading="lazy" data-src="/images/usecases/smart-use-cases.svg" class="svg-animation" alt="智慧能源解决方案架构" title="智慧能源解决方案架构：物联网设备通过网关连接至云平台进行数据处理、可视化和自动化">
    </div>
</section>

<section class="dashboard-structure section-padding">
    <div class="section-header">
        <h2>空气质量监测仪表板结构</h2>
        <p>
            ThingsBoard 中的空气质量监测解决方案采用模块化仪表板结构，兼顾公共与管理需求。每个仪表板 由可配置部件、实时数据流、地图叠加层和交互式筛选器组成，均依托 ThingsBoard 灵活的仪表板引擎。
        </p>
    </div>
    <div class="dashboard-structure-block">
        <div class="menu">
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>公共仪表板：全市 AQI 地图状态</h3>
                    </div>
                    <div class="expansion-content">
                        <p>显示所有传感器位置及实时 AQI 值。彩色标记按 EPA 标准反映污染等级。点击位置可查看其历史 AQI 趋势。该界面让用户（市民和城市官员）轻松获取数据，实现透明决策。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>颗粒物洞察：PM10、PM2.5 等</h3>
                    </div>
                    <div class="expansion-content">
                        <p>详细弹窗包含污染物专属图表、当前和平均水平及健康影响说明。这些洞察让环境分析师能够评估全天污染物行为。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>仪表板列表：访问管理</h3>
                    </div>
                    <div class="expansion-content">
                        <p>显示所有可用仪表板：公共仪表板供一般查看，管理仪表板用于传感器配置。访问分离确保运营控制的同时保持公共透明度。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>管理仪表板：传感器状态与地图概览</h3>
                    </div>
                    <div class="expansion-content">
                        <p>管理面板显示传感器连接状态、电量、最新 AQI 读数和地理位置。便于快速识别传感器问题或局部空气质量异常。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>传感器详情视图</h3>
                    </div>
                    <div class="expansion-content">
                        <p>显示各污染物实时值、电量趋势、历史连接状态及地图位置。支持深度技术分析和特定传感器性能验证。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>添加传感器界面</h3>
                    </div>
                    <div class="expansion-content">
                        <p>简洁表单用于注册新传感器，包含 ID、标签和坐标。支持在无需开发的情况下快速扩展网络。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>告警规则配置</h3>
                    </div>
                    <div class="expansion-content">
                        <p>规则编辑器可根据电量或连接丢失触发告警。实现主动维护并长期保证数据可靠性。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="applications applications-additional summary-margin section-padding">
    <div class="section-header">
        <h2>空气质量监测的应用场景</h2>
        <p>依托 ThingsBoard 的空气质量监测系统等物联网解决方案，可应用于空气质量影响健康、安全或合规的各类行业。其灵活性与实时分析能力使其价值远超环境类用例。以下是主要应用领域：</p>
    </div>
    <div class="applications-container-large">
        <div class="text-row-top">
            <div class="text-block">
                <h3>智慧城市</h3>
                <p>ThingsBoard 帮助城市管理部门部署可扩展的传感器网络并实现空气质量告警自动化，实时保护公众健康并落实清洁空气法规。</p>
            </div>
            <div class="text-block">
                <h3>运输与物流</h3>
                <p>通过透明的使用跟踪，让业主和租户能够监测并降低能源费用。</p>
            </div>
            <div class="text-block">
                <h3>Real estate development</h3>
                <p>开发商利用 ThingsBoard 的远程监测、公共仪表板和数据分析，将空气质量指标作为生态友好型房产的卖点。</p>
            </div>
        </div>
        <div class="images-row">
            <div class="application-image"><img src="/images/usecases/air-quality/cities-1.svg" alt="智慧城市" title="智慧城市"></div>
            <div class="application-image"><img src="/images/usecases/air-quality/industrial-1.svg" alt="工业园区" title="工业园区"></div>
            <div class="application-image"><img src="/images/usecases/air-quality/logistics-1.svg" alt="运输与物流" title="运输与物流"></div>
            <div class="application-image"><img src="/images/usecases/air-quality/education-1.svg" alt="教育与研究" title="教育与研究"></div>
            <div class="application-image"><img src="/images/usecases/air-quality/development-1.svg" alt="房地产开发" title="房地产开发"></div>
        </div>
        <div class="text-row-bottom">
            <div class="text-block">
                <h3>工业园区</h3>
                <p>制造商通过 ThingsBoard 的可定制仪表板和基于规则的自动化监测排放，确保法规合规并降低环境风险。</p>
            </div>
            <div class="text-block">
                <h3>教育与研究</h3>
                <p>高校和研究机构利用 ThingsBoard 的实时数据可视化和开放 API，将环境数据融入课程、科研项目和公民科学倡议。</p>
            </div>
        </div>
    </div>
    <div class="applications-container-small">
        <div class="application-block">
            <div class="image"><img src="/images/usecases/air-quality/cities-2.svg" alt="智慧城市" title="智慧城市"></div>
            <div class="text-block">
                <h3>智慧城市</h3>
                <p>ThingsBoard 帮助城市管理部门部署可扩展的传感器网络并实现空气质量告警自动化，实时保护公众健康并落实清洁空气法规。</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>工业园区</h3>
                <p>制造商通过 ThingsBoard 的可定制仪表板和基于规则的自动化监测排放，确保法规合规并降低环境风险。</p>
            </div>
            <div class="image"><img src="/images/usecases/air-quality/industrial-2.svg" alt="工业园区" title="工业园区"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/air-quality/logistics-2.svg" alt="运输与物流" title="运输与物流"></div>
            <div class="text-block">
                <h3>运输与物流</h3>
                <p>通过透明的使用跟踪，让业主和租户能够监测并降低能源费用。</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>教育与研究</h3>
                <p>高校和研究机构利用 ThingsBoard 的实时数据可视化和开放 API，将环境数据融入课程、科研项目和公民科学倡议。</p>
            </div>
            <div class="image"><img src="/images/usecases/air-quality/education-2.svg" alt="教育与研究" title="教育与研究"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/air-quality/development-2.svg" alt="房地产开发" title="房地产开发"></div>
            <div class="text-block">
                <h3>Real estate development</h3>
                <p>开发商利用 ThingsBoard 的远程监测、公共仪表板和数据分析，将空气质量指标作为生态友好型房产的卖点。</p>
            </div>
        </div>
    </div>
</section>

<section class="summary">
    <div class="summary-text">
        <h2>空气质量监测总结</h2>
        <p>ThingsBoard 的空气质量监测解决方案提供可扩展、实时的物联网环境智能平台。它将污染传感器与云仪表板、告警和数据存储相连，助力城市、企业和机构基于空气质量洞察采取行动。其灵活性、开放协议支持和可定制可视化使其成为公共卫生、法规合规和绿色倡议的理想选择。</p>
    </div>
    <div class="summary-icon">
        <img src="/images/usecases/health-care/summary.svg" alt="文本总结图标" title="文本总结图标">
    </div>
</section>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const svgAnimations = document.querySelectorAll(".svg-animation");
        const svgObserver = new IntersectionObserver((entries, obs) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.style.visibility = 'visible';
                    img.src = img.dataset.src;
                    obs.unobserve(img);
                }
            });
        }, {threshold: 1.0});

        svgAnimations.forEach(img => svgObserver.observe(img));

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

                applyImageBg(smallImageBlock);
                applyImageBg(largeImageBlock);

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

            if (Math.abs(elemCoor.top) < elemCoor.height / 2 - 300 && elemCoor.top < 0) {
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
                <a id="UseCases_AirQM_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/ec564620-82b2-11ed-a624-8360a2a6cb0e?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button gtm_button">查看实时演示</a>            
                <a id="UseCases_AirQM_ContactUs" target="_blank" href="/docs/contact-us/?subject=Custom%20Development" class="button contact-us gtm_button">联系我们</a>
            </div>`;

            applyImageBg(block);
    
            return block;
        }

        function applyImageBg(block) {
            const img = block.querySelector('.image img');
            const container = block.querySelector('.image-container');
            if (img && container) {
                const bg = img.dataset.bg;
                container.style.backgroundColor = bg || '';
            }
        }

        function getImage(index) {
            const images = [
                "<img src='/images/usecases/air-quality/aiq-1.webp' alt='ThingsBoard 物联网平台上的洛杉矶 AQI 热力图' title='通过 ThingsBoard 监测的洛杉矶 AQI 地图'/>",
                "<img src='/images/usecases/air-quality/aiq-2.webp' alt='ThingsBoard 仪表板上比弗利山庄的 PM10 空气质量实时数据' title='ThingsBoard 中显示的比弗利山庄 PM10 空气质量'/>",
                "<img src='/images/usecases/air-quality/aiq-3.webp' alt='ThingsBoard 中空气质量监测的物联网仪表板列表' title='在 ThingsBoard 中管理空气质量仪表板'/>",
                "<img src='/images/usecases/air-quality/aiq-4.webp' alt='ThingsBoard 地图仪表板上展示的物联网空气质量传感器与告警' title='ThingsBoard 中洛杉矶各地的实时空气质量传感器与告警'/>",
                "<img src='/images/usecases/air-quality/aiq-5.webp' alt='ThingsBoard 中比弗利山庄传感器数据（含 AQI 与电量）' title='比弗利山庄传感器数据——AQI、电量和状态'/>",
                "<img src='/images/usecases/air-quality/aiq-6.webp' data-bg='#A4A4A4' alt='ThingsBoard 中带 ID 和 GPS 字段的传感器注册表单' title='在 ThingsBoard 中创建新的空气质量传感器'/>",
                "<img src='/images/usecases/air-quality/aiq-7.webp' data-bg='#A4A4A4' alt='ThingsBoard 中配置物联网告警阈值的界面' title='配置传感器电量和连接相关的告警规则'/>"
            ];
            return images[index];
        }
    });
</script>
