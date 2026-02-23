* TOC
{:toc}

MQTT Client Credentials 用于为系统中连接的客户端配置安全措施。

要在系统中创建新的客户端凭据，必须先以 Admin 用户身份认证。
该授权过程赋予您执行管理任务所需的权限和访问权。

以 Admin 用户身份认证后，您将有权创建和管理客户端凭据，
从而可为连接到系统的客户端实施可靠的安全措施。
该方法确保系统安全，仅有授权客户端可建立连接并与 TBMQ 交互。

{% include templates/mqtt-broker/authentication.md %}

## 创建/更新 MQTT Client Credentials

**MQTT_BASIC** 凭据示例：

```bash
curl --location --request POST 'http://localhost:8083/api/mqtt/client/credentials' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "testCreds",
    "credentialsType":"MQTT_BASIC",
    "credentialsValue":"{ \"clientId\": null, \"userName\": \"test_user\", \"password\": \"test_pass\", \"authRules\": { \"pubAuthRulePatterns\": [\"test\/.*\"], \"subAuthRulePatterns\": [\"my\/.*\"] } }"
}'
```
{: .copy-code}

实施上述配置后，username 为 **test_user**、password 为 **test_pass** 的客户端将能成功登录系统。
但需注意，这些客户端将根据指定的主题访问权限受到限制。

使用这些凭据认证的客户端仅能发布到以 _test/_ 开头的主题。
此外，仅能订阅以 _my/_ 开头的主题。
该配置确保客户端访问被限制在特定主题模式内，从而维持受控且安全的环境。

**SSL** 凭据示例：

```bash
curl --location --request POST 'http://localhost:8083/api/mqtt/client/credentials' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "testSSLCreds",
    "credentialsType":"X_509",
    "credentialsValue":"{ \"certCnPattern\": \"Root Common Name\", \"certCnIsRegex\": false, \"authRulesMapping\": { \"test\": { \"pubAuthRulePatterns\": [\"test_ssl\/.*\"], \"subAuthRulePatterns\": [\"test_ssl\/.*\"] } } }"
}'
```
{: .copy-code}

```bash
curl --location --request POST 'http://localhost:8083/api/mqtt/client/credentials' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "testSSLCredsWithPattern",
    "credentialsType":"X_509",
    "credentialsValue":"{ \"certCnPattern\": \".* Pattern Common Name .*\", \"certCnIsRegex\": true, \"authRulesMapping\": { \"test\": { \"pubAuthRulePatterns\": [\"test_ssl\/.*\"], \"subAuthRulePatterns\": [\"test_ssl\/.*\"] } } }"
}'
```
{: .copy-code}

其中：
- **certCnPattern** - 证书链中应存在的 common name 匹配模式。
- **certCnIsRegex** - 控制 common name (CN) 模式是否作为正则表达式 (regex) 进行匹配。
- **authRulesMapping** - 将客户端 CN 中提取的 keyword 映射到授权规则的规则（允许客户端仅发布和订阅特定主题）。

采用上述配置后，使用 X.509 Certificate chain 连接的客户端将根据特定条件被允许登录。
第一种情况中 X.509 Certificate chain 的证书 CN 应与 _Root Common Name_ 精确匹配，
第二种情况应与 _.* Pattern Common Name .*_ 匹配，且证书的 CN 应包含字符串 _test_。
使用这些凭据认证后，客户端将获得限于以 _test_ssl/_ 开头主题的发布和订阅权限。

## 获取所有 MQTT Client Credentials

```bash
curl --location --request GET 'http://localhost:8083/api/mqtt/client/credentials?pageSize=100&page=0' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}
**注意**，_pageSize_ 参数为 100、_page_ 参数为 0，因此上述请求将获取前 100 个 MQTT 客户端凭据。

## 删除 MQTT Client Credentials

```bash
curl --location --request DELETE 'http://localhost:8083/api/mqtt/client/credentials/$CREDENTIALS_ID' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

将 _$CREDENTIALS_ID_ 替换为要删除的 MQTT 客户端凭据的实际 ID。
