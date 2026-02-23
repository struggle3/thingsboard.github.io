* TOC
{:toc}

ThingsBoard REST API Client帮助您从Java应用与ThingsBoard REST API交互。
通过Rest Client可编程创建资产、设备、customers、用户及其它实体及其在ThingsBoard中的关系。
 
推荐使用Maven等构建自动化工具安装Rest Client。
REST Client的版本取决于您使用的平台版本。   

<hr>

## 专业版REST Client

要将REST Client添加到Maven/Gradle项目，请使用以下依赖：
 
```xml
<dependencies>
    <dependency>
        <groupId>org.thingsboard</groupId>
        <artifactId>rest-client</artifactId>
        <version>{{ site.release.pe_full_ver}}</version>
    </dependency>
</dependencies>
```
{: .copy-code}

说明：REST Client基于Spring RestTemplate构建，因此依赖Spring Web（撰写本文时版本为5.1.5.RELEASE）。

要下载REST Client依赖，需将以下仓库添加到项目中。 

```xml
<repositories>
    <repository>
        <id>thingsboard</id>
        <url>https://repo.thingsboard.io/artifactory/libs-release-public</url>
    </repository>
</repositories>
```
{: .copy-code}

<hr>

### 基本用法

#### 使用API Key认证

{% assign sinceVersion = "4.3" %}
{% include templates/since.md %}

您可使用API key认证，而无需执行login/logout操作：

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Your API key
String apiKey = "YOUR_API_KEY_VALUE";

// Creating new rest client with API key authentication
RestClient client = RestClient.withApiKey(url, apiKey);

// Get information of current user and print it
client.getUser().ifPresent(System.out::println);

// Close the client when done
client.close();
```
{: .copy-code}

<hr>

#### 使用凭据认证（已弃用）

或者，您可创建ThingsBoard Client实例、进行认证并获取当前登录用户数据。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Default Tenant Administrator credentials
String username = "tenant@thingsboard.org";
String password = "tenant";

// Creating new rest client and auth with credentials
RestClient client = new RestClient(url);
client.login(username, password);

// Get information of current logged in user and print it
client.getUser().ifPresent(System.out::println);

// Perform logout of current user and close the client
client.logout();
client.close();
```
{: .copy-code}

<hr>

## 示例

#### 使用API Key认证

{% assign sinceVersion = "4.3" %}
{% include templates/since.md %}

或者，您可使用API key认证，而无需执行login/logout操作：

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Your API key
String apiKey = "YOUR_API_KEY_VALUE";

// Creating new rest client with API key authentication
RestClient client = RestClient.withApiKey(url, apiKey);

// Get information of current user and print it
client.getUser().ifPresent(System.out::println);

// Close the client when done
client.close();
```
{: .copy-code}

<hr>

## 示例

以下示例演示如何结合标准用户名/密码认证使用API。
若更倾向使用API key，只需将以下行：

```java
String username = "tenant@thingsboard.org";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);
```

替换为API key初始化：

```java
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);
```

其余逻辑完全相同。

### 获取用户权限

以下示例演示使用API key认证。

若更倾向使用用户名/密码认证，只需将以下行：

```java
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);
```

替换为：

```java
String username = "tenant@thingsboard.org";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);
```

其余逻辑完全相同。

> 别忘了将<span class="code-light">YOUR_API_KEY_VALUE</span>替换为您的实际[API key](/docs/{{docsPrefix}}user-guide/security/api-keys/){:target="_blank"}。

### 获取用户权限

以下示例代码展示如何获取当前登录用户的允许权限并检查示例权限。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Perform login with API key
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);

// Get if user has generic read permission on device entities
AllowedPermissionsInfo permissionsInfo = client.getAllowedPermissions().orElseThrow();
boolean hasDeviceReadPermission = 
        permissionsInfo.getUserPermissions().hasGenericPermission(Resource.DEVICE, Operation.READ);
System.out.println("Has generic devices read permission: " + hasDeviceReadPermission);
        
// Perform logout of current user and close client
client.close();
```
{: .copy-code}

<hr>

### 获取用户设备

以下示例代码展示如何通过分页链接获取租户设备。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Authentication using an API key
String apiKey = "YOUR_API_KEY_VALUE";

// Creating new rest client and auth with API key
RestClient client = RestClient.withApiKey(url, apiKey);

