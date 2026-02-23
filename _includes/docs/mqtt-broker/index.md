{% include templates/mqtt-broker/pe-tbmq-explore-banner.md %}

**TBMQ** 是一款高度可扩展且容错的 [MQTT broker](/products/mqtt-broker/){:target="_blank"}，专为使用 
<a href="/products/mqtt-broker/" target="_blank" style="color: inherit; text-decoration: none;">MQTT 协议</a> 在连接设备和应用之间进行高效可靠的消息路由而设计。

TBMQ 针对高性能优化，可处理 **数百万** 并发连接，并实现 [每秒数百万条消息](/docs/{{docsPrefix}}mqtt-broker/reference/3m-throughput-single-node-performance-test/) 的处理能力，
同时保持极低延迟。
其分布式 **集群架构** 进一步扩展了可扩展性，支持 [大规模 IoT 部署](/docs/{{docsPrefix}}mqtt-broker/reference/100m-connections-performance-test/)，并在所有节点间确保 **高可用性**。

有关安装说明及架构与 MQTT 功能的详细介绍，请参阅 TBMQ 官方文档。

## 试用在线演示

最快上手方式是使用我们的 **免费公共 MQTT broker**，无需安装。

<div class="doc-features row mt-4 align-items-stretch">
    <div class="col-12 col-sm-7 col-lg-7 mb-4 d-flex">
        <div class="feature-card w-100">
            <div class="feature-title">MQTT 连接信息</div>
            <div class="feature-text">
                <b>Host:</b> <code>demo.tbmq.io</code><br>
                <b>TCP Port:</b> <code>1883</code><br>
                <b>TLS Port:</b> <code>8883</code><br>
                <b>Username:</b> <code>demo</code><br>
                <b>Password:</b> <i>留空</i>
            </div>
        </div>
    </div>
    <div class="col-12 col-sm-5 col-lg-5 mb-4 d-flex">
        <a class="feature-card w-100" href="https://demo.tbmq.io/signup" target="_blank">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="Sign up icon">
            <div class="feature-title">免费注册</div>
            <div class="feature-text">
                创建账户以访问 TBMQ 在线演示 Broker，实时监控会话、订阅和 broker 统计数据。
            </div>
        </a>
    </div>
</div>

<div class="doc-features row mt-4">
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}mqtt-broker/getting-started-guides/what-is-thingsboard-mqtt-broker/">
            <img class="feature-logo" src="/images/feature-logo/thingsboard-logo.svg" alt="Thingsboard logo">
            <div class="feature-title">什么是 TBMQ？</div>
            <div class="feature-text">
                <ul>
                    <li>功能特性</li>
                    <li>架构</li>
                </ul>
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}mqtt-broker/getting-started/">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="Getting started icon">
            <div class="feature-title">入门</div>
            <div class="feature-text">
                学习如何使用 TBMQ。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}mqtt-broker/install/installation-options/">
            <img class="feature-logo" src="/images/feature-logo/install.svg" alt="Install icon">
            <div class="feature-title">安装</div>
            <div class="feature-text">
                学习如何安装和升级 TBMQ。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}mqtt-broker/faq/">
            <img class="feature-logo" src="/images/feature-logo/faq.svg" alt="Question icon">
            <div class="feature-title">常见问题</div>
            <div class="feature-text">
                获取最常见问题的答案。
            </div>
        </a>
    </div>
    <div class="w-100"></div>
    <div class="col-12 col-sm-6 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}mqtt-broker/install/config/">
            <img class="feature-logo" src="/images/feature-logo/configuration.svg" alt="Gear icon">
            <div class="feature-title">配置</div>
            <div class="feature-text">
                TBMQ 的配置说明。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}mqtt-broker/api/">
            <img class="feature-logo" src="/images/feature-logo/api.svg" alt="Api documentation icon">
            <div class="feature-title">API</div>
            <div class="feature-text">
                了解客户端连接和 broker 专用服务端 API。
            </div>
        </a>
    </div>
    <div class="w-100"></div>
    <div class="col col-xxl mb-4">
        <div class="feature-card">
            <div class="feature-title"><a href="/docs/{{docsPrefix}}mqtt-broker/integrations/">集成</a></div>
            <div class="feature-text">
                将 MQTT 消息转发到 HTTP、Kafka 或外部 MQTT broker 等外部系统，无缝连接 IoT 数据与您的基础设施。
            </div>
            <div class="row mt-4">
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{docsPrefix}}mqtt-broker/integrations/http/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/http.svg" alt="HTTP logo icon"><span>HTTP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{docsPrefix}}mqtt-broker/integrations/mqtt/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/mqtt.svg" alt="MQTT logo icon"><span>MQTT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{docsPrefix}}mqtt-broker/integrations/kafka/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/kafka.svg" alt="Kafka"><span>Kafka</span></div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
