X.509 Certificate 用于为 MQTT over TLS 配置[双向](https://en.wikipedia.org/wiki/Mutual_authentication)认证。
与 [Access Token](/docs/{{docsPrefix}}user-guide/access-token/) 认证类似，但使用 X.509 Certificate 替代 token。

以下说明如何使用 X.509 Certificate 将 MQTT 客户端连接至 ThingsBoard Cloud。

客户端与 ThingsBoard 之间有两种配置策略：

- **X.509 Certificate chain** — *推荐*。<br>
将 ThingsBoard 配置为信任来自特定信任锚（*intermediate certificate*）的所有客户端证书。
设备名称通过可配置的正则表达式从证书 Common Name 自动解析。
证书轮换时无需在每台设备上手动更新证书。
若在配置中启用 *Create new devices*，还支持通过 MQTT 自动 provision 新设备。
- **X.509 Certificate**。<br> 将 ThingsBoard 配置为接受使用预配置客户端证书的指定设备连接。

{% capture contenttogglespecx509 %}
X.509 Certificate chain <small>(recommended)</small>%,%x509Chain%,%templates/ssl/certificates-chain.md%br%
X.509 Certificate%,%X509Leaf%,%templates/ssl/certificates-leaf.md%br%{% endcapture %}

{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardX509" toggle-spec=contenttogglespecx509 %}