PageData<Device> tenantDevices;
PageLink pageLink = new PageLink(10);
do {
    // Fetch all tenant devices using current page link and print each of them
    tenantDevices = client.getUserDevices("", pageLink);
    tenantDevices.getData().forEach(System.out::println);
    pageLink = pageLink.nextPageLink();
} while (tenantDevices.hasNext());

// Perform logout of current user and close the client
client.close();
```
{: .copy-code}

<hr>

### 获取租户仪表板

以下示例代码展示如何通过分页链接获取租户仪表板。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Authentication using an API key
String apiKey = "YOUR_API_KEY_VALUE";

// Creating new rest client and auth with API key
RestClient client = RestClient.withApiKey(url, apiKey);

PageData<DashboardInfo> pageData;
PageLink pageLink = new PageLink(10);
do {
    // Fetch all tenant dashboards using current page link and print each of them
    pageData = client.getTenantDashboards(pageLink);
    pageData.getData().forEach(System.out::println);
    pageLink = pageLink.nextPageLink();
} while (pageData.hasNext());

// Perform logout of current user and close the client
client.close();
```
{: .copy-code}

<hr>

### 获取实体组

以下示例代码展示如何获取实体组。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Perform login with Customer User API key
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);

// Iterate over all available entity group types
for (EntityType type : EntityType.values()) {
    // Fetch all entity groups of specified type and print them
    List<EntityGroupInfo> entityGroupsByType = client.getEntityGroupsByType(type);
    entityGroupsByType.forEach(System.out::println);
}
        
// Perform logout of current user and close client
client.close();
```
{: .copy-code}

<hr>

### 使用Entity Data Query API统计实体

以下示例代码展示如何使用Entity Data Query API统计总设备数、活跃设备数。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Perform login with default Customer User API key
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);

// Create entity filter to get all devices
EntityTypeFilter typeFilter = new EntityTypeFilter();
typeFilter.setEntityType(EntityType.DEVICE);

// Create entity count query with provided filter
EntityCountQuery totalDevicesQuery = new EntityCountQuery(typeFilter);

// Execute entity count query and get total devices count
Long totalDevicesCount = client.countEntitiesByQuery(totalDevicesQuery);
System.out.println("Total devices by the first query: " + totalDevicesCount);

// Set key filter to existing query to get only active devices
KeyFilter keyFilter = new KeyFilter();
keyFilter.setKey(new EntityKey(EntityKeyType.ATTRIBUTE, "active"));
keyFilter.setValueType(EntityKeyValueType.BOOLEAN);

BooleanFilterPredicate filterPredicate = new BooleanFilterPredicate();
filterPredicate.setOperation(BooleanFilterPredicate.BooleanOperation.EQUAL);
filterPredicate.setValue(new FilterPredicateValue<>(true));
        
keyFilter.setPredicate(filterPredicate);

// Create entity count query with provided filter
EntityCountQuery totalActiveDevicesQuery = 
        new EntityCountQuery(typeFilter, List.of(keyFilter));
        
// Execute active devices query and print total devices count
Long totalActiveDevicesCount = client.countEntitiesByQuery(totalActiveDevicesQuery);
System.out.println("Total devices by the second query: " + totalActiveDevicesCount);
        
// Perform logout of current user and close the client
client.close();
```
{: .copy-code}

<hr>

### 使用Entity Data Query API查询实体

以下示例代码展示如何使用Entity Data Query API获取所有活跃设备。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Perform login with default Customer User API key
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);

// Create entity filter to get only devices
EntityTypeFilter typeFilter = new EntityTypeFilter();
typeFilter.setEntityType(EntityType.DEVICE);

// Create key filter to query only active devices
KeyFilter keyFilter = new KeyFilter();
keyFilter.setKey(new EntityKey(EntityKeyType.ATTRIBUTE, "active"));
keyFilter.setValueType(EntityKeyValueType.BOOLEAN);

BooleanFilterPredicate filterPredicate = new BooleanFilterPredicate();
filterPredicate.setOperation(BooleanFilterPredicate.BooleanOperation.EQUAL);
filterPredicate.setValue(new FilterPredicateValue<>(true));

keyFilter.setPredicate(filterPredicate);

