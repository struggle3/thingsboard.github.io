{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'pe/' %}
{% assign platformName = 'ThingsBoard PE' %}
{% assign firstRowItemClasses = 'col-12 col-sm-6 col-lg col-xxl-6 col-4xl' %}
{% assign faqItemClasses = 'col-12 col-sm-6 col-lg col-xxl-6 col-4xl' %}
<p>ThingsBoard 专业版（PE）文档可助您部署 ThingsBoard PE、了解平台并将 IoT 项目运行于 ThingsBoard PE 之上。</p>
{% elsif docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% assign platformName = 'ThingsBoard Cloud' %}
{% assign firstRowItemClasses = 'col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3' %}
{% assign faqItemClasses = 'col col-lg-6 col-xxl col-4xl-6' %}
<p>ThingsBoard Cloud 文档可助您上手 ThingsBoard Cloud、了解平台并将 IoT 项目运行于 ThingsBoard Cloud 之上。</p>
{% endif %}

<div class="doc-features row mt-4">
    <div class="{{firstRowItemClasses}} mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}getting-started-guides/what-is-thingsboard/">
            <img class="feature-logo" src="/images/feature-logo/thingsboard-logo.svg" alt="Thingsboard logo">
            <div class="feature-title">ThingsBoard是什么</div>
            <div class="feature-text">
                <ul>
                    <li>特性</li>
                    <li>架构</li>
                </ul>
            </div>
        </a>
    </div>
    <div class="{{firstRowItemClasses}} mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}getting-started-guides/helloworld/">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="Getting started icon">
            <div class="feature-title">快速入门</div>
            <div class="feature-text">
                学习如何使用 {{platformName}} 平台。
            </div>
        </a>
    </div>
{% if docsPrefix == 'pe/' %}
    <div class="{{firstRowItemClasses}} mb-4">
        <a class="feature-card" href="/docs/user-guide/install/pe/installation-options/">
            <img class="feature-logo" src="/images/feature-logo/install.svg" alt="Install icon">
            <div class="feature-title">安装</div>
            <div class="feature-text">
                学习如何安装与升级平台。
            </div>
        </a>
    </div>
{% endif %}
    <div class="{{faqItemClasses}} mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}faq/">
            <img class="feature-logo" src="/images/feature-logo/faq.svg" alt="Question icon">
            <div class="feature-title">FAQ</div>
            <div class="feature-text">
                获取常见问题解答。
            </div>
        </a>
    </div>
    <div class="w-100"></div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="https://www.youtube.com/channel/UCDb9fsV-YR4JmnipAMGsVAQ/videos">
            <img class="feature-logo" src="/images/feature-logo/tutorials.svg" alt="Tutorials icon">
            <div class="feature-title">视频教程</div>
            <div class="feature-text">
                在 YouTube 观看平台功能教程。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="/device-library/?platform={{ docsPrefix | replace: "/", "" | replace: "paaseu", "paas" }}">
            <img class="feature-logo" src="/images/feature-logo/devices-library.svg" alt="Guides icon">
            <div class="feature-title">设备库</div>
            <div class="feature-text">
                学习如何将不同设备连接至 {{platformName}}。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}guides/">
            <img class="feature-logo" src="/images/feature-logo/guides.svg" alt="Guides icon">
            <div class="feature-title">指南</div>
            <div class="feature-text">
                学习 {{platformName}} 主要功能。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}api/">
            <img class="feature-logo" src="/images/feature-logo/api.svg" alt="Api documentation icon">
            <div class="feature-title">API</div>
            <div class="feature-text">
                学习设备连接性与平台服务端 API。
            </div>
        </a>
    </div>
</div>

<h2 id="features">功能特性</h2>

