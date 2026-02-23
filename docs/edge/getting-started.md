---
layout: docwithnav-edge
title: ThingsBoard Edge快速入门
description: ThingsBoard Edge快速入门 

step1:
    0:
        image: /images/edge/getting-started/step-1-item-1-ce.webp
        title: 'Go to the <b>Entities > Devices</b> section.'
    1:
        image: /images/edge/getting-started/step-1-item-2-ce.webp 
        title: 'Click the <b>"+"</b> icon and select the <b>"Add new device"</b> option. Enter a name for the device, for example, "My New Device". No other changes are required. Click the <b>"Add"</b> button to create the device.'
    2:
        image: /images/edge/getting-started/step-1-item-3-ce.webp
        title: 'After the device is created, instructions on how to check its <b>connectivity</b> will be provided. Select the <b>messaging protocol</b> and your <b>operating system</b>. Install the required client tools, then copy the provided command.'
    3:
        image: /images/edge/getting-started/step-1-item-4-ce.webp
        title: 'Run the previously copied command. Once the "temperature" readings are published, the device state will change from <span style="color:red">"Inactive"</span> to <span style="color:green">"Active"</span>, and you will see the published "temperature" readings. Finally, close the connectivity window.'
    4:
        image: /images/edge/getting-started/step-1-item-5-ce.webp
        title: 'To verify the received telemetry, click on the device entity and open the <b>"Latest Telemetry"</b> tab.'

step2-1:
    0:
        image: /images/edge/getting-started/step-4-item-1-ce.webp
        title: 'Click the <b>"+"</b> icon and select the <b>"Create new dashboard"</b> option from the drop-down menu.'
    1:
        image: /images/edge/getting-started/step-4-item-2-ce.webp
        title: 'Enter the dashboard name, for example, "New Dashboard", and click the <b>"Add"</b> button to create the dashboard.'

step2-2:
    0:
        image: /images/edge/getting-started/step-4-item-3-ce.webp
        title: 'Click the <b>"Add widget"</b> button.'
    1:
        image: /images/edge/getting-started/step-4-item-4-ce.webp
        title: 'Locate the <b>"Tables"</b> bundle and click on it.'        
    2:
        image: /images/edge/getting-started/step-4-item-5-ce.webp
        title: 'Select the <b>"Entities table"</b> widget.'
    3:
        image: /images/edge/getting-started/step-4-item-6-ce.webp
        title: 'In the <b>"Add Widget"</b> pop-up window, select the previously created device, "My New Device", in the <b>"Device"</b> field.<ul><li>The <b>“name”</b> key has already been added to the <b>“Columns”</b> section. It will display the column with the device name.</li><li>To add another column with different key value, click the <b>"Add column"</b> button.</li></ul>'
    4:
        image: /images/edge/getting-started/step-4-item-7-ce.webp
        title: 'To select an additional data key to display, click on the newly appeared field. In the drop-down menu, you will see the list of the available data keys. Select the <b>"temperature"</b> data key. Click the <b>"Add"</b> button.'
    5:
        image: /images/edge/getting-started/step-4-item-9-ce.webp
        title: 'The <b>"Entities table"</b> widget has been added, and <b>"My New Device"</b> is now displayed in the list. To add another widget, click the <b>"Add widget"</b> button.'
    6:
        image: /images/edge/getting-started/step-4-item-10-ce.webp
        title: 'Locate the <b>"Charts"</b> widgets bundle and click on it.'
    7:
        image: /images/edge/getting-started/step-4-item-11-ce.webp
        title: 'Select the <b>"Time series chart"</b> widget.'
    8:
        image: /images/edge/getting-started/step-4-item-12-ce.webp
        title: 'Select the previously created device, "My New Device", as the <b>data source</b>, and click the <b>"Add"</b> button. The <b>"Time series chart"</b> widget has been successfully added to the dashboard.'
    9:
        image: /images/edge/getting-started/step-4-item-13-ce.webp
        title: 'After configuring all the desired widgets, you can adjust their size and placement on the dashboard as needed. Drag and drop the widget to reposition it on the dashboard.'
    10:
        image: /images/edge/getting-started/step-4-item-14-ce.webp
        title: 'To resize the widget, drag its bottom-right corner.'
    11:
        image: /images/edge/getting-started/step-4-item-15-ce.webp
        title: 'To apply all changes to the dashboard, click the <b>"Save"</b> button in the upper-right corner of the screen.'
    12:
        image: /images/edge/getting-started/step-4-item-16-ce.webp
        title: 'Congratulations! You have successfully configured the dashboard. Now, all new telemetry readings will instantly appear on the dashboard widgets.'
        
