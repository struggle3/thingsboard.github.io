{% assign integrationType = include.integration-type | downcase %}
{% assign integrationTypeCorrectName = include.integration-type-correct-name %}

<br><b>步骤 2：将上行数据转换器导入 ThingsBoard</b>

下载包含上行数据转换器配置的文件后，将其导入 ThingsBoard：

- 在**集成中心**部分的**数据转换器**页面中操作。
- 点击页面右上角的**+**图标，从下拉菜单选择**导入转换器**。
- 将下载的 JSON 文件（包含上行数据转换器配置）拖放到导入窗口，然后点击**导入**。
- 上行数据转换器现已成功导入。

{% assign uplinkConverter = '
    ===
    image: /images/devices-library/basic/integrations/import-uplink-converter-1.png,
    title: 在**集成中心**部分的**数据转换器**页面中操作。点击页面右上角的**+**图标，从下拉菜单选择**导入转换器**。
    ===
    image: /images/devices-library/basic/integrations/import-uplink-converter-2.png,
    title: 将下载的 JSON 文件（包含上行数据转换器配置）拖放到导入窗口，然后点击**导入**。
    ===
    image: /images/devices-library/basic/integrations/integration_type/import-uplink-converter-3.png,
    title: 上行数据转换器现已成功导入。
    ' | replace: "integration_type" , integrationType
%}

{% include images-gallery.liquid imageCollection=uplinkConverter %}

<br><b>步骤 3：在 {{integrationTypeCorrectName}} 集成中替换上行数据转换器</b>

现在，将您的 {{integrationTypeCorrectName}} 集成更新为使用新的上行数据转换器：
- 进入**集成中心**部分的**集成**页面。
- 点击您的 {{integrationTypeCorrectName}} 集成以打开详情窗口。
- 点击右上角的橙色铅笔按钮进入编辑模式。
- 使用导入的转换器替换现有上行数据转换器。
- 别忘了保存更改！

{% assign editIntegration = '
    ===
    image: /images/devices-library/basic/integrations/integration_type/edit-integration-1.png,
    title: 进入**集成中心**部分的**集成**页面。点击您的 integration_correct_name 集成以打开详情窗口。点击右上角的橙色铅笔按钮进入编辑模式。
    ===
    image: /images/devices-library/basic/integrations/integration_type/edit-integration-2.png,
    title: 使用导入的转换器替换现有上行数据转换器。
    ===
    image: /images/devices-library/basic/integrations/integration_type/edit-integration-3.png,
    title: 别忘了保存更改！
    ' 
    | replace: "integration_correct_name" , integrationTypeCorrectName
    | replace: "integration_type" , integrationType 
%}

{% include images-gallery.liquid imageCollection=editIntegration %}