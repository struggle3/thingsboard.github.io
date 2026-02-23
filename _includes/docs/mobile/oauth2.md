{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign appProject = "flutter_thingsboard_pe_app" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% assign appProject = "flutter_thingsboard_app" %}
{% endif %}

{{appPrefix}}移动应用支持OAuth 2.0。启用OAuth 2.0后，移动应用将在登录屏幕显示额外的登录按钮，
允许用户使用已配置的OAuth 2.0提供方进行认证。
可在**OAuth2**设置表单中由系统管理员用户配置。
详见[OAuth 2.0支持](/docs/{{docsPrefix}}user-guide/oauth-2-support/)了解通用OAuth配置。
要在移动应用中启用OAuth，您应在OAuth设置表单的**移动应用**选项卡中注册应用：

1. 以系统管理员用户身份进入**系统设置** -> **OAuth2**；
2. 展开域面板；
3. 打开**移动应用**选项卡并点击**添加应用**；
4. 指定您的应用包名（Android：您自己的唯一Application ID。iOS：Product bundle identifier。）；
5. 记住自动生成的**应用密钥**或输入您自己的密钥；
6. 最后，点击OAuth表单右下角的**保存**按钮应用更改；

{% include images-gallery.html imageCollection="oauth2" %}

此外，您需要修改移动应用常量。
在编辑器/IDE中打开**{{appProject}}**项目。编辑**lib/constants/app_constants.dart**。

将**thingsboardOAuth2AppSecret**常量的值设置为**应用密钥**字段的值。
将**thingsboardOAuth2CallbackUrlScheme**常量的值更改为某个唯一的包名，例如您可以使用应用包名加**auth**后缀（如org.mycompany.myapp.auth）：

```dart
abstract class ThingsboardAppConstants {
  ...

  static final thingsboardOAuth2CallbackUrlScheme = 'Your callback url scheme here';

  static final thingsboardOAuth2AppSecret = 'Your app secret here';
}
```

{% capture oauth_2_domain %}
**注意：****thingsBoardApiEndpoint**常量中使用的域名应与OAuth设置表单中配置的域之一匹配。
{% endcapture %}
{% include templates/info-banner.md content=oauth_2_domain %}

编辑**android/app/src/main/AndroidManifest.xml**，找到**TbWebCallbackActivity**的scheme并设置为与**thingsboardOAuth2CallbackUrlScheme**常量相同的值：

```xml
  ...
        <activity android:name=".TbWebCallbackActivity" >
            <intent-filter android:label="tb_web_auth">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="Your callback url scheme here" />
            </intent-filter>
        </activity>
  ...
```

要验证OAuth 2.0设置，请运行移动应用。
您应在登录表单顶部看到额外的OAuth 2.0登录按钮。
如果设置正确，现有用户应能仅通过OAuth 2.0登录按钮登录应用。

{% include images-gallery.html imageCollection="oauth2-login-buttons" %}

