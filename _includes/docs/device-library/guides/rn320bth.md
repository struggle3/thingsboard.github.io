
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://en.radionode365.com/kr/product/product_view.php?idx=102&part_idx=1" %}
{% assign officialManualLink = "/docs/devices-library/resources/manuals/rn172wcd-user-manual-v1.01.pdf" %}
{% assign thingsboardHost = "https://" | append: hostName %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- LoRaWAN gateway registered and online in The Things Stack (in our case Radionode LoRaWAN Gateway)

**Accounts & Access**

- The Things Stack account
  '
  %}

## 概述

[Radionode RN320 系列]({{deviceVendorLink}}){: target="_blank"} 是一款电池供电的 LoRaWAN® 环境传感器，面向长期、低维护部署。  
RN320-BTH 配备 17,000 mAh 大容量电池，典型条件下可运行约 10 年。  

设备集成高精度温湿度传感器，支持重传等数据可靠性机制以避免采样丢失。  
测量数据可本地存储至 microSD 卡，便于冗余与离线访问。  

通过 E-paper 显示屏、蜂鸣器与 LED 状态灯进行人机交互。  
支持通过 Radionode365 的二维码注册实现简化入网与远程监控。  

## RN-320 BTH 设备特性

- LoRaWAN® 远距离无线通信
- 高精度温湿度传感器
- E-paper 显示屏
- 蜂鸣器（97 dBA）
- 三色 LED 指示灯（优/中/差）
- 长续航（17,000 mAh，最长约 10 年）
- microSD 卡本地数据存储
- 磁吸与壁挂安装

## 前置条件

开始前请确保满足以下要求：

**Hardware**

{{ prerequisites }}
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}

**Device Information**
- DevEUI (from device label)
- JoinEUI and AppKey (for OTAA activation)
- LoRaWAN region (e.g. EU868, US915)

## The Things Stack Configuration

### Create an Application

