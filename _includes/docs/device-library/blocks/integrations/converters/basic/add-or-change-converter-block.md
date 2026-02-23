{% assign integrationType = include.integration-type %}
{% assign integrationTypeCorrectName = include.integration-type-correct-name %}

{% if integrationType == "thethingsstack" %}
{% assign integrationTypeForLink = "TTN" %}
{% elsif integrationType == "thethingsindustries" %}
{% assign integrationTypeForLink = "TTI" %}
{% elsif integrationType == "loriot" %}
{% assign integrationTypeForLink = "LORIOT" %}
{% elsif integrationType == "chirpstack" %}
{% assign integrationTypeForLink = "CHIRPSTACK" %}
{% else %}
{% assign integrationTypeForLink = integrationType | upcase %}
{% endif %}

{% assign converterFilePath = "/docs/device-library/blocks/integrations/converters/basic/" | append: integrationType | append: "-uplink-converter.js" %}
{% assign uplinkConverterLink = "https://raw.githubusercontent.com/thingsboard/data-converters/refs/heads/release/latest/VENDORS/" | append: page.vendor | append: "/" | append: page.model | append: "/" | append: integrationTypeForLink | append: "/uplink/converter.json" %}

### ThingsBoard 集成中的上行数据转换器

{% if page.converters20 %}

<b>步骤 1：下载 JSON 文件</b>

点击下方按钮下载包含上行数据转换器配置的 JSON 文件。

[下载 {{ integrationTypeCorrectName }} 集成的上行数据转换器。]({{ uplinkConverterLink }}){: target="_blank" download="converter.json" .button }

{% include /docs/device-library/blocks/integrations/converters/basic/import-uplink-converter-for-integration-type.md integration-type=integrationType integration-type-correct-name=integrationTypeCorrectName %}

{% else %}

由于我们已连接网关并配置了集成，需要修改转换器并添加解析设备上行数据负载的能力。

为此，您可以将代码添加到"*解码块*"中，该块位于转换器内"*// --- Decoding code --- //*"注释之间（若使用 ThingsBoard v3.5.2 及以上版本的默认转换器）。


{% capture customDecodingCodeCapture %}
{% assign customDecodingCodeFilePath = "/docs/device-library/blocks/integrations/converters/custom-decoding/" | append: page.name | replace: ".md", ".js" %}
{% include {{ customDecodingCodeFilePath }} %}
{% endcapture %}

{% capture customDecodingCodeBlock %}
{% include code-toggle.liquid code=customDecodingCodeCapture params="javascript|.copy-code.expandable-10" %}
{% endcapture %}

{{ customDecodingCodeBlock }}

或者，您也可以复制完整的转换器代码并粘贴到您的转换器中：

{% capture converterCode %}
{% include {{ converterFilePath }} %}
{% endcapture %}

{% capture wholeConverterCodeBlock %}
{% assign converterCode = converterCode | replace: "// Custom decoding placeholder", customDecodingCodeCapture %}
{% include code-toggle.liquid code=converterCode params="javascript|.copy-code.expandable-15" %}
{% endcapture %}

{{ wholeConverterCodeBlock }}

{% endif %}