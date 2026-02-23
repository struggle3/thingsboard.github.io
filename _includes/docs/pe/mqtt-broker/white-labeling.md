{% assign feature = "White labeling" %}{% include templates/mqtt-broker/pe-tbmq-feature-banner.md %}

* TOC
{:toc}

## 概述

白标功能可让您根据品牌与偏好定制 TBMQ 实例，尤其适用于向客户提供 IoT 解决方案的企业。

可设置公司或产品名称、上传徽标并选择配色方案。

## 自定义 TBMQ Web 界面

进入“白标”页面配置公司或产品**徽标**及**配色方案**。

{% include images-gallery.html imageCollection="white-labeling-default" %}

在“通用”标签页中可设置或修改以下选项：

 - 应用标题：可自定义在浏览器标签页中显示的页面标题；
 - Favicon（网站图标）：可将默认网站图标替换为自有图标；
 - 徽标：可将左上角标准徽标替换为公司徽标； 
 - 徽标高度：可调整徽标尺寸；

![image](/images/pe/mqtt-broker/user-guide/white-labeling/white-labeling-title-logo-favicon.png)

 - 白标支持通过调整主色与强调色配色以匹配 UI 设计。

    - 主色配色：可从建议的 UI 设计中选取或自定义背景色与字体颜色；
    - 强调色配色：可自定义部分元素颜色，如开关等；

    ![image](/images/pe/mqtt-broker/user-guide/white-labeling/primary-accent-palette.png)

 - 高级 CSS：可任意样式化 TBMQ 界面元素。详见[下文](#advanced-css)；
 - 显示/隐藏平台名称和版本：勾选后，平台名称及当前版本将显示在左下角。

   ![image](/images/pe/mqtt-broker/user-guide/white-labeling/show-platform-name-and-version.png)

自定义界面的最终效果：

![image](/images/pe/mqtt-broker/user-guide/white-labeling/white-labeling-custom.png)

### 高级 CSS

可通过 CSS 任意样式化 TBMQ 界面元素，如背景、图标、字体等。

在 UI 设计中使用 CSS，请按以下步骤操作：

{% include images-gallery.html imageCollection="advanced-css" showListImageTitles="true" %}

<br>
自定义图标颜色、滚动条颜色及激活按钮的 CSS 示例：

```css
/*icon color*/

a.mat-mdc-button.mat-mdc-button-base .mat-icon {
    color: #a60062;
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

/*active button color*/

.mat-mdc-button.mat-mdc-button-base.tb-active{
    color: #a60062;
}
```
{: .copy-code}

利用本文档描述的功能，可按照您的偏好自定义 TBMQ 界面外观。

## 自定义登录页

在“登录”标签页中，可配置 TBMQ **登录页**。

- 输入已注册域名，或参阅[本文档](/docs/pe/mqtt-broker/security/domains/#domain-registration){:target="_blank"}了解如何注册新域名；
- 建议禁止使用请求头中的主机名；
- 输入自定义应用标题；
- 将默认网站图标和徽标替换为自有图标；
- 定义主色与强调色配色；
- 设置页面背景色。

完成后保存更改。

{% include images-gallery.html imageCollection="customize-login-page" %}

<br>
使用自定义域名访问 TBMQ Web 界面登录页，验证配置结果。

{% include images-gallery.html imageCollection="verify-result-customize-login-page" %}
