---
layout: use-case
title: 基于 ThingsBoard 的物联网能源管理与监测
description: 基于 ThingsBoard 物联网平台的智慧能源方案支持实时能源监测与优化，助力降本增效、提升能效、自动化管理并实现可持续发展。
notitle: "true"
customTitle: "true"
includeAdvantages: "true"
contactUsModal: "true"

---

{% include usecase-nav.html usecase="smart-energy" %}
<div id="scada-fullpage" onclick="this.style.display='none'; document.body.style.overflow='unset'"><div class="image"></div><div class="close-icon"><svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M25.3337 8.5465L23.4537 6.6665L16.0003 14.1198L8.54699 6.6665L6.66699 8.5465L14.1203 15.9998L6.66699 23.4532L8.54699 25.3332L16.0003 17.8798L23.4537 25.3332L25.3337 23.4532L17.8803 15.9998L25.3337 8.5465Z"></path></svg></div></div>
<h1 class="usecase-title">智慧能源</h1>
<section class="environment-monitoring-about">
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">智慧能源是借助物联网实现能效提升、成本降低与流程自动化的智能能源资源管理。ThingsBoard 为此类场景提供可扩展的数据采集、分析与实时远程控制，是理想平台。</p>
            </div>
            <div class="demo-button">
                <a id="UseCases_SmartEnergy_ViewLiveDemo" target="_blank" href="https://demo.thingsboard.io/dashboard/e8e409c0-f2b5-11e6-a6ee-bb0136cc33d0?publicId=963ab470-34c9-11e7-a7ce-bb0136cc33d0" class="button gtm_button">查看在线演示</a>            </div>
            </div>
        <div class="long">
            <p>物联网正在深刻改变能源管理方式。物联网传感器采集电、水、热消耗以及压力、温度等环境参数，用于自动决策——从故障时关闭系统到优化用能、防止损耗。</p>
            <p>ThingsBoard 平台为构建此类系统提供完整技术栈，支持多种设备与协议（MQTT、CoAP、HTTP 等）的数据采集、仪表板可视化，以及通过规则引擎与告警系统实现的高级自动化，从而实现实时能源监测与异常快速响应，降低成本并提升运营效率。</p>
        </div>
    </div>
</section>

<section class="smart-energy-overview">
    <div class="img-comp-container">
        <div class="img-comp-img">
            <img class="traditional-background" src="/images/usecases/smart-energy/smart-energy-1.webp" alt="ThingsBoard dashboard in light theme showing energy data from smart meters" title="Smart energy monitoring dashboard in light mode: real-time voltage, amperage, consumption, and critical alarms for three smart meters">
        </div>
        <div class="img-comp-img img-comp-overlay">
            <img class="traditional-background" src="/images/usecases/smart-energy/smart-energy-2.webp" alt="ThingsBoard dashboard in dark theme with smart meter data visualization" title="Smart energy monitoring in dark mode: ThingsBoard interface displaying real-time metrics and alarm conditions">
        </div>
    </div>
</section>

{% include contact-us-banner.liquid %}

<section class="smart-energy-solution-structure">
    <h2>智慧能源应用场景的解决方案架构</h2>
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">ThingsBoard 提供基于模块化、可扩展架构的完整物联网能源监测方案。在设备层，智能电表与工业 Modbus 电表采集各设施的实时能耗数据。</p>
            </div>
        </div>
        <div class="long">
            <p>这些设备通过支持 MQTT、CoAP、HTTP、LwM2M 等多种通信协议的物联网网关连接，实现安全、无缝的数据上云。</p>
            <p>ThingsBoard 核心负责设备与用户管理、通过强大规则引擎的实时数据处理。采集的数据通过直观的仪表板与移动应用呈现，使用户可在一个界面中实时掌握用能、系统告警与性能指标。</p>
        </div>
    </div>
    <div class="scheme">
        <img id="schemeSVG" loading="lazy" data-src="/images/usecases/smart-use-cases.svg" class="svg-animation" alt="Smart energy solution architecture" title="Smart energy solution architecture: IoT devices connect via gateways to the cloud for processing, visualization, and automation">
    </div>
    <div class="smart-energy-benefits section-padding">
        <div class="section-header">
            <h2>Smart energy benefits</h2>
            <p>The smart energy solution provides a wide range of benefits for businesses, facility managers, and technical teams, enabling efficient, automated, and scalable energy management.</p>
        </div>
        <div class="use-cases-solution-structure-cards">
            <div class="use-cases-solution-structure-card">
                <h3>Failure detection and risk mitigation</h3>
                <p>Real-time monitoring detects unusual patterns that may signal potential system failures, helping reduce risks and prevent downtime.</p>
            </div>
            <div class="use-cases-solution-structure-card">
                <h3>Dynamic energy optimization</h3>
                <p>IoT-powered energy systems automatically adjust consumption based on time of day, weather, or pricing factors, improving efficiency and occupant comfort.</p>
            </div>
            <div class="use-cases-solution-structure-card">
                <h3>Centralized monitoring and control</h3>
                <p>A unified platform enables centralized oversight of energy usage across multiple facilities, simplifying management and enhancing visibility.</p>
            </div>
            <div class="use-cases-solution-structure-card">
                <h3>Increased energy efficiency</h3>
                <p>IoT sensors track detailed consumption patterns by device or system, allowing identification of inefficiencies and driving smarter energy use.</p>
            </div>
            <div class="use-cases-solution-structure-card">
                <h3>Sustainability and cost savings</h3>
                <p>Continuous monitoring and automation help reduce operational costs and maintenance needs, supporting long-term sustainability goals.</p>
            </div>
            <div class="use-cases-solution-structure-card">
                <h3>Regulatory compliance</h3>
                <p>Automated tracking and reporting features make it easier to meet energy regulations and environmental standards.</p>
            </div>
        </div>
    </div>
