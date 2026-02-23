
获得访问令牌后即可配置 MI-8。  
所有 MI-8 DAQ 均通过 SD 卡根目录下的 **config.json** 文件配置。  
MI-8 [用户手册](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf)包含修改此文件的详细说明，本示例侧重 name 和 push 字段。  
以下为配置文件中存在的字段。  

```json
{
   "name":"My MI-8 DAQ",
   "thermo_type":["k","k","k","k","k","k"],
   "num_thermo":3,
   "num_rtd":2,
   "ref_resistance":4000,
   "rtd_type":["pt100","pt100","pt100","pt100"],
   "rtd_connection":[4,4,4,4],
   "dig_in_mode":["pulldown","pulldown","pulldown"],
   "use_aux_header":false,
   "debug_level":255,
   "usb_mass_storage":true,
   "sleep_voltage":9.9,
   "wake_voltage":10.5,
   "display_sleep":10,
   "gnss_period":60,
   "flip_display":false,
   "network": {
      "apn":"hologram",
      "username":"",
      "password":""
   },
   "push": {
      "mode":"post",
      "path":"api/v1/YOUR_ACCESS_TOKEN/telemetry",
      "attributes_path":"api/v1/YOUR_ACCESS_TOKEN/attributes",
      "server": "{{hostName}}",
      "port":80,
      "username":"",
      "password":"",
      "use_ssl":false,
      "use_json":true,
      "push_attributes":true,
      "include_name":false,
      "include_imei":false,
      "include_iccid":false,
      "track_min_max":false,
      "use_headers":false
   },
   "trigger":[ {
      "name":"Default",
      "channels":"ambient,tc0,tc1,tc2,rtd0,rtd1,an0,lat,lon,alt,vbat,rssi",
      "log_period":60,
      "push_period":300,
      "start_delay":0,
      "stop_delay":0,
      "condition":"1",
	  "append_log":true
   }]
}
```
{:.copy-code}

连接所需修改的参数：

| 参数 | 默认值 | 说明 |
|-|-|
| path | **api/v1/YOUR_ACCESS_TOKEN/telemetry** | 将 **YOUR_ACCESS_TOKEN** 替换为 ThingsBoard 上该设备的访问令牌。 |
| attributes_path | **api/v1/YOUR_ACCESS_TOKEN/attributes** | 将 **YOUR_ACCESS_TOKEN** 替换为 ThingsBoard 上该设备的访问令牌。 | 
| server | **{{hostName}}** | 您的 ThingsBoard 实例地址。 |
| port | **80** | 您的 ThingsBoard 实例 HTTP 端口。可将 **port** 设为 443、**use_ssl** 设为 true 以使用 SSL 加密（HTTPS）。两种协议均支持，但 HTTPS 每次推送会消耗更多蜂窝数据。|

其他配置参数：

- name 字段在此文件中为可选。该名称显示在 MI-8 OLED 屏幕上，并作为设备属性发送到 ThingsBoard。建议 config.json 中的名称与 ThingsBoard 中的设备名称一致，但非必须。name 字段不用于关联 MI-8 与 ThingsBoard 之间的遥测数据，仅供用户参考。  
- push 字段描述与 ThingsBoard 服务器的连接。本示例使用 HTTP POST 请求（"mode":"post"）。也支持 MQTT，但 POST 消耗的蜂窝数据更少。HTTP 请求 URL 由 server、port、use_ssl 及 path/attributes_path 字段构成。  
- use_ssl 字段指明使用 HTTP 还是 HTTPS。server 字段为双斜杠 '//' 与冒号之间的内容，其后为 port 和斜杠，再之后为 path。  
- 将 push_attributes 设为 true，使属性（如 MI-8 IMEI 等不常变化的数据）在每次上电时发送一次。  
- 将 use_json 设为 true。发往 ThingsBoard 的所有数据应以 JSON 格式。  
- 将 use_headers 设为 false。ThingsBoard 不要求 HTTP 头，但每次推送会消耗额外蜂窝数据。  
- 可将 include_name、include_imei 和 include_iccid 设为 false。这些字段会使 ICCID、IMEI 和 MI-8 名称包含在遥测推送中，从而消耗额外蜂窝数据。此处无需包含，因其已在每次 MI-8 上电时通过单独的 attributes HTTP 请求发送至 ThingsBoard。  

添加或修改配置文件后，请执行以下步骤：  
- 保存 config.json
- 断开 PC 与 MI-8 USB 端口的连接（若已连接且启用大容量存储）
- 对 MI-8 进行上下电以使新设置生效。