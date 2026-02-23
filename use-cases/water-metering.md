---
layout: use-case
title: 基于 ThingsBoard 物联网平台的智能水表计量
description: 了解 ThingsBoard 如何通过可扩展的物联网水表计量解决方案为公用事业、建筑和农业实现实时水监测、自动化警报和用量分析。
notitle: "true"
customTitle: "true"
includeAdvantages: "true"
contactUsModal: "true"

---

{% include usecase-nav.html usecase="water-metering" %}

<div id="scada-fullpage" onclick="this.style.display='none'; document.body.style.overflow='unset'"><div class="image"></div><div class="close-icon"><svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M25.3337 8.5465L23.4537 6.6665L16.0003 14.1198L8.54699 6.6665L6.66699 8.5465L14.1203 15.9998L6.66699 23.4532L8.54699 25.3332L16.0003 17.8798L23.4537 25.3332L25.3337 23.4532L17.8803 15.9998L25.3337 8.5465Z"></path></svg></div></div>
<h1 class="usecase-title">水表计量</h1>
<section class="water-metering-about">
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">水是最关键资源之一，其分配与用量管理是可持续城市发展、公用事业成本控制和基础设施维护的核心。ThingsBoard 平台是理想之选，提供实时监测、告警、可视化和分析能力。</p>
            </div>
            <div class="demo-button">
                <a id="UseCases_WaterMeter_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/aff5f200-8b48-11ec-a344-c767c1ab1bb8?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button gtm_button">查看实时演示</a>            </div>
            </div>
        <div class="long">
            <p>传统水表计量方法往往难以及时提供数据、准确计费和预测性维护洞察。借助联网传感器和智能仪表板，企业可深入了解用水情况、检测漏损等异常并实现告警自动化。ThingsBoard 作为灵活的物联网平台，是这些解决方案的核心，支持实时收集、处理并可视化水表遥测数据。</p>
            <p>基于 ThingsBoard 的<a href="/docs/pe/solution-templates/water-metering/">水表计量解决方案</a>提供用水全程实时可见性、异常即时响应及长期基础设施规划分析。可扩展至市政、住宅和商业设施，为智慧高效的水资源管理提供强大工具。</p>
        </div>
    </div>
</section>

<section class="water-metering-carousel carousel-padding">
    {% include default-carousel.liquid collectionMap = 'use-cases' collectionKey = 'water-metering' %}
</section> 

{% include contact-us-banner.liquid %}

<section class="water-metering-solution-structure">
    <h2>水表计量用例解决方案结构</h2>
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">ThingsBoard 可与支持物联网的水表无缝集成，水表采集用量、温度和电量等实时数据，并通过 LoRaWAN、NB-IoT 和 LTE 等无线网络传输处理。</p>
            </div>
        </div>
        <div class="long">
            <p>平台存储数据、应用智能规则触发告警，并通过直观仪表板进行可视化，提供即时运营洞察。</p>
        </div>
    </div>
    <div class="scheme">
        <img id="schemeSVG" loading="lazy" data-src="/images/usecases/smart-use-cases-energy.svg" class="svg-animation" alt="Water metering solution architecture" title="Water metering solution architecture: IoT devices connect via gateways to the cloud for processing, visualization, and automation">
    </div>
</section>

