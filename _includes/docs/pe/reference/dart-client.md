{% assign dartClientVer = site.release.pe_dart_client_ver %}
* TOC
{:toc}

## 概述

[Dart ThingsBoard PE API Client](https://pub.dev/packages/thingsboard_pe_client)包是一款[Dart](https://dart.dev/)库，
提供模型对象与服务，通过[RESTful API](/docs/{{docsPrefix}}reference/rest-api/)和WebSocket协议与ThingsBoard PE平台通信。
通过Dart Client可编程访问ThingsBoard PE API，管理[实体](/docs/{{docsPrefix}}user-guide/entities-and-relations/)、
查询[遥测数据](/docs/{{docsPrefix}}user-guide/telemetry/)并通过[WebSocket API](/docs/{{docsPrefix}}user-guide/telemetry/#websocket-api)获取实时更新。
Dart ThingsBoard PE API Client也是ThingsBoard PE移动应用的一部分。

Dart ThingsBoard PE API Client的版本取决于您使用的平台版本。

## 安装Dart ThingsBoard API Client（专业版）

要在Dart/Flutter项目中使用Dart ThingsBoard PE API Client包，请运行以下命令：

Dart：

```bash
dart pub add thingsboard_pe_client
```
{: .copy-code}

Flutter：

```bash
flutter pub add thingsboard_pe_client
```
{: .copy-code}

这将向项目的pubspec.yaml添加类似以下的一行（并隐式执行`dart pub get`）：

```yaml
dependencies:
  thingsboard_pe_client: ^{{dartClientVer}}
```
{: .copy-code}

或者，您的编辑器可能支持`dart pub get`或`flutter pub get`。更多说明请查阅编辑器文档。

现可在Dart代码中使用：

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';
```
{: .copy-code}

### 基本用法

以下示例代码展示如何实例化ThingsBoard Client、执行登录并获取当前登录用户的用户详情。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    print('isAuthenticated=${tbClient.isAuthenticated()}');

    print('authUser: ${tbClient.getAuthUser()}');

    // Get user details of current logged in user
    var currentUserDetails = await tbClient.getUserService().getUser();
    print('currentUserDetails: $currentUserDetails');

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

### 示例

#### 获取用户权限

以下示例代码展示如何获取当前登录用户的允许权限并检查示例权限。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    // Get allowed user permissions
    var allowedUserPermissions =
      await tbClient.getUserPermissionsService().getAllowedPermissions();

    print('Allowed user permissions: ${allowedUserPermissions.userPermissions}');

    // Get if user has generic read permission on device entities
    print(
          'Has generic devices read permission: ${allowedUserPermissions.hasGenericPermission(Resource.DEVICE, Operation.READ)}');

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 获取用户设备

以下示例代码展示如何通过分页链接获取用户设备。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    var pageLink = PageLink(10);
    PageData<Device> devices;
    do {
        // Fetch user devices using current page link
        devices = await tbClient.getDeviceService().getUserDevices(pageLink);
        print('devices: $devices');
        pageLink = pageLink.nextPageLink();
    } while (devices.hasNext);

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 获取用户仪表板

以下示例代码展示如何通过分页链接获取用户仪表板。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    var pageLink = PageLink(10);
    PageData<DashboardInfo> dashboards;
    do {
        // Fetch user dashboards using current page link
        dashboards = await tbClient.getDashboardService().getUserDashboards(pageLink);
        print('dashboards: $dashboards');
        pageLink = pageLink.nextPageLink();
    } while (devices.hasNext);

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 获取实体组

以下示例代码展示如何获取实体组。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    // Iterate over all available entity group types
    for (var groupType in [
      EntityType.DEVICE,
      EntityType.ASSET,
      EntityType.ENTITY_VIEW,
      EntityType.DASHBOARD,
      EntityType.CUSTOMER,
      EntityType.USER,
      EntityType.EDGE
    ]) {
      // Fetch all entity groups of specified type
      var entityGroups =
          await tbClient.getEntityGroupService().getEntityGroupsByType(groupType);
      print('found ${groupType.toShortString()} groups: $entityGroups');
    }

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 使用Entity Data Query API统计实体

以下示例代码展示如何使用Entity Data Query API统计总设备数、活跃设备数与非活跃设备数。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    // Create entity filter to get all devices
    var entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

    // Create entity count query with provided filter
    var devicesQuery = EntityCountQuery(entityFilter: entityFilter);

    // Execute entity count query and get total devices count
    var totalDevicesCount =
        await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
    print('Total devices: $totalDevicesCount');

    // Set key filter to existing query to get only active devices
    var activeDeviceKeyFilter = KeyFilter(
      key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
      valueType: EntityKeyValueType.BOOLEAN,
      predicate: BooleanFilterPredicate(
          operation: BooleanOperation.EQUAL,
          value: FilterPredicateValue(true)));
    devicesQuery.keyFilters = [activeDeviceKeyFilter];

    // Execute entity count query and get total active devices count
    var activeDevicesCount =
      await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
    print('Active devices: $activeDevicesCount');

    // Set key filter to existing query to get only inactive devices
    var inactiveDeviceKeyFilter = KeyFilter(
      key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
      valueType: EntityKeyValueType.BOOLEAN,
      predicate: BooleanFilterPredicate(
          operation: BooleanOperation.EQUAL,
          value: FilterPredicateValue(false)));
    devicesQuery.keyFilters = [inactiveDeviceKeyFilter];

    // Execute entity count query and get total inactive devices count
    var inactiveDevicesCount =
      await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
    print('Inactive devices: $inactiveDevicesCount');

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 使用Entity Data Query API查询实体

以下示例代码展示如何使用Entity Data Query API获取所有活跃设备。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    // Create entity filter to get only devices
    var entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

    // Create key filter to query only active devices
    var activeDeviceKeyFilter = KeyFilter(
        key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
        valueType: EntityKeyValueType.BOOLEAN,
        predicate: BooleanFilterPredicate(
            operation: BooleanOperation.EQUAL,
            value: FilterPredicateValue(true)));

    // Prepare list of queried device fields
    var deviceFields = <EntityKey>[
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'name'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'type'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime')
    ];

    // Prepare list of queried device attributes
    var deviceAttributes = <EntityKey>[
      EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active')
    ];

    // Create entity query with provided entity filter, key filter, queried fields and page link
    var devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        keyFilters: [inactiveDeviceKeyFilter],
        entityFields: deviceFields,
        latestValues: deviceAttributes,
        pageLink: EntityDataPageLink(
            pageSize: 10,
            sortOrder: EntityDataSortOrder(
                key: EntityKey(
                    type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
                direction: EntityDataSortOrderDirection.DESC)));

      PageData<EntityData> devices;
      do {
        // Fetch active devices using entities query with current page link
        devices = await tbClient
            .getEntityQueryService()
            .findEntityDataByQuery(devicesQuery);
        print('Active devices entities data:');
        devices.data.forEach((device) {
          print(
              'id: ${device.entityId.id}, createdTime: ${device.createdTime}, name: ${device.field('name')!}, type: ${device.field('type')!}, active: ${device.attribute('active')}');
        });
        devicesQuery = devicesQuery.next();
      } while (devices.hasNext);

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 设备管理示例

以下示例代码演示设备管理API的基本概念（添加/获取/删除设备，获取/保存设备属性）。

```dart
import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    var deviceName = 'My test device';

    // Construct device object
    var device = Device(deviceName, 'default');
    device.additionalInfo = {'description': 'My test device!'};

    // Add device
    var savedDevice = await tbClient.getDeviceService().saveDevice(device);
    print('savedDevice: $savedDevice');

    // Find device by device id
    var foundDevice =
       await tbClient.getDeviceService().getDeviceInfo(savedDevice.id!.id!);
    print('foundDevice: $foundDevice');

    // Save device shared attributes
    var res = await tbClient.getAttributeService().saveEntityAttributesV2(
      foundDevice!.id!,
      AttributeScope.SHARED_SCOPE.toShortString(),
      {'targetTemperature': 22.4, 'targetHumidity': 57.8});
    print('Save attributes result: $res');

    // Get device shared attributes
    var attributes = await tbClient.getAttributeService().getAttributesByScope(
      foundDevice.id!,
      AttributeScope.SHARED_SCOPE.toShortString(),
      ['targetTemperature', 'targetHumidity']);
    print('Found device attributes: $attributes');

    // Delete the device
    await tbClient.getDeviceService().deleteDevice(savedDevice.id!.id!);

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### WebSocket API示例

以下示例代码演示WebSocket API的基本概念。本代码将创建新设备、
使用Entity Data Query API通过WebSocket API创建订阅以获取设备数据与遥测更新。
最后发布示例遥测并监听订阅的数据流以获取数据更新。

```dart
import 'dart:math';

import 'package:thingsboard_pe_client/thingsboard_client.dart';

// ThingsBoard REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // Create instance of ThingsBoard API Client
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login with default Tenant Administrator credentials
    await tbClient.login(LoginRequest('tenant@thingsboard.org', 'tenant'));

    var deviceName = 'My test device';

    // Construct device object
    var device = Device(deviceName, 'default');
    device.additionalInfo = {'description': 'My test device!'};

    // Add device
    var savedDevice = await tbClient.getDeviceService().saveDevice(device);
    print('savedDevice: $savedDevice');

    // Create entity filter to get device by its name
    var entityFilter = EntityNameFilter(
        entityType: EntityType.DEVICE, entityNameFilter: deviceName);

    // Prepare list of queried device fields
    var deviceFields = <EntityKey>[
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'name'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'type'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime')
    ];

    // Prepare list of queried device time series
    var deviceTelemetry = <EntityKey>[
      EntityKey(type: EntityKeyType.TIME_SERIES, key: 'temperature'),
      EntityKey(type: EntityKeyType.TIME_SERIES, key: 'humidity')
    ];

    // Create entity query with provided entity filter, queried fields and page link
    var devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        entityFields: deviceFields,
        latestValues: deviceTelemetry,
        pageLink: EntityDataPageLink(
            pageSize: 10,
            sortOrder: EntityDataSortOrder(
                key: EntityKey(
                    type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
                direction: EntityDataSortOrderDirection.DESC)));

    // Create time series subscription command to get data for 'temperature' and 'humidity' keys for last hour with realtime updates
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var timeWindow = Duration(hours: 1).inMilliseconds;

    var tsCmd = TimeSeriesCmd(
        keys: ['temperature', 'humidity'],
        startTs: currentTime - timeWindow,
        timeWindow: timeWindow);

    // Create subscription command with entities query and time series subscription
    var cmd = EntityDataCmd(query: devicesQuery, tsCmd: tsCmd);

    // Create subscription with provided subscription command
    var telemetryService = tbClient.getTelemetryService();
    var subscription = TelemetrySubscriber(telemetryService, [cmd]);

    // Create listener to get data updates from WebSocket
    subscription.entityDataStream.listen((entityDataUpdate) {
      print('Received entity data update: $entityDataUpdate');
    });

    // Perform subscribe (send subscription command via WebSocket API and listen for responses)
    subscription.subscribe();

    // Post sample telemetry
    var rng = Random();
    for (var i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      var temperature = 10 + 20 * rng.nextDouble();
      var humidity = 30 + 40 * rng.nextDouble();
      var telemetryRequest = {'temperature': temperature, 'humidity': humidity};
      print('Save telemetry request: $telemetryRequest');
      var res = await tbClient
        .getAttributeService()
        .saveEntityTelemetry(savedDevice.id!, 'TELEMETRY', telemetryRequest);
      print('Save telemetry result: $res');
    }

    // Wait few seconds to show data updates are received by subscription listener
    await Future.delayed(Duration(seconds: 2));

    // Finally unsubscribe to release subscription
    subscription.unsubscribe();

    // Delete the device
    await tbClient.getDeviceService().deleteDevice(savedDevice.id!.id!);

    // Finally perform logout to clear credentials
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 更多示例

学习如何使用Dart ThingsBoard PE API Client的更多示例可[在此处](https://github.com/thingsboard/dart_thingsboard_pe_client/tree/master/example)找到。