step3:
    0:
        image: /images/edge/getting-started/step-3-item-1-ce.webp
        title: 'Within your <b>Edge</b> instance, go to the <b>Rule Chains</b> section and open the <b>"Edge Root Rule Chain"</b>.'
    1:
        image: /images/edge/getting-started/step-3-item-2-ce.webp
        title: 'The <a href="/docs/user-guide/rule-engine-2-0/nodes/action/push-to-cloud/" target="_blank">Push to Cloud</a> rule node is used to transmit messages from edge to cloud after they have been stored in the local database.'
 
step4:
    0:
        image: /images/edge/getting-started/step-2-item-1-ce.webp
        title: 'Navigate to the <b>Devices</b> section to confirm that the newly created device, "My New Device", has been published to the <b>ThingsBoard Server (Cloud)</b>.'
    1:
        image: /images/edge/getting-started/step-2-item-2-ce.webp
        title: 'Click on the "My New Device" to open the <b>"Device details"</b> page and select the <b>"Relations"</b> tab. Switch the direction from <b>"From"</b> to <b>"To"</b> to view the relation to the Edge that provisioned this device.'
   
step5Server:
    0:
        image: /images/edge/getting-started/step-5-item-1-ce.webp
        title: 'Then, navigate to the <b>Edge management > Instances</b> section and click on the <b>"Manage dashboards"</b> button of the instance in question.'
    1:
        image: /images/edge/getting-started/step-5-item-2-ce.webp
        title: 'On the <b>Edge Dashboards</b> page, you will see all the dashboards that are already assigned to this <b>Edge</b>. Click the <b>"+"</b> icon and select newly created dashboard from the drop-down menu. Click the <b>"Assign"</b> button to confirm the assignment.'

step5Edge:
    0:
        image: /images/edge/getting-started/step-5-item-3-ce.webp
        title: 'Go to the <b>Dashboards</b> section and open the dashboard you have created on the <b>ThingsBoard社区版Server</b>'    
    1:
        image: /images/edge/getting-started/step-5-item-4-ce.webp
        title: 'Verify that these are the same widgets that you have added on the Cloud.'

---

* TOC
{:toc}

{% assign currentThingsBoardVersion = "ThingsBoard Community Edition" %}

{% include templates/edge/getting-started/introduction.md %}

{% capture difference %}
Looking for **white-labeling** or **premium features**? <a href="/docs/pe/edge/" target="_blank">Explore Edge Professional Edition documentation →</a>
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include templates/edge/getting-started/prerequisites.md %}

## 步骤 1. 连接设备并发送遥测数据

{% include templates/edge/getting-started/step-1.md %}

## 步骤 2. 创建仪表板并配置部件

{% include templates/edge/getting-started/step-2.md %}

## 步骤 3. 将数据从Edge推送到云端

{% include templates/edge/getting-started/step-3.md %}

## 步骤 4. 从Edge向服务器配置实体

{% include templates/edge/getting-started/step-4.md %}

## 步骤 5. 从服务器向Edge配置实体

{% include templates/edge/getting-started/step-5.md %}

## 您的反馈

恭喜！您已成功完成 **ThingsBoard Edge** 的初始配置步骤。现在您可以发送新的遥测数据，它们将立即显示在仪表板上。

欢迎通过 [GitHub/Issues](https://github.com/thingsboard/thingsboard-edge/issues){: target="_blank"} 或["联系我们"](https://thingsboard.io/docs/contact-us/){: target="_blank"}表单提供反馈，帮助我们改进。
若您能在 [GitHub](https://github.com/thingsboard/thingsboard-edge){: target="_blank"} 上为我们的项目加星，我们将不胜感激！

## 下一步

{% assign currentGuide = "GettingStartedGuide" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}
