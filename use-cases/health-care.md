---
layout: use-case
title: 医疗健康
description: 健康监测
notitle: "true"
includeAdvantages: "true"
contactUsModal: "true"

---

{% include usecase-nav.html usecase="health-care" %}
<div id="scada-fullpage" onclick="this.style.display='none'; document.body.style.overflow='unset'"><div class="image"></div><div class="close-icon"><svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M25.3337 8.5465L23.4537 6.6665L16.0003 14.1198L8.54699 6.6665L6.66699 8.5465L14.1203 15.9998L6.66699 23.4532L8.54699 25.3332L16.0003 17.8798L23.4537 25.3332L25.3337 23.4532L17.8803 15.9998L25.3337 8.5465Z"></path></svg></div></div>
<h1 class="usecase-title">医疗健康：智慧辅助生活解决方案</h1>

<section class="health-about">
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">ThingsBoard 是一个物联网平台，具备构建全面医疗健康监测与管理系统所需的所有工具。ThingsBoard 提供丰富的内置功能以及灵活的定制选项。</p>
            </div>
            <div class="demo-button">
                <a id="UseCases_HealthCare_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/f8e77210-8fa8-11ef-90c1-0b39f28da380?publicId=7aa99e80-8acd-11ef-a59e-a9c993dbec14" class="button gtm_button">查看实时演示</a>
            </div>
        </div>
        <div class="long">
            <p>医疗健康监测系统旨在实时跟踪患者健康指标，并在关键变化发生时立即通知医护人员。ThingsBoard 作为强大的物联网平台，为从使用 BLE 或 LoRaWAN 网关协议的设备收集、处理和可视化数据提供所有必要工具，实现无缝集成并支持灵活解决方案。</p>
            <p>我们基于 ThingsBoard 的智慧辅助生活解决方案，为辅助生活机构的住客提供实时健康监测与管理。 借助 ThingsBoard 强大的物联网能力，该解决方案整合互联设备、数据分析和自动化警报，为护理人员和管理者创建无缝体验，确保及时响应和更高护理质量。</p>
        </div>
    </div>
</section>

<section class="health-carousel">
    {% include default-carousel.liquid collectionMap = 'use-cases' collectionKey = 'health-care' %}
</section> 

{% include contact-us-banner.liquid %}

<section class="health-solution-structure addedBanner">
    <h2>解决方案结构</h2>
    <div class="about-text">
        <div class="short">
            <div class="block">
                <p class="text">该解决方案设计用于 BLE（低功耗蓝牙）或 LoRaWAN 网关和设备。房间可配备多种传感器，如室内温度、湿度、室内空气质量（IAQ）、漏水、烟雾和开关门探测器。</p>
            </div>
        </div>
        <div class="long">
            <p>住客的地理定位通过腕带中的信标和一组附近网关实现。平台对来自信标的传入消息进行去重，并使用附近网关的属性对其进行丰富。地理定位算法相对简单，基于有效载荷的 RSSI 参数。可根据具体用例改进算法。</p>
        </div>
    </div>
    <div class="scheme">
        <img id="schemeSVG"  loading="lazy" data-src="/images/usecases/health-care/health-care-solution-structure.svg" alt="医疗健康解决方案结构">
    </div>
</section>
<section class="health-solution-structure">
    <h2>智慧辅助生活优势</h2>
    <p>智慧辅助生活解决方案为护理提供方、住客和机构管理人员带来诸多优势，支持辅助生活机构的安全高效管理：</p>
    <div class="health-solution-structure-cards">
        <div class="health-solution-structure-card">
            <h3>高效监测与响应</h3>
            <p>支持实时跟踪住客健康和环境状况，让护理人员能够及时响应紧急情况。</p>
        </div>
        <div class="health-solution-structure-card">
            <h3>自动化警报与通知</h3>
            <p>可配置的警报确保护理人员和家属及时获知潜在健康风险，减少响应延迟。</p>
        </div>
        <div class="health-solution-structure-card">
            <h3>个性化护理方案</h3>
            <p>可定制的警报规则和完善的健康档案使机构能够根据每位住客需求提供定制护理，提升护理质量。</p>
        </div>
        <div class="health-solution-structure-card">
            <h3>增强安全与舒适</h3>
            <p>环境监测保持最佳房间条件，最大程度降低温湿度或噪音波动带来的风险。</p>
        </div>
        <div class="health-solution-structure-card">
            <h3>数据驱动洞察</h3>
            <p>收集每位住客的历史健康数据，支持趋势分析和慢性病的主动管理。</p>
        </div>
        <div class="health-solution-structure-card">
            <h3>简化管理</h3>
            <p>集中式仪表板和直观界面简化住客档案、健康警报和机构区域的管理，节省时间并减轻管理负担。</p>
        </div>
    </div>
