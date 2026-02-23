**基于证书的认证**使用 TLS，使网关和 broker 相互验证。
将**CA 证书文件路径**设为 CA 证书（用于信任 broker），**客户端证书文件路径**设为网关的客户端证书，**私钥文件路径**设为其私钥（以便 broker 认证网关）。
使用 broker 的 TLS 端口（通常为 8883）以获得加密的生产级安全。

{% assign securityBasic = '
    ===
        image: /images/gateway/mqtt-connector/security-basic-certificates-subsection-1-ce.png,
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=securityBasic %}
