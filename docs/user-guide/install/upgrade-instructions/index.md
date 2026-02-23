---
layout: docwithnav
assignees:
- ashvayka
title: 升级说明
description: ThingsBoardIoT平台升级说明
table-of-contents: "false"
active-menu-item-click: "true"

---

{% include get-hosts-name.html docsPrefix=docsPrefix %}

<div id="upgrade-table">
  {% include upgrade-instructions-table.liquid %}
</div>

<p id="upgrade-links-old" style="margin-bottom: 10px">适用于 <a href="/docs/user-guide/install/upgrade-instructions/old-upgrade-instructions/">3.0 以下版本</a> 的升级说明。</p>

<script>
  (function () {
    var urlParams = new URLSearchParams(window.location.search);
    var hasVersionParam = urlParams.has('version');

    var oldLinks = document.getElementById('upgrade-links-old');

    if (hasVersionParam) {
      oldLinks.style.display = 'none';  
    } 
  })();
</script>