<section class="dashboard-structure section-padding">
    <div class="section-header">
        <h2>水表计量解决方案仪表板结构</h2>
        <p>
            The ThingsBoard water metering dashboard is structured into dedicated states, each focusing on a key aspect of system monitoring, control, and analysis. Below is a breakdown of each state with its purpose and content:        
        </p>
    </div>
    <div class="dashboard-structure-block">
        <div class="menu">
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Total overview state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This view provides a real-time snapshot of system-wide metrics, such as total water consumed in the current week, active/inactive device counts, and any low battery alerts. An interactive map shows meter locations, while bar charts and alarm lists offer instant visibility into daily usage and critical threshold breaches.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Analytics state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>Designed for trend analysis, this state allows users to compare historical and current water consumption patterns over the week. It helps identify usage spikes or efficiency improvements by showing data from both the present and the previous intervals.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Devices state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This dashboard displays all registered water meters with essential metadata like latest readings, status, and leak detection. Users can manage device information, monitor their real-time performance, and quickly respond to technical issues. Additionally, this view allows users to add new devices by entering their serial number and metadata, edit existing device details, change geolocation parameters by dragging a map marker, and configure alarm thresholds for consumption, battery, or inactivity detection.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Customers state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>Each water meter is associated with a specific customer profile, allowing for individualized usage tracking and customer service. The dashboard enables administrators to add or update customer contact details and manage meter assignments.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Alarms state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This critical interface aggregates all triggered alarms with timestamps, originators, and severity levels. Operators can quickly acknowledge or dismiss alerts, ensuring rapid incident response and system reliability.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Settings state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>Here, administrators configure alarm thresholds (e.g., daily/weekly consumption, battery level) and notification preferences. The system supports both email and SMS alerts to ensure stakeholders are promptly informed.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Individual device dashboards</h3>
                    </div>
                    <div class="expansion-content">
                        <p>Each device has its own dedicated view showing granular consumption data by hour, daily/weekly totals, and battery health. It includes editable location mapping and detailed metadata, enabling localized control and diagnostics. Additionally, each dashboard displays device-specific contact information for the owner, facilitating support and communication, as well as a photo section that allows users to upload or update an image of the physical device for visual identification and verification.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Customer-specific dashboards</h3>
                    </div>
                    <div class="expansion-content">
                        <p>ThingsBoard provides individual dashboards tailored for end customers, allowing them to monitor only their assigned water meters. This ensures data privacy while empowering users with full visibility into their personal consumption, device status, and alert history.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Rule chains: data processing logic</h3>
                    </div>
                    <div class="expansion-content">
                        <p>The backend logic of the solution is driven by ThingsBoard rule chains, which handle incoming telemetry from devices and automate alarm routing, threshold checks, and notification dispatch. These visual flowcharts allow platform administrators to customize workflows based on device status, tenant or customer settings, and alarm types, ensuring flexibility and scalability of the solution.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="applications applications-additional summary-margin section-padding">
    <div class="section-header water-section-header">
        <h2>水表计量的应用：跨行业通用性</h2>
        <p>IoT-based water metering is not limited to utility companies. The same architecture and approach can be repurposed across a wide range of sectors:</p>
    </div>
    <div class="applications-container-large">
        <div class="text-row-top">
            <div class="text-block">
                <h3>Municipal water services</h3>
                <p>By using IoT-based water metering, municipalities can automate meter readings and billing processes, gain insight into consumption trends across entire cities, and react instantly to issues such as leaks or overuse.</p>
            </div>
            <div class="text-block">
                <h3>Smart buildings</h3>
                <p>Water metering in smart buildings enables facility managers to fine-tune plumbing infrastructure, minimize waste through real-time monitoring, and improve the overall experience and sustainability for occupants.</p>
            </div>
            <div class="text-block">
                <h3>Agriculture & irrigation</h3>
                <p>Farmers can leverage real-time data to optimize irrigation schedules, reduce unnecessary water usage, and improve crop yields while maintaining environmental responsibility.</p>
            </div>
        </div>
        <div class="images-row">
            <div class="application-image"><img src="/images/usecases/scada/water-1.svg" alt="Water valve" title="Water valve"></div>
            <div class="application-image"><img src="/images/usecases/water-metering/industrial-1.svg" alt="Industrial" title="Industrial facilities"></div>
            <div class="application-image"><img src="/images/usecases/water-metering/smart-building-1.svg" alt="Building" title="Smart buildings"></div>
            <div class="application-image"><img src="/images/usecases/smart-office/hospitality-1.svg" alt="Hospitality" title="Hospitality & resorts"></div>
            <div class="application-image"><img src="/images/usecases/water-metering/irrigation-1.svg" alt="Irrigation" title="Agriculture & irrigation"></div>
        </div>
        <div class="text-row-bottom">
            <div class="text-block">
                <h3>Industrial facilities</h3>
                <p>Industries benefit from accurate water monitoring to stay compliant with strict environmental standards and to manage utility costs more effectively through predictive consumption insights.</p>
            </div>
            <div class="text-block">
                <h3>Hospitality & resorts</h3>
                <p>Hotels and resorts can monitor water usage across various zones or guest areas to implement sustainable practices, reduce operating costs, and engage guests in eco-conscious initiatives.</p>
            </div>
        </div>
    </div>
    <div class="applications-container-small">
        <div class="application-block">
            <div class="image"><img src="/images/usecases/scada/water-2.svg" alt="Water valve" title="Water valve"></div>
            <div class="text-block">
                <h3>Municipal water services</h3>
                <p>By using IoT-based water metering, municipalities can automate meter readings and billing processes, gain insight into consumption trends across entire cities, and react instantly to issues such as leaks or overuse.</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>Industrial facilities</h3>
                <p>Industries benefit from accurate water monitoring to stay compliant with strict environmental standards and to manage utility costs more effectively through predictive consumption insights.</p>
            </div>
            <div class="image"><img src="/images/usecases/water-metering/industrial-2.svg" alt="Industrial" title="Industrial facilities"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/water-metering/smart-building-2.svg" alt="Building" title="Smart buildings"></div>
            <div class="text-block">
                <h3>Smart buildings</h3>
                <p>Water metering in smart buildings enables facility managers to fine-tune plumbing infrastructure, minimize waste through real-time monitoring, and improve the overall experience and sustainability for occupants.</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>Hospitality & resorts</h3>
                <p>Hotels and resorts can monitor water usage across various zones or guest areas to implement sustainable practices, reduce operating costs, and engage guests in eco-conscious initiatives.</p>
            </div>
            <div class="image"><img src="/images/usecases/smart-office/hospitality-2.svg" alt="Hospitality" title="Hospitality & resorts"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/water-metering/irrigation-2.svg" alt="Irrigation" title="Agriculture & irrigation"></div>
            <div class="text-block">
                <h3>Agriculture & irrigation</h3>
                <p>Farmers can leverage real-time data to optimize irrigation schedules, reduce unnecessary water usage, and improve crop yields while maintaining environmental responsibility.</p>
            </div>
        </div>
    </div>