</section>

<section class="dashboard-structure">
    <h2>仪表板结构</h2>
    <p>智慧辅助生活仪表板让护理人员和管理人员能够实时监测住客健康数据与环境状况，配备直观界面和易于配置的警报系统。</p>
    <div class="dashboard-structure-block">
        <div class="menu">
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>住客总览</h3>
                    </div>
                    <div class="expansion-content">
                        <p>为每位住客提供详细档案，包括心率、体温和紧急按钮状态等健康指标，让护理人员能够快速评估每位住客的当前健康状况。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>住客警报配置</h3>
                    </div>
                    <div class="expansion-content">
                        <p>允许管理员为住客健康参数（如心率和体温）设置定制警报规则。可配置主要和关键阈值，在出现异常时触发相应警报。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>实时住客警报</h3>
                    </div>
                    <div class="expansion-content">
                        <p>显示住客的活跃警报，如紧急按钮触发或生命体征异常，并实时更新每条警报的状态和严重程度，方便护理人员快速响应。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>房间警报配置</h3>
                    </div>
                    <div class="expansion-content">
                        <p>提供调整房间环境因素警报阈值的设置，如温度、湿度、空气质量和门窗状态，确保房间维持在安全舒适的条件下。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>住客列表管理</h3>
                    </div>
                    <div class="expansion-content">
                        <p>列出所有住客及其基本信息，如年龄、性别、分配房间和楼层，方便护理人员高效查找和访问每位住客的数据。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>区域与楼层管理</h3>
                    </div>
                    <div class="expansion-content">
                        <p>允许管理员将机构划分为区域或楼层，便于在机构内不同区域进行导航和监测。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>房间与设备布局</h3>
                    </div>
                    <div class="expansion-content">
                        <p>显示各楼层布局及房间标签和设备图标，让护理人员和管理人员快速识别传感器和设备位置，实现有效监测。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>设备添加</h3>
                    </div>
                    <div class="expansion-content">
                        <p>允许向特定房间添加传感器或网关等新设备，支持可扩展性，使管理员能够按需扩展监测能力。</p>
                    </div>
                </div>
            </div>
            <div class="expansion-block">
                <div class="expansion-panel">
                    <div class="expansion-header">
                        <h3>房间配置</h3>
                    </div>
                    <div class="expansion-content">
                        <p>提供在机构布局中编辑房间详情和位置的工具，实现准确的映射和房间分配的定制。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="applications health">
    <h2>智慧辅助生活解决方案的应用</h2>
    <p>类似的基于物联网的监测和管理解决方案（如智慧辅助生活）可适应并应用于多个领域和方向，例如：</p>
    <div class="applications-container-large">
        <div class="text-row-top">
            <div class="text-block">
                <h3>医院和医疗机构</h3>
                <p>实时监测患者状况，跟踪生命体征，管理病房和科室，并为医护人员设置警报以应对任何健康状况恶化。</p>
            </div>
            <div class="text-block">
                <h3>康复中心</h3>
                <p>监测术后或受伤后接受康复治疗的患者状况。系统可跟踪康复进度，向医生传输数据，并设置物理治疗提醒。</p>
            </div>
            <div class="text-block">
                <h3>监狱和惩教机构</h3>
                <p>通过生命体征跟踪、烟雾探测器和门禁控制系统监测在押人员健康。系统还可监控活动并支持设施安全。</p>
            </div>
        </div>
        <div class="images-row">
            <div class="application-image"><img src="/images/usecases/health-care/hospital-1.svg" alt="医院"></div>
            <div class="application-image"><img src="/images/usecases/health-care/sport-complex-1.svg" alt="体育场馆"></div>
            <div class="application-image"><img src="/images/usecases/health-care/rehabilitation-center-1.svg" alt="康复中心"></div>
            <div class="application-image"><img src="/images/usecases/health-care/factories-1.svg" alt="工厂"></div>
            <div class="application-image"><img src="/images/usecases/health-care/prison-1.svg" alt="监狱"></div>
        </div>
        <div class="text-row-bottom">
            <div class="text-block">
                <h3>体育场馆和健身中心</h3>
                <p>保持健身房和更衣室的最佳条件，监测访客健康状况（如心率），并在锻炼期间若有人健康状况恶化时设置紧急警报。</p>
            </div>
            <div class="text-block">
                <h3>工厂和工业场所</h3>
                <p>通过监测工作条件（温度、气体排放、噪音、湿度）并控制设备状态，确保员工安全，及时响应紧急情况。</p>
            </div>
        </div>
    </div>
    <div class="applications-container-small">
        <div class="application-block">
            <div class="image"><img src="/images/usecases/health-care/hospital-2.svg" alt="水阀"></div>
            <div class="text-block">
                <h3>医院和医疗机构</h3>
                <p>实时监测患者状况，跟踪生命体征，管理病房和科室，并为医护人员设置警报以应对任何健康状况恶化。</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>康复中心</h3>
                <p>监测术后或受伤后接受康复治疗的患者状况。系统可跟踪康复进度，向医生传输数据，并设置物理治疗提醒。</p>
            </div>
            <div class="image"><img src="/images/usecases/health-care/sport-complex-2.svg" alt="油泵"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/health-care/rehabilitation-center-2.svg" alt="食品传送带"></div>
            <div class="text-block">
                <h3>监狱和惩教机构</h3>
                <p>通过生命体征跟踪、烟雾探测器和门禁控制系统监测在押人员健康。系统还可监控活动并支持设施安全。</p>
            </div>
        </div>
        <div class="application-block">
            <div class="text-block">
                <h3>体育场馆和健身中心</h3>
                <p>保持健身房和更衣室的最佳条件，监测访客健康状况（如心率），并在锻炼期间若有人健康状况恶化时设置紧急警报。</p>
            </div>
            <div class="image"><img src="/images/usecases/health-care/factories-2.svg" alt="化工厂"></div>
        </div>
        <div class="application-block">
            <div class="image"><img src="/images/usecases/health-care/prison-2.svg" alt="发电厂"></div>
            <div class="text-block">
                <h3>工厂和工业场所</h3>
                <p>通过监测工作条件（温度、气体排放、噪音、湿度）并控制设备状态，确保员工安全，及时响应紧急情况。</p>
            </div>
        </div>
    </div>
