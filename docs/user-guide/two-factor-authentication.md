---
layout: docwithnav
assignees:
- ashvayka
title: 双因素认证
description: 使用 ThingsBoard 的双因素认证

2fa-configuration:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-configure-1-ce.png
        title: '以 System administrator 登录。<br>- 进入 <b>Security</b> &#8702; <b>Two-factor authentication</b>（1）。<br>- 启用并配置一种或多种 2FA 验证方式（2）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-configure-2-ce.png
        title: '- 可选：配置 provider 相关选项（3）。<br>- 点击 <b>Save</b>。'

2fa-enforce-1:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-enforce-1-ce.png
        title: '- 以 System administrator 登录。<br>- 进入 <b>Security</b> &#8702; <b>Two-factor authentication</b>（1）。<br>- 启用 <b>Enforce two-factor authentication</b>（2）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-enforce-2-ce.png
        title: '- 选择需强制启用 2FA 的用户组（3）。'
    2:
        image: /images/user-guide/two-factor-authentication/2fa-enforce-3-ce.png
        title: '点击 <b>Save</b>（4）。'

2fa-enforce-2:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-enforce-4-ce.png
        title: '- 对 Tenant administrator 强制启用 2FA（1）。<br>- 使用 tenant/tenant profile 选择器（2）定义 2FA 范围。<br>- 指定具体 tenant 或 tenant profile（3）。列表为空时，策略适用于所有 tenant 或 tenant profile。'

2fa-password-and-authentication:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-password-and-authentication-1-ce.png
        title: '登录 ThingsBoard。<br>点击右上角用户菜单（三个点）（1）并选择「Account」（2）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-password-and-authentication-2-ce.png
        title: '进入「Security」选项卡（3）。启用一种或多种可用 2FA 方式并完成设置（4）。'

2fa-app-1:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-app-1-ce.png
        title: '启用 Authenticator 应用认证（1）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-app-2-ce.png
        title: '在手机上打开 Authenticator 应用（2），点击「Next」（3）。'
    2:
        image: /images/user-guide/two-factor-authentication/2fa-app-3-ce.png
        title: '使用验证应用扫描显示的 QR 码（4）。'
    3:
        image: /images/user-guide/two-factor-authentication/2fa-app-4-ce.png
        title: '输入应用生成的 6 位验证码（5），点击「Next」（6）。'
    4:
        image: /images/user-guide/two-factor-authentication/2fa-app-5-ce.png
        title: '点击「Done」（7）。'
    5:
        image: /images/user-guide/two-factor-authentication/2fa-app-6-ce.png
        title: '通过 Authenticator 应用的 2FA 已启用。'

2fa-app-2:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-app-7-ce.png
        title: '登录时，用户先输入邮箱和密码（1）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-app-8-ce.png
        title: '随后，用户需输入 Authenticator 应用生成的验证码（2），并点击「Continue」（3）。'

2fa-sms-1:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-sms-1-ce.png
        title: '启用 SMS 认证（1）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-sms-2-ce.png
        title: '输入有效手机号（2），点击「Send code」（3）。'
    2:
        image: /images/user-guide/two-factor-authentication/2fa-sms-3-ce.png
        title: '输入短信中的 6 位验证码（4），点击「Activate」（5）。'
    3:
        image: /images/user-guide/two-factor-authentication/2fa-sms-4-ce.png
        title: '下次登录时，用户需输入短信验证码。点击「Done」（6）。'
    4:
        image: /images/user-guide/two-factor-authentication/2fa-sms-5-ce.png
        title: 'SMS 2FA 已启用。'

2fa-sms-2:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-app-7-ce.png
        title: 'During sign-in, the user first enters their email and password (1).'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-sms-6-ce.png
        title: '随后，用户需输入短信中的验证码（2），并点击「Continue」（3）。'

2fa-email-1:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-email-1-ce.png
        title: '启用 Email 认证（1）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-email-2-ce.png
        title: '输入接收验证码的邮箱（2），点击「Send code」（3）。'
    2:
        image: /images/user-guide/two-factor-authentication/2fa-email-3-ce.png
        title: '输入邮箱中的 6 位验证码（4），点击「Activate」（5）。'
    3:
        image: /images/user-guide/two-factor-authentication/2fa-email-4-ce.png
        title: '点击「Done」（6）。'
    4:
        image: /images/user-guide/two-factor-authentication/2fa-email-5-ce.png
        title: 'Email 2FA 已启用。'

2fa-email-2:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-app-7-ce.png
        title: 'During sign-in, the user first enters their email and password (1).'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-email-6-ce.png
        title: '随后，用户需输入邮箱中收到的验证码（2），并点击「Continue」（3）。'

2fa-backup-code-1:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-backup-codes-1-ce.png
        title: '启用备用码认证（1）。'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-backup-codes-2-ce.png
        title: '下载或打印生成的备用码（2）并妥善保存。点击「Done」（3）。'
    2:
        image: /images/user-guide/two-factor-authentication/2fa-backup-codes-3-ce.png
        title: '备用码 2FA 已启用。'

2fa-backup-code-2:
    0:
        image: /images/user-guide/two-factor-authentication/2fa-app-7-ce.png
        title: 'During sign-in, the user first enters their email and password (1).'
    1:
        image: /images/user-guide/two-factor-authentication/2fa-backup-codes-4-ce.png
        title: '点击「Try another way」（2）。'
    2:
        image: /images/user-guide/two-factor-authentication/2fa-backup-codes-5-ce.png
        title: '选择「Backup code」（3）。'
    3:
        image: /images/user-guide/two-factor-authentication/2fa-backup-codes-6-ce.png
        title: '随后，用户需从备用码列表中输入有效的 8 位码（4），并点击「Continue」（5）。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/two-factor-authentication.md %}