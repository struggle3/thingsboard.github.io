{% assign feature = "White labeling" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

白标功能让您可以根据品牌和偏好定制 ThingsBoard 实例——特别适合向客户提供 IoT 解决方案的公司。

设置公司或产品名称、上传 Logo、选择配色方案、使用自定义菜单或翻译——无需编写代码或重启服务即可完成。

<br><b><font size="4">实用视频课程 🎥</font></b>

观看此实用视频课程，按步骤了解如何个性化IoT平台的外观和体验。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/jSXuHj3lbG0" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 基础与继承

白标配置基于您当前登录的层级：
{% unless docsPrefix contains "paas/" %}- **系统管理员级** —— 为所有租户及其客户设置平台默认品牌。{% endunless %}
- **租户级** —— 继承系统品牌，并可为指定租户及其客户覆盖。
- **客户级** —— 继承租户品牌，并可为该客户及其用户自定义 UI。

**继承关系：** System → Tenant → Customer。下级可在其范围内覆盖设置。

## Customize ThingsBoard web interface

{% capture difference %}
**请注意：** 配置 **白标** 需要相应的[权限](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

要配置公司或产品 **Logo** 和 **配色方案**，请前往「白标」页面。

{% include images-gallery.html imageCollection="white-labeling-default" %}

在「常规」选项卡中可设置或修改以下选项：

 - 应用标题 - 可指定自定义页面标题，显示在浏览器标签页中；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/white-labeling/application-title.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/white-labeling/application-title-paas.png)
{% endif %}

 - Favicon（网站图标）- 可将默认网站图标改为您自己的图标；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/white-labeling/website-icon.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/white-labeling/website-icon-paas.png)
{% endif %}

 - Logo - 可将左上角标准 Logo 替换为公司 Logo；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/white-labeling/logo.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/white-labeling/logo-paas.png)
{% endif %}

 - Logo 高度 - 可调整 Logo 尺寸；
 - 白标允许您通过调整主色和强调色板来自定义配色主题，以符合您期望的 UI 设计。

    - 主色板 - 可选择建议的 UI 设计选项之一或自定义现有选项来设置背景色和字体颜色；

    ![image](/images/user-guide/white-labeling/primary-palette.png)

    - 强调色板 - 可为部分元素（如开关）自定义颜色；

    ![image](/images/user-guide/white-labeling/accent-palette.png)

 - 高级 CSS - 可按需美化 ThingsBoard 用户界面的任意元素。更多说明见[下文](#advanced-css)；
 - 覆盖 Trendz 分析插件名称 - 勾选后，分析插件名称将在整个平台中由 Trendz 覆盖为「高级分析」。
 - 显示/隐藏平台名称和版本 - 勾选后，平台名称及当前版本将显示在左下角。

![image](/images/user-guide/white-labeling/show-platform-name-and-version.png)

自定义用户界面的最终效果：

{% include images-gallery.html imageCollection="white-labeling-custom" %}

### 高级 CSS

使用 CSS 可按需美化 ThingsBoard 用户界面的任意元素，如背景、图标、字体等。

在 UI 设计中使用 CSS 的步骤：

{% include images-gallery.html imageCollection="advanced-css-1" showListImageTitles="true" %}

<br>
自定义图标颜色和滚动条颜色的 CSS 示例：

```css
/*icon color*/

.mat-icon.notranslate.material-icons.mat-ligature-font.mat-icon-no-color.ng-star-inserted{
    fill: #a60062;
    color: #a60062;
}
.mat-icon.notranslate.mat-icon-no-color.ng-star-inserted{
    fill: #a60062;
}

/*scroll color*/

mat-toolbar::-webkit-scrollbar-thumb,
div::-webkit-scrollbar-thumb,
ng-component::-webkit-scrollbar-thumb {
    background-color: #c526a5 !important;
    background-image: linear-gradient(#e72c83, #a742c6);
    border-radius: 200px/300px !important;
    border: 0.1rem linear-gradient(#e72c83, #a742c6);
}

.mat-mdc-button.mat-mdc-button-base.tb-active{
    color: #ffffff;
}
```
{: .copy-code}

再为左侧菜单添加渐变效果：

{% include images-gallery.html imageCollection="advanced-css-2" showListImageTitles="true" %}

自定义侧边栏菜单外观的 CSS 示例：

```css
/*menu gradient*/

.tb-side-menu {
    background: linear-gradient(44deg, #9d9d9d, #ffffff, #9f9f9f);
}
```
{: .copy-code}

使用本文档介绍的功能，您可以根据自身偏好自定义 ThingsBoard UI 的外观。

## 自定义登录页

在「登录」选项卡中，可为客户配置 **登录页**。

- 输入已注册的域名，或参阅[本文档](/docs/{{docsPrefix}}domains/#domain-registration){:target="_blank"}了解如何注册新域名；
- 建议禁用从请求头读取主机名的用法；
- 输入自定义应用标题；
- 将默认网站图标和 Logo 替换为您自己的；
- 定义主色和强调色板；
- 设置页面背景色。

完成后保存更改。

{% include images-gallery.html imageCollection="customize-login-page" %}

<br>
使用自定义域名访问 ThingsBoard  Web 界面登录页，验证配置结果。

{% include images-gallery.html imageCollection="verify-result-customize-login-page" %}

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
