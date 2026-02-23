### Device configuration

连接并发送数据前，需配置设备和网络服务器。  
首先配置设备，并保存网络服务器配置所需信息。  
要将设备加入网络服务器并从中获取信息，需准备以下设备参数：

- **Device EUI** — device identifier
- **Application EUI** — application identifier
- **Application Key** — application key to identify device. We recommend to use a generated key, not from the example!

以上参数为连接所必需。

根据网络服务器要求，可能还需提供接入类型（OTAA）和 LoRaWAN 版本。

### Prerequisites

- **Android app & account**  
  Install the ioTracker Configurator app from Google Play and log in with your ioTracker account.
- **Device compatibility**  
  Only with ioTracker accounts after February 1, 2022 are supported.
- **Bluetooth & permissions**  
  Enable Bluetooth and grant Location/"Nearby devices" permissions to the app.

### 1. Scanning & Connecting

1. Open **ioTracker Configurator** and tap **Refresh** (or **Scan**) to discover devices.
2. Select your ioTracker or ioButton from the list and tap **Login**; enter your credentials to establish Bluetooth.

### 2. LoRaWAN Menu

From the **Main menu**, tap **Configuration** to access LoRaWAN functions.  
![LoRaWAN menu screenshot](/images/devices-library/io-things-lorawan-menu.png)

### Change LoRaWAN Keys

- Click the **edit/pencil** icon next to **DevEUI**, **AppEUI**, and **AppKey**.
- Enter your new LoRaWAN **DevEUI**, **AppEUI**, and **AppKey**.
- Click **Update**.
- **Reboot** the device to activate the new keys.  
  ![Change LoRaWAN keys screenshot](/images/devices-library/io-things-lorawan-lorakeys.png)

### Check LoRaWAN Status

- **Active Region**: the frequency band in use.
- **LoRaWAN Version**: the specification version.
- **Join Status**: **JOINED** or **NOT JOINED**.
- **Last Uplink**: timestamp, payload, message type, DataRate, channel, TxPower, TxToA, UpCntr.
- **Last Downlink**: timestamp, payload, DataRate, RxSlot, port, RSSI, SNR, ACK flag, DownCntr.  
  ![LoRaWAN status overview screenshot](/images/devices-library/io-things-lorawan-overview.png)