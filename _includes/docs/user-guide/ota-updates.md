* TOC 
{:toc}

## 概述

自 ThingsBoard 3.3 起，支持向设备上传和分发 OTA（空中升级）更新。
租户管理员可将固件或软件包上传到 OTA 仓库，上传后可分配到 [设备配置](/docs/{{docsPrefix}}user-guide/device-profiles/) 或 [设备](/docs/{{docsPrefix}}user-guide/ui/devices/)。
ThingsBoard 会通知设备有可用更新，并经由协议专用 API 提供固件下载。
平台会记录更新状态和更新历史，用户可通过仪表盘监控更新进度。
<br>
<object data="/images/user-guide/firmware/firmware-anim3.svg"></object>
<br>

## 将 OTA 包上传到 ThingsBoard 仓库

进入「OTA Updates」菜单项以列表显示并上传 OTA 更新包。每个包包含：

* **标题** —— 包名称。可为生产版与调试版固件/软件使用不同名称。
* **版本** —— 包版本。标题与版本的组合在租户内须唯一。
* **设备配置** —— 每个包与一个设备配置兼容。平台会校验兼容性，避免为设备安装不兼容的固件/软件。关联设备配置表示使用该配置的设备*可以*更新到此包，但需用户或脚本将包[分配到](#assign-ota-package-to-device-profile)设备配置或设备后才触发更新。
* **类型** —— 可选 *Firmware* 或 *Software*。
* **校验和算法** —— 可选，所用校验和算法的简称。
* **校验和** —— 可选，文件校验和值。若未提供，服务器会自动使用 SHA-256。
* **描述** —— 可选，固件文本说明。 

{% include images-gallery.html imageCollection="createFirmware" %}

可浏览已上传的包并按标题搜索，也可下载或删除包。
点击表格行可打开包详情，详情中可复制包 ID 和校验和。
[审计日志](/docs/{{docsPrefix}}user-guide/audit-log/)会记录上传固件的用户信息。

{% include images-gallery.html imageCollection="listFirmware" %}

上述操作均可通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 完成。

## Firmware 与 Software

ThingsBoard 核心中 FOTA 与 SOTA 的实现差异很小，多数用例仅需 FOTA。
但 [LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api/) 设备对 FOTA 和 SOTA 更新的处理方式不同。 

## 将 OTA 包分配到设备配置

可将固件/软件分配到设备配置，以自动分发给使用该配置的所有设备。见下方截图。

{% include images-gallery.html imageCollection="fw-deviceprofile" %}

设备配置详情中仅可选择兼容的 OTA 更新包（详见[上传](#provision-ota-package-to-thingsboard-repository)）。
一个设备配置可能被数千台设备使用。分配固件/软件会触发[更新流程](#update-process)。


## 将 OTA 包分配到设备

也可将固件/软件分配到特定设备。见下方截图。

{% include images-gallery.html imageCollection="deviceFirmware" %}

分配到设备的固件版本会自动覆盖设备配置上的固件版本。 

For example, let's assume you have Devices D1 and D2 that has Profile P1:

* If you assign package F1 to Profile P1 (via [profile details UI](/docs/{{docsPrefix}}user-guide/ota-updates/#assign-ota-package-to-device-profile) or REST API), Devices D1 and D2 will be updated to F1. 
* If you assign package F2 to Device D1 (via [device details UI](/docs/{{docsPrefix}}user-guide/ota-updates/#assign-ota-package-to-device) or REST API), Device D1 will be updated to F2.
* Subsequent assignment of the package F3 to the Profile P1 will affect only D2, since it has no specific firmware version assigned on the device level.
So, D2 will be updated to F3, while D1 will continue to use F2.


客户可为所属设备选择并分配可用固件，但不能上传或管理固件包。

{% capture delete_restrictions %}
禁止删除已分配给至少一个设备或设备配置的固件包。
{% endcapture %}
{% include templates/info-banner.md content=delete_restrictions %}

## 更新流程

将固件/软件分配到设备或设备配置会触发更新流程。
ThingsBoard tracks the progress of the update and persists it to the device attributes.

Update progress may have one of the following states. The state of the update is stored as an attribute of the device and is used to visualize the update process on the [dashboard](#dashboard).

### QUEUED state

The very first state of the firmware/software update. 
Means that the notification about new firmware/software is queued but not yet pushed to the device. 
ThingsBoard queues the update notifications to avoid peak loads. The queue is processed with the constant pace. 
By default, it is configured to notify up to 100 device per minute. See [configuration properties](/docs/{{docsPrefix}}user-guide/ota-updates/#queue-processing-pace) for more details.
   
### INITIATED state

Means that the notification about firmware/software is fetched from queue and pushed to device.
Under the hood, ThingsBoard converts notification to the update of the following [shared attributes](/docs/{{docsPrefix}}user-guide/attributes/#shared-attributes):

- fw(sf)_title - name of the firmware (software).
- fw(sf)_version - version of the firmware (software).
- fw(sf)_size - size of the firmware (software) file in bytes.
- fw(sf)_checksum - attribute that is used to verify integrity of the received file.
- fw(sf)_checksum_algorithm - the algorithm used to calculate file checksum.

{% include images-gallery.html imageCollection="fw-attributes" %}

Device is able to subscribe to shared attribute update using [MQTT](/docs/{{docsPrefix}}reference/mqtt-api/), 
[HTTP](/docs/{{docsPrefix}}reference/http-api/), [CoAP](/docs/{{docsPrefix}}reference/coap-api/) or [LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api/) API.

### Update states reported by the device

The remaining states are reported by the device firmware/software that is currently processing the update. 
We have prepared description of those states and sample applications for the most popular protocols written in python. 
Sample applications simulate behavior of the device firmware/software and may used as a reference for the implementation.  

 * DOWNLOADING - notification about new firmware/software update was received and device started downloading the update package.
 * DOWNLOADED - device completed downloading of the update package.
 * VERIFIED - device verified the checksum of the downloaded package.
 * UPDATING - device started the firmware/software update. Typically is sent before reboot of the device or restart of the service. 
 * UPDATED - the firmware was successfully updated to the next version.
 * FAILED - checksum wasn't verified, or the device failed to update. See "Device failed" tab on the Firmware dashboard for more details.


Once the firmware/software is updated, ThingsBoard expect the device to send the following telemetry:

for firmware:
```json
{"current_fw_title": "myFirmware", "current_fw_version": "1.2.3", "fw_state": "UPDATED"}
```

for software:
```json
{"current_sw_title": "mySoftware", "current_sw_version": "1.2.3", "sw_state": "UPDATED"}
```

If the firmware/software update failed, ThingsBoard expect the device to send the following telemetry:

for firmware:
```json
{"fw_state": "FAILED", "fw_error":  "the human readable message about the cause of the error"}
```

for software:
```json
{"sw_state": "FAILED", "sw_error":  "the human readable message about the cause of the error"}
```

{% capture contenttogglespec %}
HTTP<br>%,%http%,%templates/install/http-firmware.md%br%
MQTT<br>%,%mqtt%,%templates/install/mqtt-firmware.md%br%
CoAP<br>%,%aws%,%templates/install/coap-firmware.md%br%{% endcapture %}
{% include content-toggle.liquid content-toggle-id="remoteintegrationdockerinstall" toggle-spec=contenttogglespec %}

## Dashboard

ThingsBoard provides the summary of the firmware/software update to monitor and track the firmware/software update status of your device, such as which devices are updating right now, any boot issues, and which ones have already been updated.

### Firmware update monitoring dashboard

The dashboard is created automatically for each new tenant that you add to ThingsBoard. 
You can also download the dashboard JSON [here](https://github.com/thingsboard/thingsboard/blob/master/application/src/main/data/json/demo/dashboards/firmware.json) and import it for existing tenants.

There you can see a list of all devices with full information about their firmware. 

{% include images-gallery.html imageCollection="fw-dashboard" %}

Click the "History of the firmware updates" button next to the device name to learn about the firmware update status of specific device.

{% include images-gallery.html imageCollection="fw-status" %}

### Software update monitoring dashboard

The dashboard is created automatically for each new tenant that you add to ThingsBoard.
You can also download the dashboard JSON [here](https://github.com/thingsboard/thingsboard/blob/master/application/src/main/data/json/demo/dashboards/software.json) and import it for existing tenants.

There you can see a list of all devices with full information about their software.

{% include images-gallery.html imageCollection="sw-dashboard" %}

{% unless docsPrefix contains "paas/" %}

### Configuration

#### Queue processing pace

To set the max number of devices that will be notified in the chosen time period using the following [configuration](/docs/user-guide/install/{{docsPrefix}}config/) properties:

```bash
export TB_QUEUE_CORE_FW_PACK_INTERVAL_MS=60000
export TB_QUEUE_CORE_FW_PACK_SIZE=100
```
{: .copy-code}

#### Max size setting

By default, the maximum size of firmware that we can save in database is 2 gb. It can not be configured.

{% endunless %}
