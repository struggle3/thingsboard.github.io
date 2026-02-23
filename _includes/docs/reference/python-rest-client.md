
* TOC
{:toc}
 
## Python REST Client

ThingsBoard Python REST API客户端可帮助您使用Python脚本与ThingsBoard REST API交互。
使用Python REST客户端，您可以在ThingsBoard中以编程方式创建资产、设备、客户、用户及其他实体及其关联关系。

Python REST API客户端源代码见[此处](https://github.com/thingsboard/python_tb_rest_client)。

要安装ThingsBoard Python REST客户端，请使用以下命令：

```bash
pip3 install tb-rest-client
``` 
{:.copy-code}

## Python REST Client示例

### 基本用法
示例脚本见**[此处](https://github.com/thingsboard/python_tb_rest_client/blob/master/examples/example_application.py)**。

下方示例展示REST客户端的基本用法，即如何执行登录、创建新的Asset和Device实例，以及如何建立它们之间的关联关系。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_ce import *
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
    with RestClientCE(base_url=url) as rest_client:
        try:
            # Auth with credentials
            rest_client.login(username=username, password=password)

            # Creating an Asset
            default_asset_profile_id = rest_client.get_default_asset_profile_info().id
            asset = Asset(name="Building 12", asset_profile_id=default_asset_profile_id)
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
            device = Device(name="Thermometer 1", device_profile_id=device_profile.id)
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

### API密钥认证（自ThingsBoard 4.3+）

以下代码示例演示如何配合ThingsBoard REST API使用API密钥认证。
运行示例前请确保已为您的用户创建API密钥。同时请将`"YOUR_API_KEY_HERE"`替换为实际API密钥值，将`url`变量替换为您的ThingsBoard实例URL。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_ce import *
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
    with RestClientCE(base_url=url) as rest_client:
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

### 管理设备

以下代码示例演示设备管理API的基本概念（添加/获取/删除设备，获取/保存设备属性）。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_ce import *
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
    with RestClientCE(base_url=url) as rest_client:
        try:
            rest_client.login(username=username, password=password)
            # creating a Device
            default_device_profile_id = rest_client.get_default_device_profile_info().id
            device = Device(name="Thermometer 1",
                            device_profile_id=default_device_profile_id)
            device = rest_client.save_device(device)

            logging.info(" Device was created:\n%r\n", device)

            # find device by device id
            found_device = rest_client.get_device_by_id(DeviceId(device.id, 'DEVICE'))

            # save device shared attributes
            rest_client.save_device_attributes(DeviceId(device.id, 'DEVICE'), 'SERVER_SCOPE',
                                                     {'targetTemperature': 22.4})

            # Get device shared attributes
            res = rest_client.get_attributes_by_scope(EntityId(device.id, 'DEVICE'), 'SERVER_SCOPE',
                                                      'targetTemperature')
            logging.info("Found device attributes: \n%r", res)

            # delete the device
            rest_client.delete_device(DeviceId(device.id, 'DEVICE'))
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```

### 获取租户设备

以下代码示例展示如何通过分页链接获取租户设备。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_ce import *
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
    with RestClientCE(base_url=url) as rest_client:
        try:
            rest_client.login(username=username, password=password)
            res = rest_client.get_tenant_device_infos(page_size=10, page=0)

            logging.info("Device info:\n%r", res)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```

### 获取租户仪表板

以下代码示例展示如何通过分页链接获取租户仪表板。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_ce import *
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
    with RestClientCE(base_url=url) as rest_client:
        try:
            rest_client.login(username=username, password=password)
            user = rest_client.get_user()
            devices = rest_client.get_customer_device_infos(customer_id=CustomerId(user.id.id, 'CUSTOMER'), page_size=10,
                                                            page=0)
            logging.info("Devices: \n%r", devices)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```

### 使用Entity Data Query API统计实体数量

以下代码示例展示如何使用Entity Data Query API统计设备总数。

```python
import logging
# Importing models and REST client class from Community Edition version
from tb_rest_client.rest_client_ce import *
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


# Creating the REST client object with context manager to get auto token refresh
with RestClientCE(base_url=url) as rest_client:
    try:
        rest_client.login(username=username, password=password)

        # Execute entity count query and get total devices count
        entity_count_query = EntityCountQuery(entity_filter=EntityFilter(type='entityType', entity_type='DEVICE'),
                                              key_filters=[KeyFilter(key={"type": "ATTRIBUTE",
                                                                          "key": "active"}, value_type='BOOLEAN',
                                                                     predicate={"operation": "EQUAL",
                                                                                "value": {
                                                                                    "defaultValue": True,
                                                                                    "dynamicValue": None
                                                                                },
                                                                                "type": "BOOLEAN"})])
        logging.info("Total devices: \n%r", entity_count_query)
    except ApiException as e:
        logging.exception(e)
```

### 从控制台配置版本控制功能

该功能自ThingsBoard 3.4+可用。
我们基于tb-rest-client库设计了脚本，作为从代码配置ThingsBoard的示例。
脚本最新源代码见[此处](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/configure_vcs_access.py)。
本示例中我们在ThingsBoard上配置[版本控制功能](/docs/user-guide/version-control)。

配置版本控制系统（VCS）有两种方式：   
1. 使用VCS账户的access token/密码。  
2. 使用私钥。  

#### 使用access token或密码配置版本控制系统  

配置此功能需要以下命令行参数和数据：  

| 命令行参数 | 说明                                                                                          |
|-----------------------|------------------------------------------------------------------------------------------------------|
| -H                    | **ThingsBoard主机（默认：localhost）**                                                            |
| -p                    | **ThingsBoard端口（默认：80）**                                                                   |
| -U                    | **ThingsBoard用户（登录邮箱）**                                                               |
| -P                    | **ThingsBoard用户密码**                                                                        |
| -r                    | **仓库URI，您的仓库链接**                                                          |
| -b                    | **默认分支（默认：main）**                                                                   |
| -gu                   | **VCS用户名**（此参数名为GITHUB_USERNAME，但可与任意VCS配合使用）                |
| -gp                   | **VCS access token/密码**（此参数名为GITHUB_PASSWORD，但可与任意VCS配合使用） |

*可通过无参数或**-h**参数调用脚本获取完整参数列表。*

要配置版本控制功能，需先安装[tb-rest-client](#python-rest-client) Python包并下载脚本：

```bash
wget https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/configure_vcs_access.py
```
{:.copy-code}

现在可运行脚本并配置版本控制功能（请勿忘记填入您的实际值）。  

```bash
python3 configure_vcs_access.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -r YOUR_REPOSITORY_URL -b DEFAULT_BRANCH -gu YOUR_VCS_USERNAME -gp YOUR_VCS_ACCESSTOKEN_OR_PASSWORD
```
{:.copy-code}

#### 使用私钥配置版本控制系统  

配置此功能需要以下命令行参数和数据：  

| 命令行参数 | 说明                                                                           |
|-----------------------|---------------------------------------------------------------------------------------|
| -H                    | **ThingsBoard主机（默认：localhost）**                                             |
| -p                    | **ThingsBoard端口（默认：80）**                                                    |
| -U                    | **ThingsBoard用户（登录邮箱）**                                                |
| -P                    | **ThingsBoard用户密码**                                                         |
| -r                    | **仓库URI，您的仓库链接**                                           |
| -b                    | **默认分支（默认：main）**                                                    |
| -gu                   | **VCS用户名**（此参数名为GITHUB_USERNAME，但可与任意VCS配合使用） |
| -pk                   | **私钥路径**                                                               |
| -pkp                  | **私钥密码（如已设置）**                                          |

*可通过无参数或**-h**参数调用脚本获取完整参数列表。*

要配置版本控制功能，需先安装[tb-rest-client](#python-rest-client) Python包并下载脚本：

```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/configure_vcs_access.py
```
{:.copy-code}

现在可运行脚本并配置版本控制功能（请勿忘记填入您的实际值）。  

```bash
python3 configure_vcs_access.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -r YOUR_REPOSITORY_URL -b DEFAULT_BRACH -gu YOUR_VCS_USERNAME -pk PATH_TO_YOUR_PRIVATE_KEY -pkp YOUR_PRIVATE_KEY_PASSWORD
```
{:.copy-code}

### 将所有实体保存到版本控制系统

您可使用基于[tb-rest-client](#python-rest-client)的以下脚本，将实体当前状态保存到版本控制系统中的仓库。

最新源代码见[此处](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/load_all_entities_to_vcs_ce.py)。


从命令行保存实体时将使用以下参数和数据：  

| 命令行参数 | 说明                                                                                          |
|-----------------------|------------------------------------------------------------------------------------------------------|
| -H                    | **ThingsBoard主机（默认：localhost）**                                                            |
| -p                    | **ThingsBoard端口（默认：80）**                                                                   |
| -U                    | **ThingsBoard用户（登录邮箱）**                                                               |
| -P                    | **ThingsBoard用户密码**                                                                        |
| -b                    | **默认分支（默认：main）**                                                                   |
| -N                    | **版本名称（如未提供将生成5位随机字母数字作为名称）** |
| --save_attributes     | **可选，是否保存目标实体属性（默认：True）**                      |
| --save_credentials    | **可选，是否保存目标实体凭证（默认：True）**                     |
| --save_relations      | **可选，是否保存目标实体关联（默认：True）**                       |
| --sync_strategy       | **可选，实体同步策略可为OVERWRITE和MERGE（默认：MERGE）**                 |

*可通过无参数或**-h**参数调用脚本获取完整参数列表。*

下载脚本：
```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/load_all_entities_to_vcs_ce.py
```

现在可运行脚本并将实体保存到版本控制系统的仓库，我们将使用默认设置发布到默认分支以展示最小所需配置：

```bash
python3 load_all_entities_to_vcs_ce.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD
```

输出消息中将显示已保存的实体数量。

### 从版本控制系统加载所有实体

您可使用基于[tb-rest-client](#python-rest-client)的以下脚本，从版本控制系统仓库加载实体。

最新源代码见[此处](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/load_all_entities_from_vcs_ce.py)。


从命令行加载实体时将使用以下参数和数据：  

| 命令行参数 | 说明                                                                                                                            |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| -H                    | **ThingsBoard主机（默认：localhost）**                                                                                              |
| -p                    | **ThingsBoard端口（默认：80）**                                                                                                     |
| -U                    | **ThingsBoard用户（登录邮箱）**                                                                                                 |
| -P                    | **ThingsBoard用户密码**                                                                                                          |
| -b                    | **默认分支（默认：main）**                                                                                                     |
| -N                    | **版本名称（可提供版本名部分，脚本将列出包含该名称的所有匹配版本）** |
| --load_attributes     | **可选，是否加载目标实体属性（默认：True）**                                                        |
| --load_credentials    | **可选，是否加载目标实体凭证（默认：True）**                                                       |
| --load_relations      | **可选，是否加载目标实体关联（默认：True）**                                                         |
| --sync_strategy       | **可选，现有实体同步策略可为OVERWRITE和MERGE（默认：MERGE）**                                          |

*可通过无参数或**-h**参数调用脚本获取完整参数列表。*

下载脚本：
```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/load_all_entities_from_vcs_ce.py
```

现在可运行脚本，从版本控制系统仓库恢复实体的版本和状态：

```bash
python3 load_all_entities_from_vcs_ce.py -H YOUR_THINGSBOARD_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -N YOUR_VERSION_NAME 
```

输出中将显示已加载的实体数量。


**专业版Python REST Client示例见[此处](/docs/pe/reference/python-rest-client/#professional-edition-python-rest-client-example)。**
