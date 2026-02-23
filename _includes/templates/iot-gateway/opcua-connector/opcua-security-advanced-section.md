此小节有以下几种可用类型：  
1. anonymous  
2. username  
3. cert.PEM  

{% capture identityopcuatogglespec %}
<b>anonymous</b><br> <small>（若所有服务器均在本地网络则推荐使用）</small>%,%anonymous%,%templates/iot-gateway/opcua-connector/opcua-identity-anonymous-config.md%br%
<b>username</b><br> <small>（推荐用于基本安全级别）</small>%,%username%,%templates/iot-gateway/opcua-connector/opcua-identity-username-config.md%br%
<b>cert.PEM</b><br> <small>（推荐用于较高安全级别）</small>%,%certpem%,%templates/iot-gateway/opcua-connector/opcua-identity-certpem-config.md%br%{% endcapture %}

{% include content-toggle.liquid content-toggle-id="opcuaIdentityConfig" toggle-spec=identityopcuatogglespec %}
