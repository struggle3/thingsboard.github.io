
* TOC
{:toc}

## 用户概览

在ThingsBoard中，**用户**是具备平台访问凭证的实体。

ThingsBoard支持三级角色体系：

1) **系统管理员**
- 拥有整个平台实例的完整访问权限。
- 可创建和管理租户管理员。

2) **租户管理员**
- 对特定租户环境拥有完全控制权。
- 可创建和管理：
  - 客户
  - 客户用户
- 负责为仪表板、设备、资产及其他资源分配访问权限。

3) **客户用户**
- 仅能查看租户管理员分配给的仪表板、实体及其数据。
- 无法创建其他客户或子客户。

{% capture difference %}
**重要：**
<br>
在ThingsBoard专业版中，客户可创建其他客户用户和子客户。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

以下说明如何在各级添加用户。

### 系统管理员

若您是**系统管理员**，可通过以下步骤在[租户](/docs/{{docsPrefix}}user-guide/ui/tenants)中创建用户。

1. 在左侧菜单进入租户，选择租户管理员，点击加号图标添加新用户。

   ![image](/images/user-guide/ui/users/ce/tenant-user-add.png)

2. 在添加用户窗口中填写邮箱并选择激活方式。
系统管理员也可选填姓名和描述。填写完成后点击添加。

   ![image](/images/user-guide/ui/users/ce/user-add-window.png)

3. 若选择**激活链接**方式，点击箭头复制链接，在浏览器中打开或发送至用户使用的即时通讯工具。下方为激活链接示例。

   ![image](/images/user-guide/ui/users/ce/user-activation-link.png)

4. 若选择**发送激活邮件**，需查收邮箱中关于ThingsBoard账户激活的邮件。
点击激活账户，按提示完成密码创建。

   ![image](/images/user-guide/ui/users/ce/account-activation-email.png)

{% capture difference %}
**注意：**
<br>
要接收ThingsBoard发送的邮件，需事先在系统管理员层面配置邮件服务器。
请参阅[邮件设置](/docs/{{docsPrefix}}user-guide/ui/mail-settings)说明。
{% endcapture %}
{% include templates/info-banner.md content=difference %}


用户创建完成后，系统管理员可使用租户详情页的操作标签。

操作包括：

1) **禁用用户账户**。

2) **显示激活链接**：显示租户管理员用户的激活链接。

3) **重新发送激活**：向用户邮箱重新发送账户激活邮件。

4) **以租户管理员身份登录**：从租户管理员界面打开ThingsBoard平台。

5) 系统管理员还可从租户用户列表中**删除**租户管理员。

   ![image](/images/user-guide/ui/users/ce/user-tenant-tabs.png)

管理员点击禁用用户账户后，左上角会提示用户账户已成功禁用，标签会变为「启用用户账户」。
如图所示。

   ![image](/images/user-guide/ui/users/ce/user-account-disabled.png)

若被禁用账户的用户尝试访问平台，会看到以下错误提示。

   ![image](/images/user-guide/ui/users/ce/error-message.png)

同样，管理员点击启用用户账户后，左上角会提示用户账户已成功启用，标签会变为「禁用用户账户」。如图所示。

   ![image](/images/user-guide/ui/users/ce/user-account-enabled.png)

### 租户管理员

作为**租户管理员**，可通过以下步骤添加新用户。

1. 进入客户，选择客户用户，点击加号图标添加新用户。 

   ![image](/images/user-guide/ui/users/ce/customer-user-add.png)

2. 在添加用户窗口中填写邮箱并选择激活方式。
租户管理员可选填姓名和描述。完成后点击添加。

   ![image](/images/user-guide/ui/users/ce/customer-user-add-window.png)

3. 用户创建后，租户管理员可使用用户详情页的操作标签。 

They are as follows:

1) **禁用用户账户**。禁用方法如上所述。  

2) **显示激活链接**：显示客户用户的激活链接。

3) **重新发送激活**：向用户邮箱重新发送账户激活邮件。 

4) **以客户用户身份登录**：租户管理员可从用户界面打开ThingsBoard平台。 

5) 租户管理员也可从客户列表中**删除**该客户用户’ 

   ![image](/images/user-guide/ui/users/ce/customer-user-account-disable.png)

租户管理员可选择性分配默认仪表板并设置全屏模式，如图所示。


   ![image](/images/user-guide/ui/users/ce/default-dashboard-assigned.png)

同样，租户管理员可选择性为客户用户分配主页仪表板并隐藏仪表板工具栏，如图所示。


   ![image](/images/user-guide/ui/users/ce/home-dashboard-assigned.png) 

**重要**：无需同时分配默认仪表板和主页仪表板，因为用户登录后首先看到的将是默认仪表板。

如有疑问，可点击右上角的问号图标。

### 客户用户界面

#### 默认仪表板作为首页

客户用户登录后首先看到的是默认仪表板。若租户管理员设置了全屏默认仪表板，客户用户将看到无左侧菜单的仪表板，如下例所示。
仪表板工具栏始终可用，用户可切换到已分配的其他仪表板，并自行设置实时时间范围。
此外，还可导出该仪表板。

   ![image](/images/user-guide/ui/users/ce/default-dashboard.png) 


若未勾选全屏模式，客户用户可通过左侧菜单切换查看租户管理员分配的全部资产、设备、实体、边缘和仪表板。
仪表板示例如下。

   ![image](/images/user-guide/ui/users/ce/default-dashboard-not-fullscreen-1.png) 


#### 主页仪表板作为首页

若租户管理员将某仪表板设为主页仪表板，客户用户将在其首页看到该仪表板。
若勾选「隐藏主页仪表板工具栏」，客户用户将看到无工具栏的主页仪表板。
禁用工具栏的仪表板如下所示。

  ![image](/images/user-guide/ui/users/ce/home-dashboard-no-toolbar.png)    

启用工具栏的仪表板如图所示。用户可设置实时时间范围并导出仪表板。


   ![image](/images/user-guide/ui/users/ce/home-dashboard-toolbar.png)

客户用户也可在个人资料设置中选择性隐藏主页仪表板工具栏或更改主页仪表板。
   
   ![image](/images/user-guide/ui/users/ce/profile-window.png)  

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}