</section>

<section class="summary">
    <div class="summary-text">
        <h2>水表计量解决方案总结</h2>
        <p>With a low-code approach, intuitive dashboards, and comprehensive alerting mechanisms, ThingsBoard serves as a cornerstone for digital transformation in water resource management. Whether you're scaling for a city or optimizing a single facility, this solution adapts to your needs— one drop at a time.</p>
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

            if (Math.abs(elemCoor.top) < elemCoor.height / 2 - 150 && elemCoor.top < 0) {
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
                <a id="UseCases_WaterMeter_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/aff5f200-8b48-11ec-a344-c767c1ab1bb8?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button gtm_button">查看实时演示</a>
                <a id="UseCases_WaterMeter_ContactUs" target="_blank" href="/docs/contact-us/?subject=Custom%20Development" class="button contact-us gtm_button">联系我们</a>
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
                "<img src='/images/usecases/water-metering/water-metering-1.webp' alt='IoT water monitoring dashboard with real-time meter data, consumption chart, and alert notifications' title='IoT-based smart water metering dashboard for real-time monitoring and consumption analytics'/>",
                "<img src='/images/usecases/water-metering/water-metering-2.webp' alt='hingsBoard IoT dashboard for water metering with real-time consumption graph, smart devices, and meter analytics' title='Smart water consumption tracking with ThingsBoard IoT platform — daily usage trends, device status, and meter readings'/>",
                "<img src='/images/usecases/water-metering/water-metering-6.webp' alt='ThingsBoard interface for editing smart water meter device details with active alerts and status overview' title='Edit IoT water meter device information and monitor active consumption alarms in ThingsBoard' data-bg='#A4A4A4'/>",
                "<img src='/images/usecases/water-metering/water-metering-7.webp' alt='ThingsBoard customer management interface displaying smart water metering clients with contact details' title='Manage smart water metering customers in ThingsBoard with email, address, and contact information'/>",
                "<img src='/images/usecases/water-metering/water-metering-4.webp' alt='IoT water metering dashboard with critical alerts for exceeded consumption thresholds and real-time device data in ThingsBoard' title='ThingsBoard IoT platform showing critical smart meter alerts and active status of water monitoring devices'/>",
                "<img src='/images/usecases/water-metering/water-metering-5.webp' alt='hingsBoard alarm configuration panel showing system thresholds and email or SMS notification settings' title='Configure smart alarm thresholds and notification channels in ThingsBoard IoT platform'/>",
                "<img src='/images/usecases/water-metering/water-metering-3.webp' alt='Detailed IoT water meter monitoring on ThingsBoard dashboard with usage graph, location map, alerts, and installation info' title='ThingsBoard smart metering dashboard showing real-time water usage, device alerts, and geolocation tracking'/>",
                "<img src='/images/usecases/water-metering/water-metering-8.webp' alt='ThingsBoard dashboard with water meter consumption data, leakage indicators, and active customer alarms' title='Monitor water meter status and customer-specific consumption alerts in ThingsBoard IoT platform'/>",
                "<img src='/images/usecases/water-metering/water-metering-9.webp' alt='ThingsBoard rule chain flow diagram for water consumption processing and alarm generation' title='IoT rule chain in ThingsBoard for calculating consumption, managing alarms, and posting telemetry'/>"
            ];
            return images[index];
        }
    });
</script>

