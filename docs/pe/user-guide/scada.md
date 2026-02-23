---
layout: docwithnav-pe
assignees:
- ashvayka
title: SCADA 仪表板
description: 使用 ThingsBoard 的 SCADA IoT 仪表板

scada-dashboard-layout-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/add-scada-dashboard-1-pe.png
        title: '进入「仪表板」页面，点击屏幕右上角的「plus」图标添加新仪表板。在出现的下拉菜单中选择「创建新仪表板」。在打开的对话框中输入仪表板标题，点击「添加」确认；'
    1:
        image: /images/user-guide/scada/scada-dashboards/add-scada-dashboard-2-pe.png
        title: '创建后，新仪表板将自动打开，可立即配置。点击仪表板界面左上角的「布局」；'
    2:
        image: /images/user-guide/scada/scada-dashboards/add-scada-dashboard-3-pe.png
        title: '然后将布局从「Default」改为「SCADA」，保存更改。'

layout-settings-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/layout-settings-1-pe.png
        title: '在「管理布局」窗口中点击「齿轮」图标；'
    1:
        image: /images/user-guide/scada/scada-dashboards/layout-settings-2-pe.png
        title: '将打开包含布局设置的小窗口。'

scada-columns-count-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-columns-count-1-pe.png
        title: '布局设置中的列数必须能被 24 整除（例如 24、48、72，最高 1008）；'
    1:
        image: /images/user-guide/scada/scada-dashboards/scada-columns-count-2-pe.png
        title: '列数设置为 24；'
    2:
        image: /images/user-guide/scada/scada-dashboards/scada-columns-count-3-pe.png
        title: '列数设置为 48。'

scada-minimum-layout-width-1:
      0:
        image: /images/user-guide/scada/scada-dashboards/scada-minimum-layout-width-1-pe.png
        title: 'By default, the minimum number of columns is 24. You can increase or decrease this number. The minimum number of columns is 10. We recommend the value of this setting to be equal or more then columns count value;'
      1:
        image: /images/user-guide/scada/scada-dashboards/scada-minimum-layout-width-2-pe.png
        title: 'The count of minimum columns is set to 24.'

scada-background-color-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-background-color-1-pe.png
        title: 'To change the background color, click the color in the small square on the right in the background color section. In the popup window, select the desired color and transparency. Then click "Select";'
    1:
        image: /images/user-guide/scada/scada-dashboards/scada-background-color-2-pe.png
        title: 'After saving the changes, you will see that the background color has changed.'

scada-background-image-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-background-image-1-pe.png
        title: 'To select an image from the gallery, click "Browse from gallery";'
    1:
        image: /images/user-guide/scada/scada-dashboards/scada-background-image-2-pe.png
        title: 'Choose an already uploaded image or add a new one;'
    2:
        image: /images/user-guide/scada/scada-dashboards/scada-background-image-3-pe.png
        title: 'To more precisely adjust the position of the image, click the dropdown menu of the "Background size mode" section and select how exactly the image will fill the background space;'
    3:
        image: /images/user-guide/scada/scada-dashboards/scada-background-image-4-pe.png
        title: 'see how the background has changed.'

multi-state-scada-dashboard-example-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/multi-state-dashboards-1-pe.png
        title: 'Clicking on a specific SCADA element will execute a customized action. Give it a try.'
    1:
        image: /images/user-guide/scada/scada-dashboards/multi-state-dashboards-2-pe.png
        title: ''
    2:
        image: /images/user-guide/scada/scada-dashboards/multi-state-dashboards-3-pe.png
        title: ''
    3:
        image: /images/user-guide/scada/scada-dashboards/multi-state-dashboards-4-pe.png
        title: ''

high-performance-scada-symbols:
    0:
        image: /images/user-guide/scada/scada-dashboards/high-performance-scada-symbols-1-pe.png
        title: 'High-performance SCADA dashboard.'
    1:
        image: /images/user-guide/scada/scada-dashboards/high-performance-scada-symbols-2-pe.png
        title: 'Traditional SCADA dashboard.'

