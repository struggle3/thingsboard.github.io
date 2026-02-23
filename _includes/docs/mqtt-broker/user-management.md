* TOC
{:toc}

默认情况下，系统最初仅建立一个管理员用户，用户名为 **sysadmin@thingsboard.org**，密码为 **sysadmin**。

但在生产环境中运行时，强烈建议创建新的管理员用户，完全删除默认用户，或修改上述用户的密码。

本文档中，所有示例均使用 **curl** 命令执行 REST 请求，以展示实际的 API 调用。

{% include templates/mqtt-broker/authentication.md %}

## 获取所有用户

```bash
curl --location --request GET "http://localhost:8083/api/admin?pageSize=50&page=0" \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

系统中，每个用户实体都具有唯一标识符 **id**。
该 id 可作为引用，用于执行更新或删除用户等操作。

## 创建/更新用户

{% if docsPrefix == null %}

```bash
curl --location --request POST 'http://localhost:8083/api/admin' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "id":$USER_ID,
    "email":"test@gmail.com",
    "password":"test",
    "firstName":"test",
    "lastName":"test"
}'
```
{: .copy-code}

{% else %}

```bash
curl --location --request POST 'http://localhost:8083/api/admin' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "id":$USER_ID,
    "email":"test@gmail.com",
    "password":"test",
    "firstName":"test",
    "lastName":"test",
    "roleName": "ADMIN"
}'
```
{: .copy-code}

{% endif %}

若 _$USER_ID_ 为 _null_ 或请求体中缺少 _id_ 字段，将创建新的管理员用户，否则将更新指定 _$USER_ID_ 的用户。

## 删除用户

```bash
curl --location --request DELETE 'http://localhost:8083/api/admin/$USER_ID' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

请将 _$USER_ID_ 替换为要删除用户的实际 ID。
