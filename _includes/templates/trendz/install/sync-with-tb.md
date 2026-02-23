最后一步是确认 ThingsBoard 已与 Trendz 同步。操作如下：

* 以 **Sysadmin** 身份登录 **ThingsBoard**。
* 打开 **Trendz Settings** 页面。

若看到 **"Synchronization completed successfully"** 提示，说明同步已自动完成，无需进一步操作。

{% include images-gallery.html imageCollection="trendz-settings" %}

若出现错误提示，请按以下步骤排查：

* 确认 **Trendz 正在运行**。
* 填写正确的 **Trendz internal URL**，且 ThingsBoard 服务可访问。
* 填写正确的 **ThingsBoard internal URL**，且 Trendz 服务可访问。
* 点击 **Save configuration**。
* 点击 **Retry discovery**。

当出现 **"Synchronization completed successfully"** 后，同步即完成。

{% include images-gallery.html imageCollection="trendz-sync" %}
