
**Edge** 实例创建后，即可使用安装说明。  
每个 **Edge** 都有包含重要凭证（如 **Edge Secret**、**Edge Key** 等）的预设配置。要访问这些配置：

{% if docsPrefix == 'pe/edge/' %}

{% assign preparedInstructionsInstall = '
    ===
        image: /images/pe/edge/installation/prepared-instructions-install-item-1-pe.png,
        title: 点击 **Edge** 实体打开其详情。
    ===
        image: /images/pe/edge/installation/prepared-instructions-install-item-2-pe.png,
        title: 点击 **「Install & Connection Instructions」** 按钮。
    ===
        image: /images/pe/edge/installation/prepared-instructions-install-item-3-pe.png,
        title: 按说明安装 **Edge** 并连接到服务器。
'%}

{% else %}

{% assign preparedInstructionsInstall = '
    ===
        image: /images/edge/installation/prepared-instructions-install-item-1-ce.png,
        title: 点击 **Edge** 实体打开其详情。
    ===
        image: /images/edge/installation/prepared-instructions-install-item-2-ce.png,
        title: 点击 **「Install & Connection Instructions」** 按钮。
    ===
        image: /images/edge/installation/prepared-instructions-install-item-3-ce.png,
        title: 按说明安装 **Edge** 并连接到服务器。
'%}

{% endif %}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=preparedInstructionsInstall %}