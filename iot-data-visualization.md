---
layout: iot-data-visualization
title: 用部件、SCADA与仪表盘实现IoT数据可视化
notitle: "true"
description: 了解ThingsBoard强大的IoT数据可视化能力。使用图表、曲线、SCADA部件与控制元素构建交互式仪表盘，借助状态与响应式布局实现实时监控、更好体验、决策支持与工业流程优化。
---

<div class="visualization-wrapper">
    <section class="visualization-hero">
        <div class="title">
            <h1>IoT数据可视化</h1>
            <p>创建交互式仪表盘，将原始IoT数据转化为可执行的洞察。</p>
            <a id="visualization_try_it_now" target="_blank" href="/installations/" class="button gtm_button">立即试用</a>
        </div>
        <div class="images">
            <div class="circle-bg"></div>
            <img src="/images/visualization/bar-chart.svg" class="visualization-hero-image" alt="ThingsBoard仪表盘与菜单">
            <img src="/images/visualization/cold_water_usage.webp" class="visualization-hero-image-2" alt="冷水用量数值卡片">
            <img src="/images/visualization/route_history.webp" class="visualization-hero-image-3" alt="行程动画地图">
            <img src="/images/visualization/moisture_himidity.webp" class="visualization-hero-image-4" alt="湿度与含水量折线图">
            <img src="/images/visualization/energy_sources.webp" class="visualization-hero-image-5" alt="能源来源饼图">
            <img src="/images/visualization/slider.webp" class="visualization-hero-image-6" alt="滑块部件">
        </div>
    </section>
    <section class="visualization-definition">
        <div class="title">
            <h2>什么是IoT中的数据可视化？</h2>
            <p>IoT数据可视化是将设备原始数据转化为图表、曲线、仪表等视觉形式的过程，帮助用户快速把握规律与趋势。在ThingsBoard中，您可以使用多种部件——图表、表格、SCADA符号等——创建实时仪表盘，用于监控与控制。仪表盘支持响应式布局与导航流程，并可方便地分享给客户。</p>
        </div>
        <img data-src="/images/visualization/visualization-scheme.svg" src="/images/visualization/visualization-scheme.svg" class="svg-animation" alt="可视化示意图">
    </section>
    <section class="visualization-implementation">
        <h2>ThingsBoard如何实现数据可视化</h2>
        <div class="block">
            <div class="title">
                <h3>部件</h3>
                <p>部件是仪表盘上用于展示特定信息或提供功能的元素。部件可展示静态、最新或历史设备数据，支持远程控制，以及告警监控与管理。</p>
            </div>
            <div class="row">
                <div class="card">
                    <div class="image-container">
                        <img class="svg-animation" data-src="/images/visualization/cards.svg" src="/images/visualization/cards.svg" alt="卡片部件">
                    </div>
                    <div class="content">
                        <h4>卡片</h4>
                        <p>卡片套件适用于在表格或卡片部件中展示时序数据或属性。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="image-container">
                        <img class="svg-animation" data-src="/images/visualization/charts.svg" src="/images/visualization/charts.svg" alt="图表部件">
                    </div>
                    <div class="content">
                        <h4>图表</h4>
                        <p>图表套件适用于在时间窗口内展示历史或实时数据。</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="card">
                    <div class="image-container">
                        <img class="svg-animation" data-src="/images/visualization/control.svg" src="/images/visualization/control.svg" alt="控制与状态部件">
                    </div>
                    <div class="content">
                        <h4>控制与状态部件</h4>
                        <p>控制与状态部件套件适用于展示当前状态、向目标设备发送RPC命令、电量、信号强度及进度条等。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="image-container">
                        <img class="svg-animation" data-src="/images/visualization/gauges.svg" src="/images/visualization/gauges.svg" alt="仪表盘部件">
                    </div>
                    <div class="content">
                        <h4>仪表</h4>
                        <p>仪表套件适用于展示温度、湿度、速度及其他整数或浮点数值。</p>
                    </div>
                </div>
            </div>
            <div class="block-link">
                <a href="/docs/user-guide/widgets/">了解更多 <i class="fas fa-chevron-right fa-md"></i></a>
            </div>
        </div>
        <div class="block">
            <div class="title">
                <h3>SCADA仪表盘</h3>
                <p>SCADA指用于监控与控制各类机器与制造流程的架构。ThingsBoard提供完整工具，用于采集、处理并可视化来自SCADA组件（如PLC可编程逻辑控制器与RCU远程控制单元）的数据，实现与多种工业流程的无缝集成。</p>
            </div>
            <div class="row">
                <div class="card">
                    <div class="image-container">
                        <img class="svg-animation" data-src="/images/visualization/SCADA-high-perf-section.svg" src="/images/visualization/SCADA-high-perf-section.svg" alt="SCADA高性能部件">
                    </div>
                    <div class="content">
                        <h4>高性能</h4>
                        <p>高性能SCADA符号采用简化的极简风格，侧重基础监控与控制。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="image-container">
                        <img class="svg-animation" data-src="/images/visualization/SCADA-traditional-section.svg" src="/images/visualization/SCADA-traditional-section.svg" alt="SCADA传统部件">
                    </div>
                    <div class="content">
                        <h4>传统</h4>
                        <p>传统SCADA符号具有动态、直观且可交互的设计，强调简洁界面、更快决策与更高运行效率。</p>
                    </div>
                </div>
            </div>
            <div class="block-link">
                <a href="/docs/user-guide/scada/">了解更多 <i class="fas fa-chevron-right fa-md"></i></a>
            </div>
        </div>
        <div class="block">
            <div class="title">
                <h3>解决方案模板</h3>
                <p>ThingsBoard提供便捷的IoT解决方案模板，缩短产品上市时间。模板包含交互式仪表盘、处理逻辑、示例设备、用户及其他所需实体，可作为完整的PoC/MVP使用。</p>
            </div>
            <div class="row">
                <div class="card">
                    <div class="image-container solution-template">
                        <img src="/images/visualization/placeholder.png" alt="占位图">
                        <img class="al1" src="/images/visualization/assisted-living-1.webp" alt="辅助生活部件">
                        <img class="al2" src="/images/visualization/assisted-living-2.webp" alt="辅助生活部件">
                    </div>
                    <div class="content">
                        <h4>医疗健康</h4>
                        <p>ThingsBoard是具备完整工具的IoT平台，可轻松构建全面的医疗健康监测与管理方案，提供丰富的内置能力与灵活的自定义选项。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="image-container solution-template">
                        <img src="/images/visualization/placeholder.png" alt="占位图">
                        <img class="d1" src="/images/visualization/energy_1.webp" alt="能源SCADA部件">
                        <img class="d2" src="/images/visualization/energy_2.webp" alt="能源SCADA部件">
                    </div>
                    <div class="content">
                        <h4>SCADA能源管理</h4>
                        <p>借助SCADA系统，企业可在ThingsBoard IoT平台上实时监控能源生产、配送与消耗，优化能效、降低成本并提升系统可靠性。</p>
                    </div>
                </div>
            </div>
            <div class="block-link">
                <a href="/iot-use-cases/">了解更多 <i class="fas fa-chevron-right fa-md"></i></a>
            </div>
        </div>
        <div class="block">
            <div class="title">
                <h3>状态与布局</h3>
                <p>支持将仪表盘组织为多视图并高效排布部件以提升体验。状态用于在不同仪表盘界面间导航，布局则定义部件在不同设备上的响应式位置与尺寸，共同构建结构清晰、易用且自适应的界面。</p>
            </div>
            <div class="row no-margin">
                <div class="card image-only">
                    <div class="image-container layouts no-border">
                        <img src="/images/visualization/placeholder.png" alt="占位图">
                        <img class="layout1 large" src="/images/visualization/layouts_macbook.webp" alt="Macbook布局">
                        <img class="layout2 large" src="/images/visualization/layouts_iphone.webp" alt="iPhone布局">
                        <img class="layout3 large" src="/images/visualization/layouts_ipad.webp" alt="iPad布局">
                        <img class="layout small" src="/images/visualization/layouts_image.webp" alt="布局示意">
                    </div>
                </div>
            </div>
            <div class="row no-margin">
                <div class="card">
                    <div class="content">
                        <h4><a href="/docs/user-guide/dashboards/#states">状态</a></h4>
                        <p>ThingsBoard仪表盘中的状态支持创建多视图仪表盘，每个状态对应一个独立界面或上下文（如设备详情或汇总面板）。可定义导航规则并在状态间传递参数，构建动态、上下文感知的用户流程。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="content">
                        <h4><a href="/docs/user-guide/ui/layouts/">布局</a></h4>
                        <p>布局定义每个仪表盘状态内部件的排列与展示方式，支持针对不同屏幕尺寸的响应式设计。ThingsBoard支持网格与固定布局，可控制桌面、平板与移动端视图中部件的尺寸、位置与行为。</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="block">
            <div class="title">
                <h3>仪表盘</h3>
                <p>ThingsBoard中的仪表盘是灵活的可视化工具，支持用户实时监控、控制与交互IoT数据。可将仪表盘分配给指定客户或直接分享给用户，实现基于角色的安全访问与多方协作。结合动态数据源、类SCADA控制、自定义部件与响应式布局，仪表盘为构建工业级监控与控制系统提供可定制的界面。</p>
            </div>
            <div class="row no-margin">
                <div class="card image-only">
                    <div class="image-container customers no-border">
                        <img src="/images/visualization/placeholder.png" alt="占位图">
                        <img class="customerA" src="/images/visualization/customer_a.webp" alt="客户A仪表盘">
                        <img class="customerB" src="/images/visualization/customer_b.webp" alt="客户B仪表盘">
                        <img class="customerC" src="/images/visualization/customer_c.webp" alt="客户C仪表盘">
                    </div>
                </div>
            </div>
            <div class="row no-margin">
                <div class="card">
                    <div class="content">
                        <h4><a href="/docs/getting-started-guides/helloworld/#step-7-assign-device-and-dashboard-to-customer">ThingsBoard社区版</a></h4>
                        <p>您可将仪表盘分配给客户，使其用户对其设备与资产所属数据拥有只读访问权限。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="content">
                        <h4><a href="/docs/getting-started-guides/helloworld-pe/#step-7-share-dashboard-with-customers">ThingsBoard专业版</a></h4>
                        <p>您可通过高级RBAC与白标功能全面控制仪表盘访问，为客户提供灵活、安全且可定制的数据可视化体验。</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="block">
            <div class="title">
                <h3>自定义部件与操作</h3>
                <p>自定义部件与操作支持通过创建自有部件和配置用户操作扩展可视化能力。可开发独特的UI元素，并为点击、悬停等事件定义行为，确保交互性并满足特定需求。</p>
            </div>
            <div class="row no-margin">
                <div class="card image-only">
                    <div class="image-container custom no-border">
                        <img class="left" src="/images/visualization/left_img.webp" alt="图像地图部件中的人物">
                        <img class="arrow" src="/images/visualization/arrow.svg" alt="箭头">
                        <img class="right" src="/images/visualization/guest_info.webp" alt="人员信息部件">
                    </div>
                </div>
            </div>
            <div class="row no-margin">
                <div class="card">
                    <div class="content">
                        <h4><a href="/docs/user-guide/contribution/widgets-development/">自定义部件开发</a></h4>
                        <p>自定义部件开发支持构建并贡献具有自定义逻辑、样式与配置选项的部件，全面掌控仪表盘元素的外观与功能。</p>
                    </div>
                </div>
                <div class="card">
                    <div class="content">
                        <h4><a href="/docs/user-guide/ui/widget-actions/">操作</a></h4>
                        <p>部件操作支持定义由用户事件触发的交互行为，如导航、RPC调用与自定义脚本，便于创建贴合实时需求的响应式动态仪表盘。</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="widgets">
        <div class="widgets-slide">
            <img src="/images/visualization/widgets_part.webp" alt="ThingsBoard部件">
        </div>
        <div class="widgets-slide">
            <img src="/images/visualization/widgets_part.webp" alt="ThingsBoard部件">
        </div>
    </section>
    <section class="visualize-with-tb">
        <h2>ThingsBoard可视化您的数据</h2>
        <a id="visualization_try_it_now" target="_blank" href="/installations/" class="button gtm_button">立即试用</a>
    </section>
</div>
