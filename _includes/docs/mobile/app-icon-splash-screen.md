{% if docsPrefix == 'pe/' %}
{% assign peDocsPrefix = "pe/" %}
{% else %}
{% assign peDocsPrefix = "" %}
{% endif %}
* TOC
{:toc}

## 概述

**应用图标**是显示在用户设备主屏幕、应用抽屉和其他系统界面上的应用视觉标识。

**启动画面**是应用启动时显示的初始屏幕，通常显示Logo或品牌标识，同时应用正在加载。

对于1.7.0及更高版本，您需要若干资源才能完全自定义应用。您将在`assets/branding`文件夹中找到所需资源的默认示例。

{% capture pre_1_7_0_link %}
重要提示：请使用[本指南](/docs/{{peDocsPrefix}}mobile/app-icon-splash-screen-before-v1.7/)进行1.7.x之前的配置
{% endcapture %} {% include templates/info-banner.md content=pre_1_7_0_link %}


### 所需资源

完整自定义需要以下资源：

| 资源 | 规格 | 说明 |
|-------|---------------|-------------|
| `icon_filled.png` | 512×512像素 | 带背景色的填充图标 |
| `icon_foreground.png` | 438×438像素，透明背景 | 前景图标元素 |
| `icon_monochrome.png` | 438×438像素，透明背景，纯色 | 主题图标用的单色版本 |
| `splash_android_12.png` | 可变尺寸 | Android 12+的启动画面 |
| `splash.png` | 320×320像素 | 通用启动画面Logo |

#### Android 12启动画面图标
根据您希望的启动画面外观，选择以下选项之一。

**无背景的启动画面图标**
- 尺寸：1152×1152像素
- 必须适配768像素直径的圆形内

**带背景的启动画面图标：**
- 尺寸：960×960像素
- 必须适配640像素直径的圆形内

<div style="display: flex; flex-direction: row;">
    <div style="display: flex; flex-direction: column; align-items: center;">
        <img width="" src="/images/mobile/pe/splash_screen_sizes_template.png" title="启动画面图标布局" alt="Splash screen icon layout">
        <span style="margin-top: 16px; font-size: 90%; color: #6c757d;">启动画面图标布局</span>
    </div>
</div>
### 设置说明

替换`assets/branding`文件夹中的所有图像，同时保持相同的文件名，使用您自己的资源。

### 应用图标配置

您可查阅[flutter_launcher_icons文档](https://pub.dev/packages/flutter_launcher_icons)获取更详细的应用图标设置信息。

`pubspec.yaml`中的配置：

```yaml
flutter_launcher_icons:
  ### android config
  android: "launcher_icon"
  # fallback android icon
  image_path_android: "assets/branding/icon_filled.png"
  # icon config for android 13+
  adaptive_icon_background: "#ffffff"
  adaptive_icon_foreground: "assets/branding/icon_foreground.png"
  adaptive_icon_foreground_inset: 16
  adaptive_icon_monochrome: "assets/branding/icon_monochrome.png"
  ###
  ### ios config
  ios: true
  # fallback ios icon
  image_path_ios: "assets/branding/icon_foreground.png"
  background_color_ios: "#ffffff"
  desaturate_tinted_to_grayscale_ios: true
  remove_alpha_ios: true
  # ios 18+ icon
  image_path_ios_dark_transparent: "assets/branding/icon_foreground.png"
```

#### 配置选项

**`background_color_ios: "#ffffff"`**
iOS图标背景的十六进制颜色。

**`adaptive_icon_background: "#ffffff"`**
Android图标背景的十六进制颜色。

**`adaptive_icon_foreground_inset: 16`**
图标框架内图像的padding。先尝试默认值，然后按需调整：
- 如果Logo在图标框架内放不下，增大该值
- 如果显得太小，减小该值

#### 自定义背景图像和不同平台资源

默认情况下，移动应用配置为iOS和Android使用同一图标，以及使用纯色作为图标背景。您可以通过修改配置文件和添加额外资源来更改此设置。

如果您希望图标具有特定背景图像而非纯色：

**iOS：**
1. 将带背景的438×438像素Logo图像添加到`assets/branding`文件夹。这样您也可以为iOS和Android设置不同Logo。
2. 更新`image_path_ios`行：
   ```yaml
   image_path_ios: "assets/branding/your_custom_ios_logo.png"
   ```

**Android：**
1. 创建438×438像素的背景图像并添加到`assets/branding`文件夹
2. 更新`adaptive_icon_background`行：
   ```yaml
   adaptive_icon_background: "assets/branding/your_android_background.png"

### 启动画面配置

在`flutter_native_splash.yaml`中添加以下配置：

```yaml
flutter_native_splash:
  color: "#ffffff"
  image: assets/branding/splash.png
  android_12:
    image: assets/branding/splash_android_12.png
    color: "#ffffff"
    icon_background_color: "#ffffff"
  android: true
  ios: true
```

您可通过更新`color`和`icon_background_color`属性自定义启动画面背景色和Android 12+图标背景。

{% capture splash_config_note %}
**注意：**flutter_native_splash有大量配置选项。我们建议阅读[官方文档](https://pub.dev/packages/flutter_native_splash)了解所有可用功能和限制。
{% endcapture %}
{% include templates/info-banner.md content=splash_config_note %}

### 应用设置

配置资源和设置后，运行以下命令应用更改：

**应用图标设置：**
```bash
dart run flutter_launcher_icons
```
{: .copy-code}

**应用启动画面设置：**
```bash
dart run flutter_native_splash:create
```
{: .copy-code}
