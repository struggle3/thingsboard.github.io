{% if docsPrefix == "pe/" %}
使用以下命令向托管在 **localhost** 上的 CoAP 服务器发送消息。请将 **$YOUR_COAP_ENDPOINT_URL** 替换为实际值。
{% endif %}
{% if docsPrefix contains "paas/" %}
使用以下命令向托管在 **int.{{hostName}}** 上的 CoAP 服务器发送消息。请将 **$YOUR_COAP_ENDPOINT_URL** 替换为实际值。
{% endif %}

```shell
echo -e -n '\x53\x4e\x2d\x30\x30\x31\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x36\x39' | coap-client -m post $YOUR_COAP_ENDPOINT_URL -t application/octet-stream -f-
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/coap/terminal-binary-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/coap/terminal-binary-paas.png)
{% endif %}