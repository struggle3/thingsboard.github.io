在 edge 详情区域点击 **Copy Edge Key** 和 **Copy Edge Secret**。
这将把 edge 凭证复制到剪贴板。
请妥善保存，后续步骤将用到这些值。

{% if docsPrefix == 'pe/edge/' %}
{% assign copyEdgeCredentials = '
    ===
        image: /images/pe/edge/installation-copy-edge-credentials-item-1.png
'%}
{% else %}
{% assign copyEdgeCredentials = '
    ===
        image: /images/edge/installation-copy-edge-credentials-item-1.png
'%}
{% endif %}

{% include images-gallery.liquid imageCollection=copyEdgeCredentials %}