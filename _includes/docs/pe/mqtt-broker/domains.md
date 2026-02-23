* TOC
{:toc}

按照[安装选项指南](/docs/pe/mqtt-broker/install/installation-options/)完成**TBMQ PE**安装后，默认可通过公共**IP 地址**或云负载均衡器的**DNS 记录**访问实例。
配置**自定义域名**具有以下优势：

* **简化访问**：用户可使用易记的主机名登录，而无需使用 IP 或负载均衡器 DNS 名称。
* **安全的 SSL 连接**：域名支持使用受信任的 SSL/TLS 证书。
* **白标**：TBMQ 根据域名对登录页应用自定义品牌（徽标、标题和颜色）。每个 TBMQ 部署仅支持一套登录页品牌配置，域名可简化配置管理。
* **OAuth 2.0 / SSO 集成**：多域名支持为各认证提供商分别配置登录。

## 域名注册

{% capture domain_owner_note %}
**注意：**您必须对所注册域名拥有所有权。
{% endcapture %}
{% include templates/info-banner.md content=domain_owner_note %}

在 TBMQ 中使用自有主机名前，需先配置 DNS，再在 TBMQ 内注册域名。

### 步骤 1. 配置 DNS

在 DNS 服务商网站：

* 添加 **A 记录**（或 **CNAME 记录**）将域名解析至 TBMQ 所在 IP 或主机名。

    * 参见[如何创建 A 记录](#how-to-create-an-a-record-for-your-domain)
    * 或[如何创建 CNAME 记录](#how-to-create-a-cname-record-for-your-domain)

* 为所选域名配置有效的 **SSL 证书**。

### 步骤 2. 在 TBMQ 中注册域名

* 登录您的 **TBMQ PE** 账户。

{% include images-gallery.html imageCollection="register-domain" showListImageTitles="true" %}

## 使用域名登录

注册成功后，可使用已配置域名访问 TBMQ 实例。
在浏览器地址栏输入域名，应能看到 TBMQ 登录页。

{% include images-gallery.html imageCollection="login-with-domain" %}

## 查看域名详情

点击已注册域名即可打开域名详情对话框。

{% include images-gallery.html imageCollection="domain-details" %}

## 删除域名

点击要删除域名所在行的“垃圾桶”图标。在确认对话框中，确认删除后点击“是”。

{% include images-gallery.html imageCollection="delete-domain" %}

## 如何为域名创建 A 记录 {#how-to-create-an-a-record-for-your-domain}

### 什么是 A 记录？

**A 记录（地址记录）**将域名直接指向**IPv4 地址**。
用于告知 DNS 解析器服务器的位置。

**示例：**

```
mqtt.mycompany.com → 203.0.113.45
```

### 何时使用 A 记录

当 TBMQ 实例具有**固定公共 IP 地址**时使用 A 记录，例如 VM、Kubernetes 服务或本地服务器。

### 如何创建 A 记录

具体步骤取决于 DNS 服务商，请参阅其文档：

* [Amazon Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-values.html){:target="_blank"}
* [GoDaddy](https://www.godaddy.com/help/add-an-a-record-19238){:target="_blank"}
* [Cloudflare](https://developers.cloudflare.com/dns/manage-dns-records/how-to/create-dns-records/){:target="_blank"}
* [ClouDNS](https://www.cloudns.net/wiki/article/10/){:target="_blank"}
* [Google Cloud DNS](https://cloud.google.com/dns/docs/records){:target="_blank"}
* [Name.com](https://www.name.com/support/articles/115004893508-adding-an-a-record){:target="_blank"}
* [DNSimple](https://support.dnsimple.com/articles/manage-a-record/){:target="_blank"}
* [Infoblox NIOS](https://docs.infoblox.com/space/BloxOneDDI/186811892/Creating+A+Record){:target="_blank"}
* [Namecheap](https://www.namecheap.com/support/knowledgebase/article.aspx/434/2237/how-do-i-set-up-host-records-for-a-domain/){:target="_blank"}

若未列出您的服务商，请查阅其文档或联系技术支持。

## 如何为域名创建 CNAME 记录 {#how-to-create-a-cname-record-for-your-domain}

### 什么是 CNAME 记录？

**CNAME（规范名称记录）**将域名映射到另一域名。
相当于**别名**，允许多个域名或子域名指向同一主机名。

**示例：**

```
mqtt.mycompany.com → broker.mycompany.net
```

### 何时使用 CNAME 记录

下列情况使用 CNAME 记录：

* 需将多个域名（如 `mqtt.mycompany.com`、`iot.mycompany.com`）解析到同一主机。
* 服务器 IP 可能变化，但目标域名保持不变。
* 希望通过仅维护一个 A 记录（在主域名上）简化 DNS 管理。

### 如何创建 CNAME 记录

各 DNS 服务商的添加 CNAME 界面不同，可直接参考其配置指南：

* [Amazon Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-values.html){:target="_blank"}
* [GoDaddy](https://www.godaddy.com/help/add-a-cname-record-19236){:target="_blank"}
* [Cloudflare](https://community.cloudflare.com/t/how-do-i-add-a-cname-record/59){:target="_blank"}
* [ClouDNS](https://www.cloudns.net/wiki/article/13/){:target="_blank"}
* [Google Cloud DNS](https://cloud.google.com/dns/docs/records){:target="_blank"}
* [Name.com](https://www.name.com/support/articles/115004895548-adding-a-cname-record){:target="_blank"}
* [easyDNS](https://kb.easydns.com/knowledge/how-to-make-a-dns-entry/){:target="_blank"}
* [DNSimple](https://support.dnsimple.com/articles/manage-cname-record/#adding-a-cname-record){:target="_blank"}
* [DNSMadeEasy](https://support.dnsmadeeasy.com/hc/en-us/articles/34327195668507-CNAME-Record){:target="_blank"}
* [No-IP.com](https://www.noip.com/support/knowledgebase/how-to-configure-your-no-ip-hostname/){:target="_blank"}
* [Infoblox NIOS](https://docs.infoblox.com/display/BloxOneDDI/Creating+a+CNAME+Record){:target="_blank"}
* [Namecheap](https://www.namecheap.com/support/knowledgebase/article.aspx/9646/2237/how-to-create-a-cname-record-for-your-domain){:target="_blank"}

若未列出您的服务商，请查阅其文档或联系技术支持。

## 故障排查

若域名无法解析或无法访问 TBMQ，请检查 DNS 配置。

### 检查 DNS 记录

使用 [Google Admin Toolbox DIG](https://toolbox.googleapps.com/apps/dig/){:target="_blank"} 或在 Linux 上运行：

```bash
dig your-domain.com any
```
{: .copy-code}

将 `your-domain.com` 替换为实际域名。
示例：

```bash
dig mqtt.mycompany.com any
```

### 查看输出

若未出现 `ANSWER SECTION`，说明记录未正确添加。
例如以下输出表示**未找到记录**：

```bash
;; ANSWER SECTION:
mqtt.mycompany.com. 3600 IN HINFO "RFC8482" ""
```

正确记录应类似：

```bash
;; ANSWER SECTION:
mqtt.mycompany.com. 3600 IN CNAME broker.mycompany.net.
```

若使用 A 记录：

```bash
;; ANSWER SECTION:
mqtt.mycompany.com. 3600 IN A 203.0.113.45
```

### 联系技术支持

若配置看似正确但问题仍存在，请[联系我们](https://thingsboard.io/docs/pe/mqtt-broker/help/){:target="_blank"}获取帮助。