</section>

<section class="dashboard-structure section-padding">
    <div class="section-header">
        <h2>Dashboard structure of smart energy solution</h2>
        <p>
            The live dashboard displays real-time data from several smart meters collected using ThingsBoard MQTT API. Collected data is processed via the rule engine to raise alarms on certain thresholds. The main dashboard displays the energy meters, corresponding alarms, and real-time data feeds. Click on the alarm or energy meter row to open the meter details. You may export the dashboard from our live demo server and import it to your ThingsBoard instance.    
        </p>
    </div>
    <div class="dashboard-structure-block">
        <div class="menu">
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Smart energy state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This unified dashboard provides a comprehensive real-time view of voltage, amperage, frequency, and energy consumption across all three floors. Operators can monitor Smart Meters A, B, and C, analyze, compare performance, and detect anomalies instantly. Alarm widgets notify users about critical events like low or high voltage, while interactive charts and tables offer full control and insight — all from a single interface.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Smart Meter A — 1st Floor state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This dashboard provides full visibility into voltage, frequency, amperage, and energy consumption for Smart Meter A. Real-time charts help detect instability in power supply, while a historical consumption graph supports weekly analysis. The frequency dip and critical high-voltage alarm enable timely diagnostics and response.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Smart Meter B — 2nd Floor state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This dashboard provides full visibility into voltage, frequency, amperage, and energy consumption for Smart Meter B. Real-time charts help detect instability in power supply, while a historical consumption graph supports weekly analysis. The frequency dip and critical high-voltage alarm enable timely diagnostics and response.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Smart Meter C — 3rd Floor state</h3>
                    </div>
                    <div class="expansion-content">
                        <p>This dashboard provides full visibility into voltage, frequency, amperage, and energy consumption for Smart Meter C. Real-time charts help detect instability in power supply, while a historical consumption graph supports weekly analysis. The frequency dip and critical high-voltage alarm enable timely diagnostics and response.</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>Theme toggle mode</h3>
                    </div>
                    <div class="expansion-content">
                        <p>With a single click on the theme icon in the top right corner, users can switch between light and dark modes. This flexibility enhances user comfort in various lighting conditions, improves focus, and reduces eye strain — especially during night shifts or long monitoring sessions. The dark theme preserves full dashboard functionality, including charts, alerts, and controls.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="applications applications-additional section-padding">
    <div class="section-header">
        <h2>Applications of smart energy solution</h2>
        <p>A scalable IoT-based energy monitoring and management system can be adapted for a wide range of industries and infrastructure types. Below are just a few examples of where smart energy solutions can be applied.</p>
    </div>
    <div class="applications-container-large">
        <div class="text-row-top">
            <div class="text-block">
                <h3>Industrial facilities and factories</h3>
                <p>Tracking energy usage of heavy machinery, identifying inefficiencies, and improving power distribution for safer and more cost-effective production processes.</p>
            </div>
            <div class="text-block">
                <h3>Educational institutions and campuses</h3>
                <p>Controlling power consumption in classrooms, labs, and dormitories, scheduling energy use based on occupancy, and ensuring sustainability targets are met.</p>
            </div>
            <div class="text-block">
                <h3>Shopping malls and retail chains</h3>
                <p>Monitoring temperature, humidity, and air circulation to ensure proper storage conditions for perishable goods and pharmaceutical products.</p>
            </div>
        </div>
        <div class="images-row">
            <div class="application-image"><img src="/images/usecases/smart-energy/factory-1.svg" alt="Factory" title="Industrial facilities and factories"></div>
            <div class="application-image"><img src="/images/usecases/smart-energy/buildings-1.svg" alt="Buildings" title="Commercial buildings and offices"></div>
            <div class="application-image"><img src="/images/usecases/smart-energy/education-1.svg" alt="School" title="Educational institutions and campuses"></div>
            <div class="application-image"><img src="/images/usecases/smart-energy/data-centers-1.svg" alt="Data centers" title="Data centers"></div>
            <div class="application-image"><img src="/images/usecases/smart-energy/malls-1.svg" alt="Mall" title="Shopping malls and retail chains"></div>
        </div>
        <div class="text-row-bottom">
            <div class="text-block">
                <h3>Commercial buildings and offices</h3>
                <p>Optimizing HVAC, lighting, and equipment usage across floors and departments, with real-time monitoring to reduce energy waste and operational costs.</p>
            </div>
            <div class="text-block">
                <h3>Data centers</h3>
                <p>Maintaining stable voltage, temperature, and load balancing to ensure uninterrupted operations while reducing electricity consumption and cooling costs.</p>
            </div>
        </div>
    </div>
    <div class="applications-container-small">
        <div class="application-block">
            <div class="image"><img src="/images/usecases/smart-energy/factory-2.svg" alt="Factory" title="Industrial facilities and factories"></div>
            <div class="text-block">
                <h3>Industrial facilities and factories</h3>
                <p>Tracking energy usage of heavy machinery, identifying inefficiencies, and improving power distribution for safer and more cost-effective production processes.</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>Commercial buildings and offices</h3>
                <p>Optimizing HVAC, lighting, and equipment usage across floors and departments, with real-time monitoring to reduce energy waste and operational costs.</p>
            </div>
            <div class="image"><img src="/images/usecases/smart-energy/buildings-2.svg" alt="Buildings" title="Commercial buildings and offices"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/smart-energy/education-2.svg" alt="School" title="Educational institutions and campuses"></div>
            <div class="text-block">
                <h3>Educational institutions and campuses</h3>
                <p>Controlling power consumption in classrooms, labs, and dormitories, scheduling energy use based on occupancy, and ensuring sustainability targets are met.</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>Data centers</h3>
                <p>Maintaining stable voltage, temperature, and load balancing to ensure uninterrupted operations while reducing electricity consumption and cooling costs.</p>
            </div>
            <div class="image"><img src="/images/usecases/smart-energy/data-centers-2.svg" alt="Data centers" title="Data centers"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/smart-energy/malls-2.svg" alt="Mall" title="Shopping malls and retail chains"></div>
            <div class="text-block">
                <h3>Shopping malls and retail chains</h3>
                <p>Monitoring energy usage across multiple locations, managing peak hours, and controlling lighting and HVAC systems automatically for higher efficiency.</p>
            </div>
        </div>
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
                <a id="UseCases_SmartEnergy_ViewLiveDemo" target="_blank" href="https://demo.thingsboard.io/dashboard/e8e409c0-f2b5-11e6-a6ee-bb0136cc33d0?publicId=963ab470-34c9-11e7-a7ce-bb0136cc33d0" class="button gtm_button">View live demo</a>
                <a id="UseCases_SmartEnergy_ContactUs" target="_blank" href="/docs/contact-us/?subject=Custom%20Development" class="button contact-us gtm_button">Contact us</a>
            </div>`;
    
            return block;
        }

        function getImage(index) {
            const images = [
                "<img src='/images/usecases/smart-energy/smart-energy-1.webp' alt='ThingsBoard dashboard in light theme showing energy data from smart meters' title='Smart energy monitoring dashboard in light mode: real-time voltage, amperage, consumption, and critical alarms for three smart meters'/>",
                "<img src='/images/usecases/smart-energy/smart-energy-3.webp' alt='Smart Meter A dashboard on the 1st floor showing voltage, frequency, amperage, and energy consumption' title='Smart Meter A on the 1st floor: real-time monitoring of voltage, frequency, current and weekly energy usage with one active high voltage alarm'/>",
                "<img src='/images/usecases/smart-energy/smart-energy-4.webp' alt='Smart Meter B dashboard on the 2nd floor with energy data and real-time frequency' title='Smart Meter B on the 2nd floor: displays live voltage, frequency, amperage and energy consumption. No active alarms detected'/>",
                "<img src='/images/usecases/smart-energy/smart-energy-5.webp' alt='Smart Meter C dashboard on the 3rd floor showing real-time energy metrics and critical alarm' title='Smart Meter C on the 3rd floor: visualization of voltage, frequency, current and consumption, with one unacknowledged low voltage alarm'/>",
                "<img src='/images/usecases/smart-energy/smart-energy-2.webp' alt='ThingsBoard dashboard in dark theme with smart meter data visualization' title='Smart energy monitoring in dark mode: ThingsBoard interface displaying real-time metrics and alarm conditions'/>",
            ];
            return images[index];
        }
    });
</script>