</section>

<section class="summary">
    <div class="summary-text">
        <h2>医疗健康解决方案总结</h2>
        <p>基于 ThingsBoard 的智慧辅助生活解决方案为住客和设施管理提供全面方案，具备强大的监测能力、直观的区域与设备管理，以及可定制的健康与环境条件警报。该解决方案使护理人员和管理人员能够快速响应、保持环境安全，并为住客提供最高标准的护理。</p>
    </div>
    <div class="summary-icon">
        <img src="/images/usecases/health-care/summary.svg" alt="文本总结图标" title="文本总结图标">
    </div>
</section>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const img = document.getElementById("schemeSVG");
        const observer = new IntersectionObserver((entries, obs) => {
          entries.forEach(entry => {
            if (entry.isIntersecting) {
              img.src = img.getAttribute("data-src");
              obs.unobserve(img);
            }
          });
        }, { threshold: 1 });
        observer.observe(img);

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

            if (Math.abs(elemCoor.top) < elemCoor.height / 2 && elemCoor.top < 0) {
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
            <div class="image-container">
                <div class="image-background"></div>
                <div class="image-background"></div>
                <div class="image-background"></div>
                <div class=image>${getImage(0)}</div>
            </div>
            <div class="buttons-block">
                <a id="UseCases_HealthCare_ViewLiveDemo" target="_blank" href="https://thingsboard.cloud/dashboard/f8e77210-8fa8-11ef-90c1-0b39f28da380?publicId=7aa99e80-8acd-11ef-a59e-a9c993dbec14" class="button gtm_button">查看实时演示</a>
                <a id="UseCases_HealthCare_ContactUs" target="_blank" href="/docs/contact-us/?subject=Custom%20Development" class="button contact-us gtm_button">联系我们</a>
            </div>`;
    
            return block;
        }

        function getImage(index) {
            const images = [
                "<img src='/images/usecases/health-care/resident-overview.webp' alt='仪表板住客总览对话框'/>",
                "<img src='/images/usecases/health-care/resident-alarm.webp' alt='仪表板住客警报配置对话框'/>",
                "<img src='/images/usecases/health-care/real-time-resident-alarm.webp' alt='仪表板实时住客警报状态'/>",
                "<img src='/images/usecases/health-care/room-alarm-configuration.webp' alt='仪表板房间警报配置状态'/>",
                "<img src='/images/usecases/health-care/resident-list-management.webp' alt='仪表板住客列表管理状态'/>",
                "<img src='/images/usecases/health-care/zone-and-floor-management.webp' alt='仪表板区域与楼层管理状态'/>",
                "<img src='/images/usecases/health-care/room-and-device-layout.webp' alt='仪表板房间与设备布局状态'/>",
                "<img src='/images/usecases/health-care/device-addition.webp' alt='仪表板设备添加状态'/>",
                "<img src='/images/usecases/health-care/room-configuration.webp' alt='仪表板房间配置状态'/>"
            ];
            return images[index];
        }
    });
</script>
