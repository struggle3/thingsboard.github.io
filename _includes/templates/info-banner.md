<div class="info-banner">
    <img src="/images/doc-info-icon.svg" alt="文档信息图标">
    <div>
      {% if include.title %}
      <div class="info-title">{{ include.title }}</div>
      {% endif %}
      {{ include.content | markdownify }}
    </div>
</div>