add-scada-symbol-widget-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/add-scada-symbol-widget-1-pe.png
        title: '在仪表板编辑模式下，点击屏幕顶部的「+ 添加部件」图标，或（若为首次添加）点击屏幕中央的「添加新部件」打开选择部件包对话框；'
    1:
        image: /images/user-guide/scada/scada-dashboards/add-scada-symbol-widget-2-pe.png
        title: '找到「SCADA fluid system」部件包并点击；'
    2:
        image: /images/user-guide/scada/scada-dashboards/add-scada-symbol-widget-3-pe.png
        title: '选择「Horizontal wheel valve」部件。'

scada-selected-target-device-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-selected-target-device-1-pe.png
        title: 'Specify a single entity: device, asset, etc. Omit the target entity parameter if interactive behavior is not required.'

scada-symbol-device-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-symbol-device-1-pe.png
        title: 'This points to a specific SCADA symbol from the library.'

scada-behavior-settings-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-behavior-settings-1-pe.png
        title: 'The list of behavior parameters is specific to the chosen SCADA symbol and is entirely controlled by the symbol&#39;s author'

scada-action-do-nothing-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-do-nothing-1-pe.png
        title: '"Do nothing" action will just take the constant defined by the user.'

scada-action-execute-rpc-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-execute-rpc-1-pe.png
        title: '"Execute RPC" action will send a command to the target device to get the value. The value is resolved once during the creation of the widget.'

scada-action-get-attribute-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-get-attribute-1-pe.png
        title: '"Get attribute" action will subscribe to the value of the target entity&#39;s attribute. The widget will receive updates when the attribute value changes.'

scada-action-get-time-series-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-get-time-series-1-pe.png
        title: '"Get time series" action will subscribe to the value of the target entity&#39;s time series field. The widget will receive updates when new time series data arrives.'

scada-action-get-alarm-status-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-get-alarm-status-1-pe.png
        title: 'The "Get alarm status" action subscribes to the alarm status field. The widget will receive updates according to the type of alarm.'

scada-action-get-dashboard-state-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-get-dashboard-state-1-pe.png
        title: '"Get dashboard state" action will use the name of the current dashboard state. This is useful in specific cases that are not related to the state of the target device.'

scada-action-left-motor-pump-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-left-motor-pump-1-pe.png
        title: 'The "On click" action parameter defines the action that is triggered when a user clicks on the component.'

scada-action-execute-rpc-to-target-device-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-execute-rpc-to-target-device-1-pe.png
        title: '"Execute RPC" action will send a command to the target device. You can define the method and parameters of the command.'

scada-action-set-attribute-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-set-attribute-1-pe.png
        title: '"Set attribute" action will send a command to the target device. You can define the scope, key, and value of the attribute to set.'

scada-action-add-time-series-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-action-add-time-series-1-pe.png
        title: '"Add time series" action will add a new time series value to the target device. You can define the key and value of the new time series data.'

example-of-parameters-scada-symbol-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/example-of-parameters-scada-symbol-1-pe.png
        title: 'The first parameter "Opened" controls the visual representation of the SCADA symbol "Horizontal Wheel Valve" and can dynamically change, usually based on the value of an attribute or time series data received from the device. In the case of our valve, this parameter determines whether the valve is "Open" or "Closed";'
    1:
        image: /images/user-guide/scada/scada-dashboards/example-of-parameters-scada-symbol-2-pe.png
        title: 'The "Open" action sets the value "true" for the "open" attribute;'
    2:
        image: /images/user-guide/scada/scada-dashboards/example-of-parameters-scada-symbol-3-pe.png
        title: 'The "Close" action sets the value "false" for the "open" attribute.'

scada-appearance-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-appearance-1-pe.png
        title: 'For any SCADA symbol, general appearance parameters such as the symbol title and icon are available. Other parameters are specific to the selected SCADA symbol and are controlled by the symbol&#39;s author.'

scada-card-appearance-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/scada-card-appearance-1-pe.png
        title: 'The card appearance settings are generic for any SCADA symbol and include background (transparent by default), list of enabled card buttons, card border radius, and padding parameters.'


---

{% assign docsPrefix = "pe/" %}
{% include docs/user-guide/scada.md %}
