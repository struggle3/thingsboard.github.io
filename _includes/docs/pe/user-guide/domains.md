{% if docsPrefix == null %}
{% assign THINGSBOARD_WITH_URL = "[ThingsBoard CE](/docs/user-guide/install/installation-options/)" %}
{% assign THINGSBOARD_HOST = "IP address" %}
{% assign THINGSBOARD_URL = "ThingsBoard" %}
{% endif %}
{% if docsPrefix == "pe/" %}
{% assign THINGSBOARD_WITH_URL = "[ThingsBoard PE](/docs/user-guide/install/pe/installation-options/)" %}
{% assign THINGSBOARD_HOST = "IP address" %}
{% assign THINGSBOARD_URL = "ThingsBoard" %}
{% endif %}
{% if docsPrefix == "paas/" %}
{% assign THINGSBOARD_WITH_URL = "[ThingsBoard Cloud](https://thingsboard.cloud/signup)" %}
{% assign THINGSBOARD_HOST = "thingsboard.cloud" %}
{% assign THINGSBOARD_URL = "ThingsBoard Cloud" %}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
{% assign THINGSBOARD_WITH_URL = "[EU ThingsBoard Cloud](https://eu.thingsboard.cloud/signup)" %}
{% assign THINGSBOARD_HOST = "eu.thingsboard.cloud" %}
{% assign THINGSBOARD_URL = "EU ThingsBoard Cloud" %}
{% endif %}

* TOC
{:toc}

