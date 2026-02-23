
* TOC
{:toc}

## 批量配置概述

ThingsBoard 提供使用 CSV 文件对以下实体类型进行批量配置的选项：

 - **Devices（设备）**
 - **Assets（资产）**


不同实体可具有以下参数：

 - **Attributes（属性）** - 与实体关联的静态和半静态键值对。例如序列号、型号、固件版本；
 - **Telemetry data（遥测数据）** - 可供存储、查询和可视化的时序数据点。例如温度、湿度、电池电量；
 - **Credentials（凭据）** - 供设备上运行的应用程序连接 ThingsBoard 服务器使用。

## 导入实体

要一次性创建多个实体，需创建 CSV 文件，其中每行负责创建一个具有给定参数的实体。<br>
若无需为某实体添加某些设置，请将该单元格留空。<br>
有三个保留参数名：Name、Type 和 Label，具有预定义列类型。

### 步骤 1：选择文件

将 CSV 文件上传到系统。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-1.gif" alt="bulk provision step 1">

### 步骤 2：导入配置

对于已上传的文件，需配置以下参数：：

 - **CSV delimiter（CSV 分隔符）** - 数据行中值之间的分隔字符；
 - **First line contains column names（首行包含列名）** - 若启用此选项，文件首行将作为下一步参数名的默认值；
 - **Update attributes/telemetry（更新属性/遥测）** - 若启用此参数，对于名称与 ThingsBoard 系统中现有实体匹配的所有实体，将更新其参数值。否则，对于名称已存在于 ThingsBoard 系统的所有实体，将显示错误消息。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-2.gif" alt="bulk provision step 2">

### 步骤 3：选择列类型

在此步骤中，需定义下载文件的列与 ThingsBoard 平台中数据类型之间的对应关系。还可设置/更改属性/遥测 key 的默认名称。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-3.gif" alt="bulk provision step 3">

### 步骤 4：创建新实体

处理输入数据。

### 步骤 5：完成

查询执行结果：创建/更新的实体数量以及执行期间发生的错误数量。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-5.gif" alt="bulk provision step 5">


## 用例

假设我们要同时创建 10 台设备并为其分配访问令牌。<br><br>
示例文件：
{% capture tabspec %}sample-file
A,test-import-device.csv,text,resources/test-import-device.csv,/docs/{{docsPrefix}}user-guide/resources/test-import-device.csv{% endcapture %}
{% include tabs.html %}
**注意**：文件应至少包含两列：实体名称和类型。<br>

<br>文件使用 CSV 文件编辑器创建，包含 10 台设备的数据。此外，**Device 5** 的 **Data2** 参数已省略，该设备不会创建此参数。

### 上传文件

进入 **Devices** -> **Import device**

上传示例文件：**test-import-device.csv**

![image](/images/user-guide/bull-provisioning/import-device-select-file.png)

### 导入配置

 - **CSV delimiter** - 选择编辑器的分隔符号。示例文件中分隔符为「,」；
 - **First line contains column names** - 示例文件包含列名，因此保留此选项勾选；
 - **Update attributes/telemetry** - 取消勾选此选项，因为我们将添加新设备，而非更新 ThingsBoard 平台中现有设备的参数。

![image](/images/user-guide/bull-provisioning/import-device-config.png)

### 选择列类型

表格第一列显示包含数据的第一行。<br>
由于上一步已勾选 **First line contains column names**，第三列的值已根据文档首行初始化。<br>
修改部分属性。将第三行的列类型改为 **Timeseries**，并设置属性/遥测 key 值，例如 **Temperature**。<br>
下表最后一行负责令牌，因此将 **Server attribute** 改为 **Access token**。<br><br>

![image](/images/user-guide/bull-provisioning/import-device-column-type.png)<br>
**注意**：Name、Type 和 Access token 等列类型只能选择一行。

### 导入完成

创建流程完成后，将显示统计信息。<br>
以下示例中，8 台设备创建成功，2 台设备创建时发生错误。原因是给定示例文件中 Device 1、Device 2 和 Device 3 具有相同令牌。ThingsBoard 系统禁止此操作。

![image](/images/user-guide/bull-provisioning/import-device-info-created.png)<br>
