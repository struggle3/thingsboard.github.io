{% if docsPrefix == "pe/" %}
使用以下命令向托管在 **localhost** 上的 CoAP 服务器发送消息。请将 **$YOUR_COAP_ENDPOINT_URL** 替换为实际值。
{% endif %}
{% if docsPrefix contains "paas/" %}
使用以下命令向托管在 **int.{{hostName}}** 上的 CoAP 服务器发送消息。请将 **$YOUR_COAP_ENDPOINT_URL** 替换为实际值。
{% endif %}

```shell
echo -e 'SN-001,default,temperature,25.7,humidity,69' | coap-client -m post $YOUR_COAP_ENDPOINT_URL -t text/plain -f-
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/coap/terminal-text-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/coap/terminal-text-paas.png)
{% endif %}