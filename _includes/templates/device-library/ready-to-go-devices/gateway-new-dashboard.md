### 创建新仪表盘

我们将创建仪表盘并添加最常用的部件。请参见下方说明。


{% assign creatingDashboardCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-1-ce.png,
        title: Open the Dashboards page. Click on the "+" icon in the top right corner. Select "Create new dashboard";
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-2-ce.png,
        title: Input dashboard name. For example, "My New Dashboard". Click "Add" to add the dashboard;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-3-ce.png,
        title: Your dashboard should be listed first since the table sorts dashboards using the creation time by default. Click on the "Open dashboard" icon.
    '
%}

{% assign creatingDashboardPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-1-pe.png,
        title: Open the Dashboards page. Click on the "+" icon in the top right corner. Select "Create new dashboard";
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-2-pe.png,
        title: Input dashboard name. For example, "My New Dashboard". Click "Add" to add the dashboard;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-3-pe.png,
        title: Your dashboard should be listed first since the table sorts dashboards using the creation time by default. Click on the "Open dashboard" icon.
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingDashboardPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingDashboardCE %}
{% endif %}

### 添加实体别名

别名是对部件中使用的单个实体或实体组的引用。别名可以是静态或动态的。我们将使用「单个实体」别名，引用单个实体，此处为「{{deviceName}}」。也可以配置引用多个设备的别名，例如某类型的设备或与某资产相关的设备。您可在此处了解更多关于不同别名的信息。

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
        title: Enter an alias name. Choose "Single entity" as the Filter type, select "Device" for Type, and begin typing "My New" to trigger autocomplete suggestions;
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-5-pe.png,
        title: Click "Add" and then "Save";
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-6-pe.png,
        title: Finally, click "Apply changes" in the dashboard editor to save the changes. Then you should enter edit mode again.
    '
%}

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
        title: Enter an alias name. Choose "Single entity" as the Filter type, select "Device" for Type, and begin typing "My New" to trigger autocomplete suggestions;
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-5-ce.png,
        title: Click "Add" and then "Save";
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-6-ce.png,
        title: Finally, click "Apply changes" in the dashboard editor to save the changes. Then you should enter edit mode again.
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasCE %}
{% endif %}

要添加新部件，我们需要从部件库中选择。部件按部件包分组。 
每个部件都有数据源，数据源决定了部件显示的数据。