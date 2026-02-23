**Basic** 认证使用 MQTT broker 上配置的 **username** 和 **password**。
适合大多数场景——只需使用强且唯一的凭据。若需更强身份验证和双向认证，可考虑基于证书的认证。

{% assign securityBasic = '
    ===
        image: /images/gateway/mqtt-connector/security-basic-basic-subsection-1-ce.png,
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=securityBasic %}
