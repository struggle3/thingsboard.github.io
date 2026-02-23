---
layout: docwithnav-gw
title: 设备重命名/删除处理
description: 设备重命名与删除处理机制

---


若设备通过 gateway API 完成供应，随后具备管理员权限的用户在 ThingsBoard 上重命名或删除该设备实体，网关将收到变更通知。

对网关而言，这是与设备实体实际状态保持同步的关键机制。

在相关改进之前，可能出现网关对设备实体的删除或重命名一无所知，导致物理设备向已不存在的端点发送数据的情况。

自 TB v3.3.3 起，平台通过 Persistent RPC 解决上述问题，避免数据丢失。以下为解决方案实现说明。

1. 设备重命名场景    
    网关使用设备实体名称上报所连设备的遥测数据。若在 ThingsBoard 界面中修改了实体名称，终端用户可能遇到网关以旧名称重新供应设备实体的情况。有了面向网关的重命名通知，此问题已不复存在。


2. 设备删除场景  
    在 ThingsBoard 界面删除设备实体会导致数据丢失，因为网关自身无法正确解析删除操作。向网关发送“已删除”通知后，网关会代表物理设备发起新的连接消息，从而避免数据丢失。

下发至网关设备的 RPC 示例：  

- 设备重命名 RPC：  

    ```json
    {
      "method": "gateway_device_renamed",
      "params": {"Old device name": "New device name"}
    }
    ```

- 设备删除 RPC：  

    ```json
    {
      "method": "gateway_device_deleted",
      "params": "Removed device name"
    }
    ```

**ThingsBoard 将 RPC 超时时间设置为 1 天。**
