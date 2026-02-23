---
layout: company
title: 关于我们
description: ThingsBoard 帮助全球组织释放物联网的完整潜力，提供开源 IoT 平台，实现设备连接、数据采集、处理、可视化与管理。
notitle: "true"

---

<div class="company-content">
    <div class="company-hero-carousel">
        {% include smooth-carousel.liquid collectionMap = "company-photos-carousel" %}
    </div>
    <div class="company-aboutus">
        <div class="company-aboutus-container">
            <h2 class="company-content-title">关于我们</h2>
            <div class="company-wrapper">
                <div class="company-flex-content-default">
                    <div class="company-aboutus-image-block">
                        <img class="company-aboutus-image" src="/images/thingsboard_blue.svg" alt="ThingsBoard logo" width="257" height="257">
                    </div>
                    <div class="company-text-content-default">
                        <p class="company-text">在 ThingsBoard，我们帮助全球组织释放 IoT 的完整潜力。我们以简化和加速 IoT 落地为愿景，提供完整的开源 IoT 平台，实现便捷的设备连接、数据采集、处理、可视化与管理。</p>
                        <p class="company-text">我们的使命是让 IoT 技术对所有规模的组织都可及、可扩展且灵活。我们助力企业通过前沿工具与技术优化运营、降低成本并开拓新机遇。</p>
                        <p class="company-text">能源、农业、零售、电信、医疗及工业 4.0 等行业的千余家组织信赖 ThingsBoard 管理设备并产出洞察。我们正共同推动 IoT 的未来。</p>
                    </div>
                </div>
            </div>
        </div>
        <h2 class="company-content-title">发展历程</h2>
        <div class="company-history-container">
            <div class="company-wrapper">
                <div class="company-flex-content-default">
                    <div class="company-text-content-default">
                        <p class="company-text">ThingsBoard 始于 2016 年，由两位联合创始人共同愿景而生：打造一个开源 IoT 平台，简化设备连接、数据管理与洞察可视化的复杂流程。自起步起，我们便坚信 IoT 应惠及各种规模的企业。</p>
                        <p class="company-text">最初的小项目迅速成长为全球性运动。我们的首次发布吸引了全球开发者与企业的关注，为活跃社区奠定基础。2018 年，我们成立 ThingsBoard Inc.，专注于扩大使命并支持日益增长的全球客户与用户群。</p>
                        <p class="company-text">在倾听社区的过程中，我们以 ThingsBoard Gateway 等强大工具扩展了 ThingsBoard 生态，实现遗留系统的无缝集成；ThingsBoard Edge 则为现场部署带来实时处理与可靠性。2019 年我们推出 Trendz，专注于高级可视化的数据分析工具。2020 年发布 ThingsBoard Cloud，作为全托管 IoT 平台，提供快速、省心的 IoT 方案部署与扩展。最近在 2023 年，我们发布了 TBMQ——可扩展、高可用的 MQTT broker，面向数亿级客户端的部署场景。</p>
                        <p class="company-text">从仅两位联合创始人起步，ThingsBoard 已成长为超过 100 人的创新团队。我们受到全球数千家组织的信赖，持续创新，一步步塑造 IoT 的未来。</p> 
                    </div>
                    <img class="company-aboutus-image" src="/images/company-images/history-image.webp" alt="ThingsBoard 联合创始人" width="400" height="600">
                </div>
            </div>
        </div>
    </div>
    <div class="company-timeline">
        <div class="company-wrapper">
            {% include timeline-carousel.liquid collectionMap = "company-timeline-carousel" %}
        </div>
    </div>
    <div class="company-values">
        <h2 class="company-content-title">我们的价值观</h2>
        <div class="company-values-wrapper">
            {% include tb-carousel.liquid collectionMap = "company-values-carousel" %}
        </div>
    </div>
    <div class="company-team">
        <div class="company-team-wrapper">
            <h2 class="company-content-title">认识我们的团队</h2>
            {% include bubble-tabs.liquid collectionMap = "thingsboard-team-bubble-tabs-collection" %}
            <a class="join-link" href="/careers/">
                <span>加入我们</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
    {% include thingsboard-contacts.html %}
</div>

<script type="text/javascript">

    function getThresholdValue (property) {
        return Number(getComputedStyle(companyContent).getPropertyValue(property));
    }

    const animatedBlocks = [
        {
            classToSearch: ".company-hero-carousel",
            classToAdd: "company-hero-carousel-animation",
            threshold: getThresholdValue ('--company-hero-carousel-animation'),
            carousel: true
        },
        {
            classToSearch: ".company-aboutus-container",
            classToAdd: "company-aboutus-content-animation",
            threshold: getThresholdValue ('--company-aboutus-content-animation')
        },
        {
            classToSearch: ".company-history-container",
            classToAdd: "company-history-content-animation",
            threshold: getThresholdValue ('--company-history-content-animation')
        },
        {
            classToSearch: ".company-timeline",
            classToAdd: "company-timeline-content-animation",
            threshold: getThresholdValue ('--company-timeline-content-animation'),
            carousel: true
        },
        {
            classToSearch: ".company-values",
            classToAdd: "company-values-content-animation",
            threshold: getThresholdValue ('--company-values-content-animation'),
            carousel: true
        }
    ];

    function searchForAnimation(block) {
        const searchedBlock = document.querySelector(block.classToSearch);

        function showCarouselIfLoaded () {
            const mutationObserver = new MutationObserver((mutationsList, observer) => {
                for (let mutation of mutationsList) {
                    if (mutation.type === 'childList') {
                        const carouselStatus = searchedBlock.querySelector('.owl-loaded');
                        if (carouselStatus) {
                            searchedBlock.classList.add(block.classToAdd);
                            observer.disconnect();
                        }
                    }
                }
            });

            mutationObserver.observe(searchedBlock, {
                childList: true,
                subtree: true
            });

            const carouselStatus = searchedBlock.querySelector('.owl-loaded');

            if (carouselStatus) {
                searchedBlock.classList.add(block.classToAdd);
                mutationObserver.disconnect();
            }
        }

        function showBlockByThreshold () {
            const searchedBlockObserver = new IntersectionObserver(entries => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        if (block.carousel) {
                            showCarouselIfLoaded();
                        } else {
                            entry.target.classList.add(block.classToAdd);
                        }
                        searchedBlockObserver.unobserve(entry.target);
                    }
                });
            }, {
                threshold: block.threshold
            });

            searchedBlockObserver.observe(searchedBlock);
        }

        showBlockByThreshold();

    }

    window.onload = function() {
        animatedBlocks.forEach(block => {
            searchForAnimation(block);
        });
    };



</script>