- Log in to [The Things Stack Console](https://console.cloud.thethings.network/){:target="_blank"}.   
- Create an application in TheThingsStack console.   
- Go to the console, open **Applications** section, press the **Add application** tab.
- Fill the **application ID**, **application name**
- Click **create the application**.

{% assign TBLora1 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_3.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_1.png,
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=TBLora1 %}

### Configure Payload Formatter (Uplink Decoder)

RN320-BTH transmits sensor data in binary format. Decoding must be performed before forwarding data to ThingsBoard.
- Open your application in TTS.
- Navigate to Payload formatters → Uplink.
- Paste the following decoder:

```javascript
function decodeUplink(input) {
    const res = Decoder(input.bytes, input.fPort);
    if (res.error) {
      return { errors: [res.error] };
    }
    return { data: res };
  }

function Decoder(bytes, port) {
    const readUInt8 = b => b & 0xFF;
    const readUInt16LE = b => (b[1] << 8) + b[0];
    const readInt16LE = b => {
      const ret = readUInt16LE(b);
      return (ret > 0x7ffff) ? ret - 0x10000 : ret;
    }
    const readUInt32LE = b => (b[3] << 24) + (b[2] << 16) + (b[1] << 8) + b[0];
    const readInt32LE = b => {
      const ret = readUInt32LE(b);
      return (ret > 0x7FFFFFFF) ? ret - 0x100000000 : ret;
    }
    const readFloatLE = b => {
      const buf = new ArrayBuffer(4);
      const view = new DataView(buf);
      for (let i = 0; i < 4; i++) view.setUint8(i, b[i]);
      return view.getFloat32(0, true); // ieee754 float
    };

    const head = readUInt8(bytes[0]);
    const model = readUInt8(bytes[1]);

    if (head === 11) {
      // Check-in frame
      const timestamp = readUInt32LE(bytes.slice(2, 6));
      const date = new Date(timestamp * 1000);
      const yyyy = date.getUTCFullYear();
      const mm = (date.getUTCMonth() + 1).toString().padStart(2, '0');
      const dd = date.getUTCDate().toString().padStart(2, '0');
      const verFormatted = parseInt(`${yyyy}${mm}${dd}`);

      const interval = readUInt16LE(bytes.slice(6, 8));
      const splrate = interval;
      const bat = readUInt8(bytes[8]);
      const millivolt = readUInt16LE(bytes.slice(9, 11));
      const volt = (millivolt / 1000).toFixed(3);
      const freqband = readUInt8(bytes[11]);
      const subband = readUInt8(bytes[12]);

      return {
        head,
        ver: verFormatted,
        interval,
        splrate,
        bat,
        volt,
        freqband,
        subband
      };
    }

    else if (head === 12 || head === 13) {
      // Sensor / Hold
      const tsmode = readUInt8(bytes[2]);
      const timestamp = readUInt32LE(bytes.slice(3, 7));
      const splfmt = readUInt8(bytes[7]);

      if (splfmt !== 2) {
        return { error: "Unsupported Sensor Data Format: " + splfmt };
      }

      const raw_size = 4;
      const data = bytes.slice(8);
      const ch_count = data.length / raw_size;
      const data_size = data.length;

      let offset = 0;
      let temperature = null, humidity = null;

      if (ch_count < 2) {
        return { error: "Unsupported Sensor Data Size: " + ch_count };
      }

      temperature = parseFloat(readFloatLE(data.slice(offset, offset + raw_size)).toFixed(2));
      if (temperature <= -9999.0) temperature = null;
      offset += raw_size;

      humidity = parseFloat(readFloatLE(data.slice(offset, offset + raw_size)).toFixed(2));
      if (humidity <= -9999.0) humidity = null;

      return {
        head,
        model,
        tsmode,
        timestamp,
        splfmt,
        data_size,
        temperature,
        humidity
      };

    }

    return { error: "Unsupported head frame: " + head };
}
```
{:.copy-code.expandable-10}

{% assign TBLora2 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_2.png,
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=TBLora2 %}

### Register the End Device

Next step is an End Device creation in the TTS. Navigate to **End devices** → **Register end device**.

To register the end Device enter these details as shown in the image below:
- Select From The LoRaWAN Device Repository.
- **Input method:** Select the end device in the LoRaWAN Device Repository (Radionode devices are already registered in the Thing stack platform).
- **End device brand:** choose:
  - **Brand:** Dekist Co., Ltd 
  - **Model:** RN320-BTH
- Select the correct **frequency plan**.
- Enter the **DevEUI** correctly in the slot provided there. You can find DevEUI on the sticker on the side of the device.
- Add an **End device ID** in the slot given.
- Click **Register end device** to complete the end device registration.

{% assign TBLora3 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_4.png,
        title: Navigate to **End devices** → **Register end device**.
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_5.png,
        title: To register the end Device enter these details as shown in the image.
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_6.png,
        title: Enter the **DevEUI** correctly in the slot provided there. You can find DevEUI on the sticker on the side of the device.<br>Add an **End device ID** in the slot given.<br>Click **Register end device** to complete the end device registration.

'
%}

{% include images-gallery.liquid imageCollection=TBLora3 %}

## ThingsBoard configuration

- Log in to ThingsBoard. 
- Navigate to **Integrations &#8702; Add integration**. 
- Select **HTTP** Integration as we will be receiving data from the webhooks created in TTS (Webhook configuration we will explain later in this documentation) .
- In the payload decoder for the message received from the network server, copy and paste the following TBEL decoder code:

```javascript
var data = {};
if (payload instanceof String) {
        data = JSON.parse(payload);
} else if (payload instanceof java.util.ArrayList || payload instanceof java.util.List) {
   var str = bytesToString(payload);
       data = JSON.parse(str);
} else {
    data = payload;
}


var deviceName = data.?end_device_ids.?device_id;
if (deviceName == null){
    deviceName = "Unknown_Device";
} 

var applicationId = data.?end_device_ids.?application_ids.?application_id;
if (applicationId == null) applicationId = "Unknown_App";

var uplink = data.?uplink_message;
var decoded = {};
if (uplink != null && uplink.decoded_payload != null) {
    decoded = uplink.decoded_payload;
}

var rx = {};
if (uplink != null && uplink.rx_metadata != null && uplink.rx_metadata.size() > 0) {
    rx = uplink.rx_metadata[0];
}

var telemetry = {};

if (decoded.?temperature != null) telemetry.temperature = decoded.temperature;
if (decoded.?humidity != null) telemetry.humidity = decoded.humidity;
if (decoded.?model != null) telemetry.model = decoded.model;
if (decoded.?timestamp != null) telemetry.timestamp = decoded.timestamp;

if (rx.?rssi != null) telemetry.rssi = rx.rssi;
if (rx.?snr != null) telemetry.snr = rx.snr;

var tsString = uplink.?received_at;
var tsMillis = new Date().getTime(); 

if (tsString != null) {
    tsMillis = new Date(tsString).getTime();
}


var attributes = {
    "app_id": applicationId,
    "f_port": uplink.?f_port,
    "frequency": uplink.?settings.?frequency,
    "spreading_factor": uplink.?settings.?data_rate.?lora.?spreading_factor,
    "gateway_id": rx.?gateway_ids.?gateway_id,
    "dev_eui": data.?end_device_ids.?dev_eui
};

var result = {
    "deviceName": deviceName,
    "deviceType": "RN320-BTH",
    "telemetry": {
        "ts": tsMillis,
        "values": telemetry
    },
    "attributes": attributes
};

return result;
```
{:.copy-code.expandable-10}

- Copy and save the generated **HTTP endpoint URL**.
- Click **Add** to create the integration.

{% assign TBLora6 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_7.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_8.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_9.png,
'
%}

{% include images-gallery.liquid imageCollection=TBLora6 %}

## Create Webhook in The Things Stack

To create a webhook in the TTS platform:
- Open your application in TTS.
- Navigate to **Webhooks**.
- Select **Custom webhook**.

**General settings**
- Add a webhook ID - name for your webhook. 
- In the **Base URL** add the **endpoint URL** you copied from the ThingsBoard platform.
- In the **Additional header** option add **application/json** 
- **Save** the webhook.

Now the communication will start between the network server and the ThingsBoard platform to send data from your LoRaWAN devices to the ThingsBoard.

{% assign TBLora10 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_10.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_11.png,
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=TBLora10 %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
- Navigate to **Devices**.
- Confirm the **rn320-bth** device is created automatically.
- Check Latest Telemetry for temperature and humidity values.

{% assign TBLora11 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_12.png,
'
%}

{% include images-gallery.liquid imageCollection=TBLora11 %}

## Dashboard (Optional)

- Navigate to Dashboards → Create new dashboard.
- Add 部件 for:
  - Temperature 
  - Humidity 
  - RSSI / SNR
- Bind 部件 to the RN320-BTH device.

A sample of the dashboard created is shown in the pictures below.

{% assign TBLora12 = '
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_13.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_14.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_15.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_16.png,
    ===
        image: /images/devices-library/ready-to-go-devices/rn320bth/TB_Lora_17.png,'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=TBLora12 %}
