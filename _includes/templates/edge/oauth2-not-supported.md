{% capture oauth2-not-supported %}
目前，**Edge** 不支持用于登录的 **OAuth 2.0**。
若希望通过OAuth 2.0 **用户凭据**访问Edge，需在 **ThingsBoard Server** 上为该用户**分配密码**。
{% endcapture %}
{% include templates/warn-banner.md content=oauth2-not-supported %}
