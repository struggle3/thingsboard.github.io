我们假设您已选择订阅计划或决定购买永久许可证。
若尚未选择，请前往[定价](/pricing/)页面为您的场景选择最佳许可证并获取许可证。
更多详情请参阅 [如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

使用您的许可证密钥创建 docker secret：

```text
export TB_LICENSE_KEY=PUT_YOUR_LICENSE_KEY_HERE 
kubectl create -n thingsboard secret generic tb-license --from-literal=license-key=$TB_LICENSE_KEY
```
{: .copy-code}

{% capture tb_license_key_warn %}
请勿忘记将 *PUT_YOUR_LICENSE_KEY_HERE* 替换为您的许可证密钥值。
{% endcapture %}
{% include templates/info-banner.md content=tb_license_key_warn %}