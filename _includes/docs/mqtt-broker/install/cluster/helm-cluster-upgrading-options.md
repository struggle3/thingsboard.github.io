{% if (docsPrefix == "pe/") %}
    {% assign installationOptionsValue = "installation-options-pe-mqtt-broker-helm-cluster-upgrading-options" %}
{% else %}
    {% assign installationOptionsValue = "installation-options-mqtt-broker-helm-cluster-upgrading-options" %}
{% endif %}

<div class="installation-options">
    <div class="install-options-header">
       <div class="install-options-hero">
          <div class="container">
            <div class="install-options-hero-content">
                <h1>使用 Helm 部署的 TBMQ 集群升级选项</h1>
                <div class="install-options-description">
                    <p>请在下方选择你的 Kubernetes 环境，随后将进入针对该平台的完整 TBMQ 升级流程。</p>
                </div>
            </div>
            <div class="deployment-container one-line-deployment-container">
                <div class="deployment-div">
                    {% include installation-options-cards.liquid installationOptions=installationOptionsValue active=true %}
                </div>
            </div>
          </div>
       </div>
    </div>
</div>