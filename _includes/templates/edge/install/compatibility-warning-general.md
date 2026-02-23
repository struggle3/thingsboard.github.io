{% capture infoWired %}
<p>版本兼容规则 - 操作前请阅读
</p>
{% if page.url contains 'upgrade-instructions' %}
<p>升级 ThingsBoard Edge 前，请确保 <b>ThingsBoard Server</b> 已<a href="/docs/{{peDocsPrefix}}user-guide/install/upgrade-instructions/" target="_blank">更新至最新版本</a>。</p>
{% else %}
<p>安装 ThingsBoard Edge 前，请确保 <b>ThingsBoard Server</b> 已<a href="/docs/{{peDocsPrefix}}user-guide/install/installation-options/" target="_blank">安装</a>并<a href="/docs/{{peDocsPrefix}}user-guide/install/upgrade-instructions/" target="_blank">更新</a>至最新版本。</p>
{% endif %}
<p>此外，请确认 <b>ThingsBoard Edge 与 ThingsBoard Server 版本兼容</b>。</p>

<p>兼容规则：</p>
<ul>
<li>ThingsBoard Edge 版本 X.Y.Z 可与 ThingsBoard Server 版本 X.Y.Z 及后续 <span style="color:red"><strong>两个</strong></span>版本配合使用。</li><ul>
<li>示例：ThingsBoard Edge 3.8.0 可与 ThingsBoard Server 3.8.0 及两个后续版本（3.9.0、3.9.1）配合。查看 <a href="/docs/{{peDocsPrefix}}reference/releases/" target="_blank">ThingsBoard Server 发行说明</a>。</li></ul>
<li>ThingsBoard Edge 版本 X.Y.Z <span style="color:red"><strong>无法</strong></span>与较旧版本的 ThingsBoard Server 配合使用。</li><ul>
<li>示例：ThingsBoard Edge 3.9.1 <span style="color:red"><strong>不支持</strong></span> ThingsBoard Server 3.8.0 或更早版本，需先将 ThingsBoard Server <a href="/docs/user-guide/install/{{peDocsPrefix}}upgrade-instructions/" target="_blank">升级至最新版本</a>。</li></ul>
</ul>
<p><strong>注意：</strong> 若使用较旧版本的 ThingsBoard Edge（如 3.6.0），ThingsBoard 团队无法保证所有功能可用或正常工作。</p>
{% endcapture %}
{% include templates/warn-banner.md content=infoWired %}

