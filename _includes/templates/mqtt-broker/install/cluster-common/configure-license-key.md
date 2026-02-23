{% if docsPrefix == "pe/" %}
## 获取许可证密钥

在继续之前，请确保已选择订阅计划或购买永久许可证。
若尚未完成，请访问[定价页面](/pricing/?section=tbmq-options){: target="_blank"}比较可用选项
并获取许可证密钥。

> **注意：** 本指南中，我们将用 **YOUR_LICENSE_KEY_HERE** 表示您的许可证密钥。

## 配置许可证密钥

使用许可证密钥创建 k8s 密钥：

```bash
export TBMQ_LICENSE_KEY=YOUR_LICENSE_KEY_HERE 
kubectl create -n thingsboard-mqtt-broker secret generic tbmq-license --from-literal=license-key=$TBMQ_LICENSE_KEY
```
{: .copy-code}

{% capture replace_license_key %}
请勿忘记将 **YOUR_LICENSE_KEY_HERE** 替换为您的许可证密钥值。
{% endcapture %}
{% include templates/info-banner.md content=replace_license_key %}

{% endif %}
