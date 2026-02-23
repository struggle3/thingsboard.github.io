* TOC
{:toc}

## Python REST Client

ThingsBoard Python REST API Client帮助您从Python脚本与ThingsBoard REST API交互。
通过Python Rest Client可编程创建资产、设备、customers、用户及其它实体及其在ThingsBoard中的关系。

Python REST API Client的源码可[在此处](https://github.com/thingsboard/python_tb_rest_client)找到。

要安装ThingsBoard Python REST client，请使用以下命令：

```bash
pip3 install tb-rest-client
```

## 专业版Python REST Client示例

### 基本用法

脚本示例可[在此处](https://github.com/thingsboard/python_tb_rest_client/blob/master/examples/example_application_2.py)找到。
此外，需下载仪表板JSON文件（"*watermeters.json*"）并放入脚本所在目录。
JSON文件[在此处](https://github.com/thingsboard/python_tb_rest_client/blob/master/examples/watermeters.json)。

以下示例展示REST client的更高级用法：创建共享仪表板组、
从配置JSON文件加载仪表板并将该仪表板添加到先前创建的组中，
以及创建带有权限的customer并对其进行管理操作。

```python
import logging
from json import load
# Importing models and REST client class from Professional Edition version
from tb_rest_client.rest_client_pe import *
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')


# ThingsBoard REST API URL
url = "http://localhost:8080"

# Default Tenant Administrator credentials
username = "tenant@thingsboard.org"
password = "tenant"


# Creating the REST client object with context manager to get auto token refresh
def main():
    with RestClientPE(base_url=url) as rest_client:
        try:
            # Auth with credentials
            rest_client.login(username=username, password=password)

            # Getting current user
            current_user = rest_client.get_user()

            # Creating Dashboard Group on the Tenant Level
            shared_dashboards_group = EntityGroup(name="Shared Dashboards", type="DASHBOARD")
            shared_dashboards_group = rest_client.save_entity_group(shared_dashboards_group)
            logging.info('Dashboard group created:\n%r\n', shared_dashboards_group)

            # Loading Dashboard from file
            dashboard_json = None
            with open("watermeters.json", "r") as dashboard_file:
                dashboard_json = load(dashboard_file)
            dashboard = Dashboard(title=dashboard_json["title"], configuration=dashboard_json["configuration"])
            dashboard = rest_client.save_dashboard(dashboard)
            logging.info('Dashboard created:\n%r\n', dashboard)

            # Adding Dashboard to the Shared Dashboards Group
            dashboard = list(filter(lambda x: x.name == dashboard.name,
                                             rest_client.get_user_dashboards(10, 0).data))[0]
            rest_client.add_entities_to_entity_group(shared_dashboards_group.id, [dashboard.id.id])

            # Creating Customer 1
            customer1 = Customer(title="Customer 11")
            customer1 = rest_client.save_customer(body=customer1)

            # Creating Device
            default_device_profile_id = rest_client.get_default_device_profile_info().id
            device = Device(name="WaterMeter 1", device_profile_id=default_device_profile_id)
            device = rest_client.save_device(device)
            logging.info('Device created:\n%r\n', device)

            # Fetching automatically created "Customer Administrators" Group.
            customer1_administrators = rest_client.get_entity_group_by_owner_and_name_and_type(customer1.id, "USER", "Customer Administrators")

            # Creating Read-Only Role
            read_only_role = Role(name="Read-Only", permissions=['READ', 'READ_ATTRIBUTES', 'READ_TELEMETRY', 'READ_CREDENTIALS'], type="GROUP")
            read_only_role = rest_client.save_role(read_only_role)
            logging.info('Role created:\n%r\n', read_only_role)

            # Assigning Shared Dashboards to the Customer 1 Administrators
            tenant_id = current_user.tenant_id
            group_permission = GroupPermission(role_id=read_only_role.id,
                                               name="Read Only Permission",
                                               user_group_id=customer1_administrators.id,
                                               tenant_id=tenant_id,
                                               entity_group_id=shared_dashboards_group.id,
                                               entity_group_type=shared_dashboards_group.type)
            group_permission = rest_client.save_group_permission(group_permission)
            logging.info('Group permission created:\n%r\n', group_permission)

            # Creating User for Customer 1 with default dashboard from Tenant "Shared Dashboards" group.
            user_email = "user@thingsboard.org"
            user_password = "secret"
            additional_info = {
                "defaultDashboardId": dashboard.id.id,
                "defaultDashboardFullscreen": False
            }
            user = User(authority="CUSTOMER_USER",
                        customer_id=customer1.id,
                        email=user_email,
                        additional_info=additional_info)
            user = rest_client.save_user(user, send_activation_mail=False)
            rest_client.activate_user(body=ActivateUserRequest(user.id, user_password), send_activation_mail=False)

            rest_client.add_entities_to_entity_group(customer1_administrators.id, [user.id.id])
            logging.info('User created:\n%r\n', user)
        except ApiException as e:
            logging.exception(e)

if __name__ == '__main__':
    main()
```

### API key认证（自ThingsBoard 4.3+起）

以下代码示例演示如何结合ThingsBoard REST API使用API key认证。
运行示例前请确保已为用户创建API key。此外，请将`"YOUR_API_KEY_HERE"`替换为您的实际API key值，并将`url`变量替换为您的ThingsBoard实例URL。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_pe import *
from tb_rest_client.rest import ApiException

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# ThingsBoard REST API URL
url = "http://127.0.0.1:8080"

# Your API Key
api_key = "YOUR_API_KEY_HERE"


def main():
    # Creating the REST client object with context manager
    with RestClientPE(base_url=url) as rest_client:
        try:
            # Auth with API Key
            rest_client.api_key_login(api_key)

            # Creating a Device
            # Also, you can use default Device Profile:
            # default_device_profile_id = rest_client.get_default_device_profile_info().id
            device_profile = DeviceProfile(name="Thermometer",
                                           type="DEFAULT",
                                           transport_type="DEFAULT",
                                           profile_data=DeviceProfileData(configuration={"type": "DEFAULT"},
                                                                          transport_configuration={"type": "DEFAULT"}))
            device_profile = rest_client.save_device_profile(device_profile)
            device = Device(name="Thermometer 1", label="Thermometer 1",
                            device_profile_id=device_profile.id)
            device = rest_client.save_device(device)

            logging.info(" Device was created:\n%r\n", device)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()

```

### 获取用户权限

以下示例代码展示如何获取当前登录用户的允许权限并检查示例权限。

```python
import logging
# Importing models and REST client class from Professional Edition version
from tb_rest_client.rest_client_pe import *
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')


# ThingsBoard REST API URL
url = "http://localhost:8080"

# Default Tenant Administrator credentials
username = "tenant@thingsboard.org"
password = "tenant"


def main():
    # Creating the REST client object with context manager to get auto token refresh
    with RestClientPE(base_url=url) as rest_client:
        try:
            # Auth with credentials
            rest_client.login(username=username, password=password)

            allowed_user_perms = rest_client.get_allowed_permissions()
            logging.info("Allowed user permissions: \n%r", allowed_user_perms)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```

### 获取用户仪表板

以下示例代码展示如何通过分页链接获取用户仪表板。

```python
import logging
from json import load
# Importing models and REST client class from Professional Edition version
from tb_rest_client.rest_client_pe import *
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')


# ThingsBoard REST API URL
url = "http://localhost:8080"

# Default Tenant Administrator credentials
username = "tenant@thingsboard.org"
password = "tenant"


def main():
    # Creating the REST client object with context manager to get auto token refresh
    with RestClientPE(base_url=url) as rest_client:
        try:
            # Auth with credentials
            rest_client.login(username=username, password=password)

            dashboards = rest_client.get_user_dashboards(page_size=10, page=0)
            logging.info("Dashboards: \n%r", dashboards)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```

### 创建集成

以下示例代码展示如何创建HTTP集成。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_pe import *
from tb_rest_client.rest import ApiException

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# ThingsBoard REST API URL
url = "https://thingsboard.cloud"

# Default Tenant Administrator credentials
username = "tenant@thingsboard.org"
password = "tenant"


def main():
    # Creating the REST client object with context manager to get auto token refresh
    with RestClientPE(base_url=url) as rest_client:
        try:
            # Auth with credentials
            rest_client.login(username=username, password=password)

            # creating uplink converter
            converter = Converter(name='HTTP converter', type='UPLINK')
            converter = rest_client.save_converter(converter)
            logging.info("Created converter: \n%r", converter)

            # creating integration
            integration = Integration(name='HTTP Integration', type='HTTP',
                                      routing_key='c5d29c90-75d3-6ae6-606a-589a28803e89',
                                      configuration=str({
                                          "configuration": {
                                              "appId": "",
                                              "asId": "",
                                              "asIdNew": "",
                                              "asKey": "",
                                              "baseUrl": "https://thingsboard.cloud",
                                              "clientIdNew": "",
                                              "clientSecret": "",
                                              "createLoriotOutput": False,
                                              "credentials": {
                                                  "email": "",
                                                  "password": "",
                                                  "token": "",
                                                  "type": "basic"
                                              },
                                              "downlinkUrl": "https://api.thingpark.com/thingpark/lrc/rest/downlink",
                                              "enableSecurity": False,
                                              "enableSecurityNew": False,
                                              "headersFilter": {},
                                              "httpEndpoint": "https://thingsboard.cloud/api/v1/integrations/http/c5d29c90-75d3-6ae6-606a-589a28803e89",
                                              "loriotDownlinkUrl": "https://eu1.loriot.io/1/rest",
                                              "maxTimeDiffInSeconds": 60,
                                              "metadata": {},
                                              "replaceNoContentToOk": "",
                                              "sendDownlink": False,
                                              "server": "eu1",
                                              "token": ""
                                          }
                                      }),
                                      default_converter_id=ConverterId('504702d0-fe72-11eb-ab24-1f8899a6f9b3',
                                                                       'CONVERTER'),
                                      allow_create_devices_or_assets=True, enabled=True, remote=False, debug_mode=False,
                                      secret='your_secret_token')
            integration = rest_client.save_integration_post(integration)
            logging.info("Saved integration: \n%r", integration)
        except ApiException as e:
            logging.exception(e)
            

if __name__ == '__main__':
    main()
```

### 设备管理

以下示例代码演示设备管理API的基本概念（添加/获取/删除设备，获取/保存设备属性）。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_pe import *
# Importing the API exception
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# ThingsBoard REST API URL
url = "http://localhost:8080"
# Default Tenant Administrator credentials
username = "tenant@thingsboard.org"
password = "tenant"


def main():
    # Creating the REST client object with context manager to get auto token refresh
    with RestClientPE(base_url=url) as rest_client:
        try:
            # Auth with credentials
            rest_client.login(username=username, password=password)

            # Creating an Asset
            default_asset_profile_id = rest_client.get_default_asset_profile_info().id
            asset = Asset(name="Building 12",
                          asset_profile_id=default_asset_profile_id)
            asset = rest_client.save_asset(asset)

            logging.info("Asset was created:\n%r\n", asset)

            # Creating a Device
            # Also, you can use default Device Profile:
            # default_device_profile_id = rest_client.get_default_device_profile_info().id
            device_profile = DeviceProfile(name="Thermometer",
                                           type="DEFAULT",
                                           transport_type="DEFAULT",
                                           profile_data=DeviceProfileData(configuration={"type": "DEFAULT"},
                                                                          transport_configuration={"type": "DEFAULT"}))
            device_profile = rest_client.save_device_profile(device_profile)
            device = Device(name="Thermometer 1",
                            device_profile_id=device_profile.id)
            device = rest_client.save_device(device)

            logging.info(" Device was created:\n%r\n", device)

            # Creating relations from device to asset
            relation = EntityRelation(_from=asset.id, to=device.id, type="Contains")
            rest_client.save_relation(relation)

            logging.info(" Relation was created:\n%r\n", relation)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```


### 从控制台配置版本控制功能

该功能自ThingsBoard 3.4+起可用。
我们基于tb-rest-client库设计了脚本，展示如何通过代码配置ThingsBoard。
脚本最新源码可[在此处](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/configure_vcs_access.py)找到。
本示例配置ThingsBoard的[版本控制功能](/docs/user-guide/version-control)。

配置版本控制系统（VCS）有2种方式：
1. 使用VCS账户的访问令牌/密码。
2. 使用私钥。

#### 使用访问令牌或密码配置版本控制系统

配置该功能需要以下命令行参数与数据：

| 命令行参数 | 说明                                                                                          |
|-----------------------|------------------------------------------------------------------------------------------------------|
| -H                    | **ThingsBoard主机（默认：localhost）**                                                            |
| -p                    | **ThingsBoard端口（默认：80）**                                                                   |
| -U                    | **ThingsBoard用户（登录邮箱）**                                                               |
| -P                    | **ThingsBoard用户密码**                                                                        |
| -r                    | **仓库uri，指向您的仓库链接**                                                          |
| -b                    | **默认分支（默认：main）**                                                                   |
| -gu                   | **VCS用户名**（该参数名为GITHUB_USERNAME，但可用于任何VCS）                |
| -gp                   | **VCS访问令牌/密码**（该参数名为GITHUB_PASSWORD，但可用于任何VCS） |
| --------------------- | -----------------------------------------------------------------------------------------            |

*调用脚本时使用* **-h** *参数可获取完整参数列表。*

要配置版本控制功能，需安装[tb-rest-client](#python-rest-client)包并下载脚本：

```bash
wget https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/configure_vcs_access.py
```
{:.copy-code}

现可运行脚本并配置版本控制功能（请勿忘填入您的实际值）。

```bash
python3 configure_vcs_access.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -r YOUR_REPOSITORY_URL -b DEFAULT_BRANCH -gu YOUR_VCS_USERNAME -gp YOUR_VCS_ACCESSTOKEN_OR_PASSWORD
```
{:.copy-code}

#### 使用私钥配置版本控制系统

配置该功能需要以下命令行参数与数据：

| 命令行参数   | 说明                                                                             |
|-------------------------|-----------------------------------------------------------------------------------------|
| -H                      | **ThingsBoard主机（默认：localhost）**                                               |
| -p                      | **ThingsBoard端口（默认：80）**                                                      |
| -U                      | **ThingsBoard用户（登录邮箱）**                                                  |
| -P                      | **ThingsBoard用户密码**                                                           |
| -r                      | **仓库uri，指向您的仓库链接**                                             |
| -b                      | **默认分支（默认：main）**                                                      |
| -gu                     | **VCS用户名**（该参数名为GITHUB_USERNAME，但可用于任何VCS）   |
| -pk                     | **私钥路径**                                                                 |
| -pkp                    | **私钥密码（若已设置）**                                            |
| ----------------------- | --------------------------------------------------------------------------------------- |

*调用脚本时使用* **-h** *参数可获取完整参数列表。*

要配置版本控制功能，需安装[tb-rest-client](#python-rest-client)包并下载脚本：

```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/configure_vcs_access.py
```
{:.copy-code}

现可运行脚本并配置版本控制功能（请勿忘填入您的实际值）。

```bash
python3 configure_vcs_access.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -r YOUR_REPOSITORY_URL -b DEFAULT_BRACH -gu YOUR_VCS_USERNAME -pk PATH_TO_YOUR_PRIVATE_KEY -pkp YOUR_PRIVATE_KEY_PASSWORD
```
{:.copy-code}

### 将所有实体保存至版本控制系统

您可使用以下基于[tb-rest-client](#python-rest-client)的脚本，将当前实体状态保存至版本控制系统中的仓库。

最新源码可[在此处](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/load_all_entities_to_vcs_pe.py)找到。


从命令行保存实体时使用以下参数与数据：

| 命令行参数   | 说明                                                                                          |
|-------------------------|------------------------------------------------------------------------------------------------------|
| -H                      | **ThingsBoard主机（默认：localhost）**                                                            |
| -p                      | **ThingsBoard端口（默认：80）**                                                                   |
| -U                      | **ThingsBoard用户（登录邮箱）**                                                               |
| -P                      | **ThingsBoard用户密码**                                                                        |
| -b                      | **默认分支（默认：main）**                                                                   |
| -N                      | **版本名称（若未提供将生成5位随机字母数字作为名称）**                      |
| --save_attributes       | **可选，是否保存目标实体的属性（默认：True）**                      |
| --save_credentials      | **可选，是否保存目标实体的凭据（默认：True）**                     |
| --save_relations        | **可选，是否保存目标实体的关系（默认：True）**                       |
| --save_group_entities   | **可选，是否保存目标实体的实体组（默认：True）**                  |
| --save_permissions      | **可选，是否保存目标实体的权限（默认：True）**                     |
| --sync_strategy         | **可选，保存实体的同步策略可为OVERWRITE和MERGE（默认：MERGE）**          |
| ----------------------- | -----------------------------------------------------------------------------------------            |

*调用脚本时使用* **-h** *参数可获取完整参数列表。*

下载脚本：
```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/load_all_entities_to_vcs_pe.py
```

现可运行脚本并将实体保存至版本控制系统的仓库，以下示例以默认分支与默认设置发布，展示最小所需配置：

```bash
python3 load_all_entities_to_vcs_pe.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD
```

输出中将显示保存的实体数量信息。

### 从版本控制系统加载所有实体

您可使用以下基于[tb-rest-client](#python-rest-client)的脚本，从版本控制系统恢复仓库中的实体。

最新源码可[在此处](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/load_all_entities_from_vcs_pe.py)找到。


从命令行加载实体时使用以下参数与数据：

| 命令行参数          | 说明                                                                                                                            |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|  
| -H                             | **ThingsBoard主机（默认：localhost）**                                                                                              |
| -p                             | **ThingsBoard端口（默认：80）**                                                                                                     |
| -U                             | **ThingsBoard用户（登录邮箱）**                                                                                                 |
| -P                             | **ThingsBoard用户密码**                                                                                                          |
| -b                             | **默认分支（默认：main）**                                                                                                     |
| -N                             | **版本名称（可提供版本名称部分，脚本将提示所有包含该名称的版本）** |
| --find_existing_entity_by_name | **可选，是否按名称查找现有实体而非使用id（默认：True）**                           |
| --load_attributes              | **可选，是否加载目标实体的属性（默认：True）**                                                        |
| --load_credentials             | **可选，是否加载目标实体的凭据（默认：True）**                                                       |
| --load_relations               | **可选，是否加载目标实体的关系（默认：True）**                                                         |
| --load_group_entities          | **可选，是否加载目标实体的实体组（默认：True）**                                                    |
| --load_permissions             | **可选，是否加载目标实体的权限（默认：True）**                                                     |
| --sync_strategy                | **可选，现有实体的同步策略可为OVERWRITE和MERGE（默认：MERGE）**                                          |
| ------------------------------ | -----------------------------------------------------------------------------------------                                              |

*调用脚本时不带参数或使用* **-h** *参数可获取完整参数列表。*

下载脚本：
```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/load_all_entities_from_vcs_pe.py
```

现可运行脚本并从版本控制系统的仓库恢复实体版本与状态：

```bash
python3 load_all_entities_from_vcs_pe.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -N YOUR_VERSION_NAME 
```

输出中将显示加载的实体数量信息。