{% if docsPrefix == null or docsPrefix == "pe/" %}
{{THINGSBOARD_WITH_URL}}{:target="_blank"} {% unless docsPrefix == null %}[白标](/docs/{{docsPrefix}}user-guide/white-labeling/){:target="_blank"} 功能{% endunless %}支持使用自定义域名提供安全访问。
需配置 HAProxy 负载均衡器并配置 SSL 证书。[本文档](/docs/user-guide/install/pe/add-haproxy-ubuntu/){:target="_blank"}可协助完成配置。
配置完成后，可通过自定义域名使用 HTTPS 安全访问 ThingsBoard 平台。
{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{{THINGSBOARD_WITH_URL}}{:target="_blank"} [白标](/docs/{{docsPrefix}}user-guide/white-labeling/){:target="_blank"} 功能支持使用自定义域名提供个性化主机名供用户访问。
注册有效域名后，{{THINGSBOARD_URL}} 会自动申请 SSL 证书并负责后续续期。
域名注册完成后，可通过域名使用 HTTPS 安全访问平台。 
该功能主要用于 Web UI 访问，MQTT、CoAP 等传输服务可能无法通过自定义域名使用。
{% endif %}

## 域名注册

{% capture domain_owner_note %}
**注意：** 您必须是所注册域名的所有者。
{% endcapture %}
{% include templates/info-banner.md content=domain_owner_note %}

要使用自己的主机名代替 **{{THINGSBOARD_HOST}}**，需先完成注册。请按以下步骤操作：

首先，在 DNS 服务商网站上添加域名的规范记录，将其映射到 eu.thingsboard.cloud{% if docsPrefix == "pe/" %}，并添加 **SSL 证书**{% endif %}。详见[如何为域名创建 CNAME 记录](#how-to-create-a-cname-record)。

完成后即可开始添加域名的流程。 

## 添加域名

{% capture domain_owner_note %}
{% if docsPrefix == "pe/" %} 自 ThingsBoard 3.9.0 起，可在租户级和客户级添加自有域名。{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}可在租户级和客户级注册自有域名。{% endif %}
{% endcapture %}
{% include templates/info-banner.md content=domain_owner_note %}

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
- 登录您的 {{THINGSBOARD_WITH_URL}}{:target="_blank"} 账户；
{% endif %}
{% if docsPrefix == null %}
- 以系统管理员身份登录 {{THINGSBOARD_WITH_URL}}{:target="_blank"} 账户；
{% endif %}

{% include images-gallery.html imageCollection="register-domain" showListImageTitles="true" %}

## 使用所选域名登录

现在可以使用域名访问 {{THINGSBOARD_URL}} Web 界面和服务。在浏览器地址栏输入所选域名进行登录。

{% include images-gallery.html imageCollection="login-with-domain" %}

## 域名详情

查看已注册域名的详情时，点击该域名即可打开域名详情对话框。
{% unless docsPrefix == 'pe/' %} 该对话框显示已注册域名的 CNAME 记录及已签发的「SSL 证书」详情，包括当前有效期（*Not before* 和 *Not after*）。{% endunless %}

{% unless docsPrefix == 'pe/' %}
SSL 证书有效期为 90 天，{{THINGSBOARD_URL}} 会在到期前至少 30 天自动续期。
除非您修改或删除域名的 CNAME 记录，否则无需任何操作。
{% endunless %}

{% include images-gallery.html imageCollection="domain-details" %}

## 删除域名

删除{% unless docsPrefix == 'pe/' %}已注册的{% endunless %}域名时，点击要删除域名行中的「trash」图标。在确认对话框中，若确认删除则点击「Yes」。

{% include images-gallery.html imageCollection="delete-domain" %}

确认后，域名信息及关联的 SSL 证书将被删除，无法再通过该域名访问 {{THINGSBOARD_URL}} Web 界面和服务。
可随时按[域名注册](#domain-registration)流程重新注册同一或不同域名。

## 如何为域名创建 CNAME 记录 {#how-to-create-a-cname-record}

添加 CNAME 记录到 DNS 数据库的步骤因 DNS 服务商而异。以下为常用 DNS 服务商的说明链接：

* [Amazon Route 53](https://aws.amazon.com/premiumsupport/knowledge-center/route-53-create-alias-records/){:target="_blank"}
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

若以上列表中没有您使用的 DNS 服务商，请在其官网查找或联系其技术支持。

## 故障排查

首先确认域名的 CNAME 是否已正确添加：

若为 Linux 系统，可使用 [Google Admin Toolbox](https://toolbox.googleapps.com/apps/dig/){:target="_blank"} 或「dig」命令：
```bash
dig $YOUR_DOMAIN_NAME any
```
{: .copy-code}

将 $YOUR_DOMAIN_NAME 替换为您的域名。

例如，$YOUR_DOMAIN_NAME 为 `mycompany.thingsboard.space`：
```bash
dig mycompany.thingsboard.space any
```

Linux 中的「dig」命令用于获取 DNS 信息，全称为 Domain Information Groper，可收集域名服务器相关数据。「dig」可用于诊断 DNS 问题，也可用于显示 DNS 信息。

「dig」命令的输出会因域名配置而异。
For example:
```bash
$ dig mycompany.thingsboard.space any

; <<>> DiG 9.16.1-Ubuntu <<>> mycompany.thingsboard.space any
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27275
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;mydomain.thingsboard.online.	IN	ANY

;; ANSWER SECTION:
mycompany.thingsboard.space. 3600 IN	HINFO	"RFC8482" ""

;; Query time: 36 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: чт чер 29 15:36:44 EEST 2023
;; MSG SIZE  rcvd: 77
```

该输出表明 mycompany.thingsboard.space 域名未添加 CNAME（「ANSWER SECTION」块）。

正确的输出示例：
```bash
...
;; ANSWER SECTION:
mycompany.thingsboard.space. 3600 IN	CNAME	eu.thingsboard.cloud
...
```

若配置无误但问题仍存在，请[联系我们](https://thingsboard.io/docs/contact-us/){:target="_blank"}获取支持。

## 下一步

{% if docsPrefix == null %}
{% assign feature = "White labeling" %}{% include templates/pe-feature-banner.md %}
{% endif %}

了解如何自定义 ThingsBoard 登录页和用户界面、配置公司或产品 Logo、调整配色方案，请前往[白标](/docs/{{docsPrefix}}user-guide/white-labeling/){:target="_blank"}章节。