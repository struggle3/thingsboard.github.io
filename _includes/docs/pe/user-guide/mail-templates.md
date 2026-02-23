{% assign feature = "Mail Settings" %}{% include templates/pe-feature-banner.md %} 

* TOC
{:toc}

## 简介

ThingsBoard 使用邮件模板在特定事件发生时向用户发送邮件通知。
例如，账户激活或密码重置的邮件。

{% capture difference %}
**注意**
<br>
要通过 Email 发送消息，租户管理员需配置[发件服务器](/docs/user-guide/ui/mail-settings/)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

ThingsBoard 提供带示例内容的默认系统邮件模板，可从列表中单独自定义。

操作步骤：
 - 前往「**白标**」页面 ->「**邮件模板**」选项卡；

![image](/images/user-guide/white-labeling/mail-templates-1.png)

 - 取消勾选「**使用系统邮件模板**」； 
 - 从下拉列表选择要编辑的**邮件模板**；
 - 编辑**邮件主题**和**邮件正文**； 
 - 保存更改。

![image](/images/user-guide/white-labeling/mail-templates-2.png)

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}