OPC-UA 服务器连接提供三种安全类型：

{% assign securityBasic = '
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-application-basic-anonymous-1-ce.png,
        title: **Anonymous**（匿名）- 最简单的 identity 选项；
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-application-basic-basic-1-ce.png,
        title: **Basic**（基本）- 使用此选项可提供用户名和密码以连接 OPC-UA 服务器；
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-application-basic-certificates-2-ce.png,
        title: **Certificates**（证书）- 最安全的 identity 选项。使用此选项还可提供网关所在机器上证书、私钥和 CA 证书的路径。可选地，可提供用户名/密码对。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=securityBasic %}
