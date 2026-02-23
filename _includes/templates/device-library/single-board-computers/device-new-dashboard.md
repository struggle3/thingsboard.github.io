### 创建新仪表盘

我们将创建仪表盘并添加最常用的部件。请参见下方说明。

{% assign creatingNewDashboardPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-1-pe.png,
        title: Open the **Dashboards** page. Click on the **"+"** icon in the top right corner. Select **"Create new dashboard"**;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-2-pe.png,
        title: Input dashboard name. For example, "My New Dashboard". Click **"Add"** to add the dashboard;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-3-pe.png,
        title: Your dashboard should be listed first since the table sorts dashboards using the time of the creation by default. Click on the **"Open dashboard"** icon.
    '
%}

{% assign creatingNewDashboardCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-1-ce.png,
        title: Open the Dashboards page. Click on the **"+"** icon in the top right corner. Select **"Create new dashboard"**;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-2-ce.png,
        title: Input dashboard name. For example, "My New Dashboard". Click **"Add"** to add the dashboard;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-3-ce.png,
        title: Your dashboard should be listed first since the table sorts dashboards using the creation time of the creation by default. Click on the **"Open dashboard"** icon.
    '
%}

{% assign creatingNewDashboardEdgePE = '
    ===
        image: /images/edge/config/general/create-new-dashboard-pe.webp,
        title: Open the Dashboards page. Click on the **"+"** icon in the top right corner. Select **"Create new dashboard"**;
    ===
        image: /images/edge/config/general/new-dashboard-dialog-pe.webp,
        title: In the pop-up window, enter a dashboard title. Other fields are optional. Click the **"Add"** button to proceed;
    ===
        image: /images/edge/config/general/dashboard-edit-mode-pe.webp,
        title: After creating the dashboard, you will automatically transition to edit mode. 
'
%}

{% assign creatingNewDashboardEdgeCE = '
    ===
        image: /images/edge/config/general/create-new-dashboard.webp,
        title: Go to the **Dashboards** section. Click on the **"+"** icon in the top right corner. Select **"Create new dashboard"**;
    ===
        image: /images/edge/config/general/new-dashboard-dialog.webp,
        title: In the pop-up window, enter a dashboard title. Other fields are optional. Click the **"Add"** button to proceed;
    ===
        image: /images/edge/config/general/dashboard-edit-mode.webp,
        title: After creating the dashboard, you will automatically transition to edit mode.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingNewDashboardPE %}
{% elsif page.docsPrefix == "pe/edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingNewDashboardEdgePE %}
{% elsif page.docsPrefix == "edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingNewDashboardEdgeCE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingNewDashboardCE %}
{% endif %}

### 添加实体别名

别名是对部件中使用的单个实体或实体组的引用。别名可以是静态或动态的。我们将使用「单个实体」别名，引用单个实体，此处为「{{deviceName}}」。也可以配置引用多个设备的别名，例如某类型的设备或与某资产相关的设备。您可在此处了解更多关于不同别名的信息。

{% assign creatingEntityAliasCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-1-ce.png,
        title: Enter edit mode. Click on the pencil button in the bottom right corner;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-2-ce.png,
        title: Click the "Entity Aliases" icon in the top right part of the screen. You will see an empty list of Entity aliases;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-3-ce.png,
        title: Click "Add alias";
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-4-ce.png,
        title: Enter an alias name (for example, "My Device"). Choose "Single entity" as the Filter type, select "Device" for Type, and begin typing "My New" to trigger autocomplete suggestions;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-5-ce.png,
        title: Click "Add" and then "Save";
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-6-ce.png,
        title: Finally, click "Apply changes" in the dashboard editor to save the changes. Then you should enter edit mode again.
    '
%}

{% assign creatingEntityAliasPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-1-pe.png,
        title: Enter edit mode. Click on the pencil button in the bottom right corner;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-2-pe.png,
        title: Click the "Entity Aliases" icon in the top right part of the screen. You will see an empty list of Entity aliases;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-3-pe.png,
        title: Click "Add alias";
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-4-pe.png,
        title: Enter an alias name (for example, "My Device"). Choose "Single entity" as the Filter type, select "Device" for Type, and begin typing "My New" to trigger autocomplete suggestions;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-5-pe.png,
        title: Click "Add" and then "Save";
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-6-pe.png,
        title: Finally, click "Apply changes" in the dashboard editor to save the changes. Then you should enter edit mode again.
    '
%}

{% assign creatingEntityAliasEdgeCE = '
    ===
        image: /images/edge/config/general/create-alias-1-ce.webp,
        title: In the dashboard edit mode, click the **"Entity aliases"** icon in the top right corner.
    ===
        image: /images/edge/config/general/create-alias-2-ce.webp,
        title: Click **“Add alias”**.
    ===
        image: /images/edge/config/general/create-alias-3-ce.webp,
        title: Enter the alias name (for example, “My Device”). Select **"Single entity"** as the filter type and **"Device"** as the type. Then, select the device from the drop-down menu. Click the **"Add"** button.
    ===
        image: /images/edge/config/general/create-alias-4-ce.webp,
        title: Click **"Save"** to save the entity alias.
    ===
        image: /images/edge/config/general/create-alias-5-ce.webp,
        title: Finally, click **"Save"** on the dashboard editor page to save the changes. Then, re-enter edit mode.
'
%}

{% assign creatingEntityAliasEdgePE = '
    ===
        image: /images/edge/config/general/create-alias-1-pe.webp,
        title: In the dashboard edit mode, click the **"Entity aliases"** icon in the top right corner.
    ===
        image: /images/edge/config/general/create-alias-2-pe.webp,
        title: Click **“Add alias”**.
    ===
        image: /images/edge/config/general/create-alias-3-pe.webp,
        title: Enter the alias name (for example, “My Device”). Select **"Single entity"** as the filter type and **"Device"** as the type. Then, select the device from the drop-down menu. Click the **"Add"** button.
    ===
        image: /images/edge/config/general/create-alias-4-pe.webp,
        title: Click **"Save"** to save the entity alias.
    ===
        image: /images/edge/config/general/create-alias-5-pe.webp,
        title: Finally, click **"Save"** on the dashboard editor page to save the changes. Then, re-enter edit mode.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasPE %}
{% elsif page.docsPrefix == "pe/edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasEdgePE %}
{% elsif page.docsPrefix == "edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasEdgeCE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasCE %}
{% endif %}

要添加新部件，我们需要从部件库中选择。部件按部件包分组。 
每个部件都有数据源，数据源决定了部件显示的数据。以查看在步骤 2 中发送的「cpu_usage」数据的最新值。 


- 进入编辑模式，点击 **「添加新部件」** 按钮；
- 选择 **「Charts」** 部件包，点击 Entities 部件的标题，**「添加部件」** 窗口将出现；
- 点击 **「添加」** 添加数据源。部件可有多个数据源，我们此处仅使用一个；
- 选择 **「{{deviceName}}」** 实体别名，然后点击右侧输入框，将显示可用数据点的自动完成，选择 **「cpu_usage」** 数据点并点击 **「添加」**；
- 可拖拽部件右下角以放大部件。可自由探索高级设置以进行更多部件修改。