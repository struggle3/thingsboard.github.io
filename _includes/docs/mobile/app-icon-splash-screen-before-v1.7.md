{% if docsPrefix == 'pe/' %}
{% assign peDocsPrefix = "pe/" %}
{% else %}
{% assign peDocsPrefix = "" %}
{% endif %}
* TOC
{:toc}

### 启动画面

1.7.0之前的版本无法更改启动画面。它将默认使用应用图标。

### 应用图标

Flutter应用带有默认启动图标。要使用自定义图标替换，请遵循以下说明：

#### 步骤1：添加flutter_launcher_icons插件

通过命令行将flutter_launcher_icons插件添加到项目：

```bash
flutter pub add dev:flutter_launcher_icons
```
{: .copy-code}
#### 步骤2：替换默认图标

用您的自定义图标替换`assets/images`文件夹中的`thingsboard.png`。我们建议使用432×432像素的Logo图像，在画布内居中。

#### 步骤3：运行生成器

执行生成器以应用新图标：

```bash
flutter pub run flutter_launcher_icons
```
{: .copy-code}

#### 步骤4：更新通知图标（可选）

如果您已配置推送通知（参见[推送通知设置指南](/docs/{{docsPrefix}}mobile/getting-started/#step-2-optional-configure-push-notifications)），我们建议同时更新通知图标。

1. 访问[Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/icons-notification.html)
2. 点击"Image"并选择您的Logo
3. 根据需要配置padding
4. 将文件名更改为"thingsboard"
5. 点击下载按钮获取"res"文件夹的归档
6. 将内容粘贴到`android/app/src/main`，出现提示时点击"Replace"

<div style="display: flex; flex-direction: row;">
    <div style="display: flex; flex-direction: column; align-items: center;">
        <img width="" src="/images/mobile/asset_studio.png" title="Android asset studio流程" alt="Android asset studio flow">
    </div>
</div>

{% capture pre_version_note %}
**注意：**1.7.0之前版本的自定义选项有限。建议升级到1.7.0+版本以获得完整品牌能力。
{% endcapture %}
{% include templates/info-banner.md content=pre_version_note %}
