{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}
* TOC
{:toc}

让{{appPrefix}}移动应用更易于用户使用——添加其语言到构建中或改进现有翻译。

## 支持的语言

开箱即用，{{appPrefix}}移动应用支持以下语言：

- **English**
- **Arabic**
- **Chinese (Taiwan)**
- **Chinese (Simplified)**

## 添加或改进本地化

**本地化如何工作（Flutter + ARB）**

应用从`lib/l10n`中的`.arb`文件读取本地化字符串。每个`.arb`文件代表一个语言环境（例如`intl_en.arb`表示English）。所有语言的key保持一致；value按语言环境变化。

有关Flutter国际化系统的详细信息，我们建议阅读官方[Internationalizing Flutter apps](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization){:target="_blank"}指南。

### 步骤1：打开本地化文件夹

进入项目的`lib/l10n`目录。您将看到如下文件：

```bash
intl_ar.arb
intl_en.arb
...
```

![image](/images/mobile/localization-l10n-folder.png)

### 步骤2：创建语言文件

添加使用以下格式的新`.arb`翻译文件：
```
intl_<languageCode>.arb
```

例如：
- `intl_es.arb`表示Spanish
- `intl_fr.arb`表示French
- `intl_de.arb`表示German

**提示：**如需区域特定变体，请使用BCP-47格式（例如`intl_pt_BR.arb`）。

### 步骤3：添加翻译

1. **复制**`intl_en.arb`的内容到新文件。
2. **仅翻译values**（每个key右侧的文本）为目标语言。**不要更改keys。**

示例结构：
```json
{
  "appTitle": "您的应用标题翻译",
  "login": "您的登录翻译",
  "password": "您的密码翻译"
}
```

### 步骤4：生成本地化文件

#### 如果应用版本早于1.7.0

执行命令：

```bash
flutter gen-l10n
```
{: .copy-code}

此命令将为添加的语言生成必要的本地化文件或更新现有本地化。

#### 如果应用版本为1.7.0或更高

我们建议安装**Flutter Intl扩展**，它会自动跟踪本地化更改并重新生成本地化文件。

**可用扩展：**
- [VS Code](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl){:target="_blank"}：Flutter Intl扩展
- [IntelliJ / Android Studio](https://plugins.jetbrains.com/plugin/13666-flutter-intl){:target="_blank"}：Flutter Intl插件

#### 替代方法（不使用扩展）

如果您不想安装扩展，可以使用手动方式：

1. **将intl_utils添加到项目的dev依赖：**
   ```bash
   flutter pub add -d intl_utils
   ```
   {: .copy-code}

2. **每次更改后生成本地化文件：**
   ```bash
   dart run intl_utils:generate
   ```
   {: .copy-code}

每次更改本地化文件后运行此命令，将更改集成到移动应用中。

## 测试自定义本地化

- **将设备/模拟器语言**更改为您的目标语言环境并重新启动应用。
- 如果您的语言为**从右到左**（如Arabic），请验证布局镜像和文本方向。
- 确认**复数**、**占位符**和**日期/数字格式**显示正确。

## 回馈社区

我们欢迎社区贡献以改进{{appPrefix}}移动应用本地化。

如何贡献：
- 向仓库提交**pull request**，附带您更新或新增的`.arb`文件。
- 或提交改进请求并附上`.arb`文件。

您的贡献有助于让应用面向全球用户，我们会将新的本地化全局添加到应用中，惠及所有人。

{% capture contribution_note %}
**注意：**贡献翻译时，请确保其对目标语言和地区准确且符合文化习惯。
{% endcapture %}
{% include templates/info-banner.md content=contribution_note %}
