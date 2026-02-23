运行以下命令验证您能否从 Docker Hub 拉取镜像。

{% if checkoutMode == 'monolith' %}
```bash
docker pull thingsboard/tb-pe-node:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-web-report:{{ site.release.pe_full_ver }}
```
{: .copy-code}
{% else %}
```bash
docker pull thingsboard/tb-pe-node:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-web-report:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-web-ui:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-js-executor:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-http-transport:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-mqtt-transport:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-coap-transport:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-lwm2m-transport:{{ site.release.pe_full_ver }}
docker pull thingsboard/tb-pe-snmp-transport:{{ site.release.pe_full_ver }}
```
{: .copy-code}
{% endif %}