// Prepare list of queried device fields
List<EntityKey> fields = List.of(
        new EntityKey(EntityKeyType.ENTITY_FIELD, "name"),
        new EntityKey(EntityKeyType.ENTITY_FIELD, "type"),
        new EntityKey(EntityKeyType.ENTITY_FIELD, "createdTime")
);

// Prepare list of queried device attributes
List<EntityKey> attributes = List.of(
        new EntityKey(EntityKeyType.ATTRIBUTE, "active")
);

// Prepare page link
EntityDataSortOrder sortOrder = new EntityDataSortOrder();
sortOrder.setKey(new EntityKey(EntityKeyType.ENTITY_FIELD, "createdTime"));
sortOrder.setDirection(EntityDataSortOrder.Direction.DESC);
EntityDataPageLink entityDataPageLink = new EntityDataPageLink(10, 0, "", sortOrder);

// Create entity query with provided entity filter, key filter, queried fields and page link
EntityDataQuery dataQuery = 
        new EntityDataQuery(typeFilter, entityDataPageLink, fields, attributes, List.of(keyFilter));

PageData<EntityData> entityPageData;
do {
    // Fetch active devices using entities query and print them
    entityPageData = client.findEntityDataByQuery(dataQuery);
    entityPageData.getData().forEach(System.out::println);
    dataQuery = dataQuery.next();
} while (entityPageData.hasNext());

// Perform logout of current user and close client
client.close();
```
{: .copy-code}

<hr>

### 设备管理示例

以下示例代码演示设备管理API的基本概念（添加/获取/删除设备，获取/保存设备属性）。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// Perform login with default Customer User API key
String apiKey = "YOUR_API_KEY_VALUE";
RestClient client = RestClient.withApiKey(url, apiKey);

// Construct device object
String newDeviceName = "Test Device";
Device newDevice = new Device();
newDevice.setName(newDeviceName);

// Create Json Object Node and set it as additional info
ObjectMapper mapper = new ObjectMapper();
ObjectNode additionalInfoNode = mapper.createObjectNode().put("description", "My brand new device");
newDevice.setAdditionalInfo(additionalInfoNode);

// Save device
Device savedDevice = client.saveDevice(newDevice);
System.out.println("Saved device: " + savedDevice);

// Find device by device id or throw an exception otherwise
Optional<DeviceInfo> optionalDevice = client.getDeviceInfoById(savedDevice.getId());
DeviceInfo foundDevice = optionalDevice
        .orElseThrow(() -> new IllegalArgumentException("Device with id " + newDevice.getId().getId() + " hasn't been found"));

// Save device shared attributes
ObjectNode requestNode = mapper.createObjectNode().put("temperature", 22.4).put("humidity", 57.4);
boolean isSuccessful = client.saveEntityAttributesV2(foundDevice.getId(), "SHARED_SCOPE", requestNode);
System.out.println("Attributes have been successfully saved: " + isSuccessful);

// Get device shared attributes
var attributes = client.getAttributesByScope(foundDevice.getId(), "SHARED_SCOPE", List.of("temperature", "humidity"));
System.out.println("Found attributes: ");
attributes.forEach(System.out::println);

// Delete the device
client.deleteDevice(savedDevice.getId());

// Perform logout of current user and close client
client.close();
```
{: .copy-code}

<hr>

## 实用代码片段

