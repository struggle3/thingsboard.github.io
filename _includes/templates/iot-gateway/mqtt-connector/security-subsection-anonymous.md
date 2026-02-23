**Anonymous** 是最简单的选项：在 MQTT broker 上发布/订阅无需凭据。
适合测试使用（例如公共测试 broker），
但不建议用于生产环境，因其允许不受控访问。

{% assign securityBasic = '
    ===
        image: /images/gateway/mqtt-connector/security-basic-anonymous-subsection-1-ce.png,
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=securityBasic %}