<div class="doc-features row mt-4">
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}guides/#AnchorIDDataVisualization">
            <div class="feature-title">数据可视化</div>
            <div class="feature-text">
                涵盖数据可视化能力：部件、仪表板、仪表板状态。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/telemetry/">
            <div class="feature-title">遥测</div>
            <div class="feature-text">
                采集时序数据及相关的 API 与用例。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/reporting/reporting-getting-started/">
            <div class="feature-title">报表</div>
            <div class="feature-text">
                生成报表并分发给终端用户。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/attributes/">
            <div class="feature-title">属性</div>
            <div class="feature-text">
                平台为实体分配自定义键值属性的能力（如配置、数据处理、可视化参数）。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/">
            <div class="feature-title">规则引擎</div>
            <div class="feature-text">
                涵盖对入站遥测与事件的数据处理及动作。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/entities-and-relations/">
            <div class="feature-title">实体与关系</div>
            <div class="feature-text">
                平台对物理对象（如设备、资产）及其关系的建模能力。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/audit-log/">
            <div class="feature-title">审计日志</div>
            <div class="feature-text">
                跟踪用户活动与 API 调用使用情况。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/api-limits/">
            <div class="feature-title">API 限制</div>
            <div class="feature-text">
                通过限制单一主机在单位时间内的请求数控制 API 使用。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/rpc/">
            <div class="feature-title">RPC</div>
            <div class="feature-text">
                通过 API 与部件从应用及仪表板向设备推送命令，反之亦然。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/white-labeling/">
            <div class="feature-title">白标</div>
            <div class="feature-text">
                在 2 分钟内配置公司或产品 Logo、配色及邮件模板。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/scheduler/">
            <div class="feature-title">调度器</div>
            <div class="feature-text">
                以灵活的配置选项调度各类事件（如配置更新、报表生成、RPC 命令）。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/advanced-filters/">
            <div class="feature-title">高级过滤器</div>
            <div class="feature-text">
                对实体字段、属性及最新遥测进行过滤。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/groups/">
            <div class="feature-title">设备与资产分组</div>
            <div class="feature-text">
                配置多个自定义设备与资产分组。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/csv-xls-data-export/">
            <div class="feature-title">CSV/XLS 数据导出</div>
            <div class="feature-text">
                将部件数据导出为 CSV 或 XLS。
            </div>
        </a>
    </div>
    <div class="col col-lg-4 col-xxl col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/file-storage/">
            <div class="feature-title">文件存储</div>
            <div class="feature-text">
                支持将二进制内容（文件）存入数据库。
            </div>
        </a>
    </div>
    <div class="w-100"></div>
    <div class="col col-xxl mb-4">
        <div class="feature-card">
            <div class="feature-title"><a href="/docs/{{peDocsPrefix}}user-guide/integrations/">平台集成</a></div>
            <div class="feature-text">
                通过 NB IoT、LoRaWAN、SigFox 等连接方案、特定负载格式或各类IoT平台连接设备。
            </div>
            <div class="row mt-4">
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/http/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/http.svg" alt="HTTP logo icon"><span>HTTP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/opc-ua.svg" alt="OPC-UA logo icon"><span>OPC-UA</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/mqtt.svg" alt="MQTT logo icon"><span>MQTT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/sigfox.svg" alt="SigFox logo icon"><span>SigFox</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/tcp/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/tcp.svg" alt="TCP logo icon"><span>TCP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/azure-event-hub/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/azure-event-hub.svg" alt="Azure Event Hub logo icon"><span>Azure Event Hub</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/azure-iot-hub/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/azure-iot-hub.svg" alt="Azure IoT Hub logo icon"><span>Azure IoT Hub</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/coap/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/coap.svg" alt="CoAP logo icon"><span>CoAP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/thingpark.svg" alt="Thing Park logo icon"><span>ThingPark</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/ttn/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/ttn.svg" alt="The Things Stack Community logo icon"><span>TheThingsStackCommunity</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/tti/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/things-stack-industries.svg" alt="The Things Stack Industries logo icon"><span>TheThingsStackIndustries</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/chirpstack.svg" alt="Chirp Stack logo icon"><span>ChirpStack</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/apache-pulsar.svg" alt="Apache Pulsar logo icon"><span>Apache Pulsar</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/aws-iot/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/aws-iot.svg" alt="AWS IoT logo icon"><span>AWS IoT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/aws-kinesis/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/aws-kinesis.svg" alt="AWS Kinesis logo icon"><span>AWS Kinesis</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/aws-sqs.svg" alt="AWS SQS logo icon"><span>AWS SQS</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/custom.svg" alt="Custom properties icon"><span>Custom</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/ibm-watson-iot/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/ibm-watson-iot.svg" alt="IBM Watson IoT"><span>IBM Watson IoT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/kafka/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/kafka.svg" alt="Kafka"><span>Kafka</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/loriot/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/loriot.svg" alt="Loriot"><span>Loriot</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/ocean-connect/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/ocean-connect.svg" alt="Ocean Connect"><span>Ocean Connect</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/pub-sub.svg" alt="Pub/Sub"><span>Pub-Sub</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/rabbitmq.svg" alt="RabbitMQ"><span>RabbitMQ</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/thingpark.svg" alt="ThingPark"><span>Thing Park</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/thingpark-enterprise.svg" alt="Thing Park Enterprise logo icon"><span>ThingParkEnterprise</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/udp/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/udp.svg" alt="UDP logo icon"><span>UDP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/iotcreators.com.svg" alt="T-Mobile – IoT CDP logo icon"><span>iotcreators.com (T-Mobile – IoT CDP)</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/tuya/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/tuya.svg" alt="Tuya logo icon"><span>Tuya</span></div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