```java
// ThingsBoard REST API URL
final String url = "http://localhost:8080";

// Default System Administrator credentials
final String username = "sysadmin@thingsboard.org";
final String password = "sysadmin";

// creating new rest restClient and auth with system administrator credentials
restClient = new RestClient(url);
login(username, password);

// Creating Tenant
Tenant tenant = new Tenant();
tenant.setTitle("Test Tenant");
tenant = restClient.saveTenant(tenant);

final String tenantUsername = "testtenant@thingsboard.org";
final String tenantPassword = "testtenant";

// Created User for Tenant
User tenantUser = new User();
tenantUser.setAuthority(Authority.TENANT_ADMIN);
tenantUser.setEmail(tenantUsername);
tenantUser.setTenantId(tenant.getId());

tenantUser = restClient.saveUser(tenantUser, false);
restClient.activateUser(tenantUser.getId(), tenantPassword);

// create API key for Tenant User
ApiKeyInfo apiKeyInfo = new ApiKeyInfo();
apiKeyInfo.setUserId(tenantUser.getId());
apiKeyInfo.setDescription(tenantUsername + " API key");
 ApiKey savedApiKey = restClient.saveApiKey(apiKeyInfo);

// API key value of Tenant User
String apiKeyValue = savedApiKey.getValue();

// re-init restClient with Tenant User's API key
restClient = RestClient.withApiKey(url, apiKeyValue);

// Loading Widget from file
Path widgetFilePath = Paths.get("src/main/resources/custom_widget.json");
JsonNode widgetJson = mapper.readTree(Files.readAllBytes(widgetFilePath));
loadWidget(widgetJson);

// Loading Rule Chain from file
Path ruleChainFilePath = Paths.get("src/main/resources/rule_chain.json");
JsonNode ruleChainJson = mapper.readTree(Files.readAllBytes(ruleChainFilePath));
loadRuleChain(ruleChainJson, false);

// Creating Dashboard Group on the Tenant Level
EntityGroup sharedDashboardsGroup = new EntityGroup();
sharedDashboardsGroup.setName("Shared Dashboards");
sharedDashboardsGroup.setType(EntityType.DASHBOARD);
sharedDashboardsGroup = restClient.saveEntityGroup(sharedDashboardsGroup);

// Loading Dashboard from file
JsonNode dashboardJson = mapper.readTree(RestClientExample.class.getClassLoader().getResourceAsStream("watermeters.json"));
Dashboard dashboard = new Dashboard();
dashboard.setTitle(dashboardJson.get("title").asText());
dashboard.setConfiguration(dashboardJson.get("configuration"));
dashboard = restClient.saveDashboard(dashboard);

// Adding Dashboard to the Shared Dashboards Group
restClient.addEntitiesToEntityGroup(sharedDashboardsGroup.getId(), Collections.singletonList(dashboard.getId()));

// Creating Customer 1
Customer customer1 = new Customer();
customer1.setTitle("Customer 1");
customer1 = restClient.saveCustomer(customer1);

Device waterMeter1 = new Device();
waterMeter1.setCustomerId(customer1.getId());
waterMeter1.setName("WaterMeter1");
waterMeter1.setType("waterMeter");
waterMeter1 = restClient.saveDevice(waterMeter1);

// Update device token
DeviceCredentials deviceCredentials = restClient.getDeviceCredentialsByDeviceId(waterMeter1.getId()).get();
deviceCredentials.setCredentialsId("new_device_token");
restClient.saveDeviceCredentials(deviceCredentials);

// Fetching automatically created "Customer Administrators" Group.
EntityGroupInfo customer1Administrators = restClient.getEntityGroupInfoByOwnerAndNameAndType(customer1.getId(), EntityType.USER, "Customer Administrators").get();

// Creating Read-Only Role
Role readOnlyRole = restClient.createGroupRole("Read-Only", Arrays.asList(Operation.READ, Operation.READ_ATTRIBUTES, Operation.READ_TELEMETRY, Operation.READ_CREDENTIALS));

// Assigning Shared Dashboards to the Customer 1 Administrators
GroupPermission groupPermission = new GroupPermission();
groupPermission.setRoleId(readOnlyRole.getId());
groupPermission.setUserGroupId(customer1Administrators.getId());
groupPermission.setEntityGroupId(sharedDashboardsGroup.getId());
groupPermission.setEntityGroupType(sharedDashboardsGroup.getType());
groupPermission = restClient.saveGroupPermission(groupPermission);

// Creating User for Customer 1 with default dashboard from Tenant "Shared Dashboards" group.
String userEmail = "user@thingsboard.org";
String userPassword = "secret";
User user = new User();
user.setAuthority(Authority.CUSTOMER_USER);
user.setCustomerId(customer1.getId());
user.setEmail(userEmail);
ObjectNode additionalInfo = mapper.createObjectNode();
additionalInfo.put("defaultDashboardId", dashboard.getId().toString());
additionalInfo.put("defaultDashboardFullscreen", false);
user.setAdditionalInfo(additionalInfo);
user = restClient.saveUser(user, false);
restClient.activateUser(user.getId(), userPassword);

restClient.addEntitiesToEntityGroup(customer1Administrators.getId(), Collections.singletonList(user.getId()));
```
{: .copy-code}

<hr>

### 更多示例

示例应用可[在此处](https://github.com/thingsboard/tb-pe-rest-client-example){:target="_blank"}找到。
