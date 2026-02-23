* TOC
{:toc}

欢迎来到教程系列第二部分！
若未完成第一部分，我们已介绍基础：熟悉 assets 和 devices、添加 dashboard 和第一个部件。
强烈建议先完成 lesson 1。

<br>
<p><a href="/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-1/" class="button">第1课：使用 OpenStreet Map 和实体表格部件可视化资产数据</a></p>

<br>

本课将继续开发项目。我们将为建筑和办公室添加 states，并实现它们之间的导航。
还会继续添加部件，包括在 office 平面图上展示设备布局的部件。

{% include default-carousel.liquid collectionMap = 'dashboard-lesson-2' nonActiveItemsVisibility=false %}

## 添加建筑和办公室状态

Dashboard [states](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"} 可在 dashboard 内创建多级层级结构，可将每个 state 视为独立页面。
例如，每栋建筑、每间办公室和每台设备均可有各自的 state。我们已有默认 ("Buildings") state，用于在地图上展示建筑列表及位置。

需再添加若干 states："building"、"office" 以及每台设备的 state。

本课将重点添加和配置建筑、办公室的 states。设备 states 将在下节课添加。

**为建筑添加 state**

按以下步骤添加新 state：

{% include images-gallery.html imageCollection="adding-building-state" showListImageTitles="true" %}

**为办公室添加 state**

重复上述步骤为办公室添加 state：

{% include images-gallery.html imageCollection="adding-office-state" showListImageTitles="true" %}

新状态已添加， 接下来配置它们与默认状态之间的导航。 

## 建筑状态

所选建筑的 state 会展示该建筑的完整信息。
可查看建筑地址、租赁负责人联系方式，以及该建筑内的办公室列表。

我们将只配置一个 "building" state，而不是为每栋建筑单独配置。
得益于 "[Entity from dashboard state](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state){:target="_blank"}" alias，每次选择不同建筑时，部件会自动拉取并显示对应数据。

### 默认 state 与建筑 state 之间的导航

通过 action 函数实现 states 之间的导航。
[action](/docs/{{docsPrefix}}user-guide/ui/widget-actions){:target="_blank"} 函数可用于切换到 dashboard 新 state、在 dashboards 间导航、跳转到 URL 表示的外部资源或执行其它用户可配置操作。

<br>
**为地图部件添加 action**

我们将添加通过 tooltip 在 [OpenStreet Map 部件](/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-1/#openstreet-map-widget){:target="_blank"} 中点击建筑标记时切换到对应建筑 state 的能力。
使用 "[Navigate to new dashboard state](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#navigate-to-new-dashboard-state){:target="_blank"}" action。开始操作：

- 在 dashboard 编辑模式下，点击地图部件的"铅笔"图标进入其编辑模式；
- 进入"Actions"选项卡并点击"plus"图标添加 action；
- 选择 "[Tooltip tag action](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#tooltip-tag-action){:target="_blank"}" 作为 action 来源，命名为 "building_details"，将 action 类型设为 "Navigate to new dashboard state"，并指定 "building" state 为 "Target dashboard state"。点击"Add"；

在"Actions"窗口中可见已配置的 action。接下来只需在弹出菜单中添加"Details"行以切换到新 state。

{% include images-gallery.html imageCollection="map-widget-navigation-between-states-1" %}

- 进入"Appearance"选项卡，找到"Tooltip"区域，在 `;` 前将以下行添加到现有 tooltip 末尾：

```text
            +
        '<div style="text-align:center;background:var(--tb-primary-50, #87ceeb);border-radius:6px">' +
            '<link-act name="building_details">Details ></link-act>' +
        '</div>'
```
{: .copy-code}

或用以下 tooltip 替换现有 tooltip：

```js
const address = data.address ? data.address : 'N/A';
const email = data.email ? data.email : 'N/A';
const phone = data.phone ? data.phone : 'N/A';
const buildingImage = data.buildingImage ? data.buildingImage : 'Building image not found';
return '<div style="display:flex;flex-direction:column;font-family:\'Roboto\';font-weight:500;font-size:14px;line-height:24px;letter-spacing:0.25px;color:#29313C;margin-bottom:5px">' +
            `<img style="width: 300px; height: auto" src=${buildingImage}>` +
            '<div style="margin-top:5px;">${entityName}</div>' +
            '<div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;gap:10px">' +
                '<div style="font-size:11px;line-height:16px;font-weight:500;color:rgba(0, 0, 0, 0.38);">Address</div>' +
                '<div style="font-size:12px;line-height:20px;font-weight:500;color:#29313C;letter-spacing:0.25px;text-align:right;">'+ address +'</div>' +
            '</div>' +
            '<div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;gap:10px">' +
                '<div style="font-size:11px;line-height:16px;font-weight:500;color:rgba(0, 0, 0, 0.38);">Email</div>' +
                '<div style="font-size:12px;line-height:20px;font-weight:500;color:#29313C;letter-spacing:0.25px;text-align:right;">'+ email +'</div>' +
            '</div>' +
            '<div style="display:flex;flex-direction:row;align-items:baseline;justify-content:space-between;gap:10px">' +
                '<div style="font-size:11px;line-height:16px;font-weight:500;color:rgba(0, 0, 0, 0.38);">Phone</div>' +
                '<div style="font-size:12px;line-height:20px;font-weight:500;color:#29313C;letter-spacing:0.25px;text-align:right;">'+ phone +'</div>' +
            '</div>'+
       '</div>' +
        '<div style="text-align:center;background:var(--tb-primary-50, #87ceeb);border-radius:6px">' +
            '<link-act name="building_details">Details ></link-act>' +
        '</div>';
```
{:.copy-code.expandable-4}

{% capture difference %}
确保创建的 action 名称与函数中指定的名称一致。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

- 保存部件和 dashboard 的更改；

{% include images-gallery.html imageCollection="map-widget-navigation-between-states-2" %}

Now, when you click on any building marker of the map widget, a tooltip with "Details" line will appear. Clicking on it will navigate you to the state of the selected building.

{% include images-gallery.html imageCollection="map-widget-navigation-between-states-3" %}

<br>
**为 "Buildings list" 部件添加 action**

为 "[Buildings list](/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-1/#adding-buildings-list-widget){:target="_blank"}" 部件添加 action，使点击建筑名称时跳转到其 state。

{% include images-gallery.html imageCollection="adding-action-buildings-list-widget" showListImageTitles="true" %}

在 "Buildings list" 部件中选择对应建筑以切换到 "Building A" state：

{% include images-gallery.html imageCollection="navigation-between-states-1" showListImageTitles="true" %}

切换到 "Building B" state：

{% include images-gallery.html imageCollection="navigation-between-states-2" showListImageTitles="true" %}

<br>
**Adding a background image for the building state**

Let's add a background image for the new state to make it visually more attractive. You can use [the image from this tutorial](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/building-background.png){:target="_blank"} or upload your own image.

{% include images-gallery.html imageCollection="background-image-building-state" showListImageTitles="true" %}

Now let's move on to adding widgets to the "building" state.

### Adding information card about building

The first widget we'll add to the "building" state is a card that displays information about the selected building. It will include the building's address, contact person, phone number, and email address.

- 点击屏幕中央大图标 "Add new widget"；
- 从 "Cards" 部件包中选择 "Markdown/HTML Card"；
- 添加 alias 以定义数据来源实体。在 "Alias" 字段输入 "Selected entity"，点击 "Create a new one"；
- 指定 filter 类型为 "Entity from dashboard state"，点击 "Add"； 
- 添加 data keys："address"、"contactPerson"、"email"、"phone"；
- 进入 "Appearance" 选项卡，开启 "Use markdown/HTML value function"；
- 从文档中复制 Markdown/HTML value 函数并粘贴到对应窗口：

```html
if (data.length) {
    const buildingAttributes = ['address', 'contactPerson', 'phone', 'email'];

    let information = {
        entityName: data[0].entityName ? data[0].entityName : 'Not found',
        buildingAttributesField: {}
    };

    for (let key of buildingAttributes) {
        information.buildingAttributesField[key] = data[0][key] ? data[0][key] : 'Not found';
    }

    const attributesNotFound = Object.values(information.buildingAttributesField).every(value => value === 'Not found');

    if (attributesNotFound) {
        return '<div class="no-data-card">' +
            `<h1 class="card-title">Information on ${information.entityName}</h1>` +
            '<div class="no-data-block">' +
                '<div class="no-data-content">' +
                    '<div><svg xmlns="http://www.w3.org/2000/svg" width="81" height="80" viewBox="0 0 81 80" fill="none"><path d="M14.8203 46.1166C16.6985 46.0291 18.2877 45.3003 19.588 43.9301C20.8883 42.56 21.5529 40.9274 21.5529 39.0325C21.5529 40.9274 22.1886 42.56 23.4889 43.9301C24.7892 45.3003 26.3784 46.0291 28.2566 46.1166C26.3784 46.204 24.7892 46.9328 23.4889 48.303C22.8602 48.9489 22.3653 49.7146 22.0329 50.5555C21.7005 51.3963 21.5374 52.2955 21.5529 53.2006C21.5529 51.3057 20.9172 49.6732 19.588 48.303C18.2877 46.9328 16.6985 46.204 14.8203 46.1166ZM21.5529 25.1267C25.1937 24.9518 28.2855 23.5234 30.8283 20.8413C33.371 18.1593 34.6424 14.9817 34.6424 11.2793C34.6424 14.9817 35.9138 18.1593 38.4566 20.8413C40.9994 23.5234 44.0912 24.9227 47.7609 25.1267C45.3626 25.2434 43.1665 25.9139 41.1439 27.1966C39.1501 28.4501 37.5608 30.141 36.3761 32.24C35.2203 34.3389 34.6424 36.5837 34.6424 39.0325C34.6424 35.3301 33.371 32.1234 30.8283 29.4413C28.2855 26.7301 25.1937 25.3017 21.5529 25.1267ZM31.1461 56.524C33.8912 56.4074 36.2317 55.3288 38.1387 53.3172C40.0458 51.3057 40.9994 48.9152 40.9994 46.1166C40.9994 48.9152 41.9529 51.3057 43.86 53.3172C45.7671 55.3288 48.0787 56.4074 50.8237 56.524C48.0787 56.6406 45.7671 57.7193 43.86 59.7308C41.9529 61.7423 40.9994 64.1328 40.9994 66.9315C40.9994 64.1328 40.0458 61.7423 38.1387 59.7308C36.316 57.7765 33.8041 56.6245 31.1461 56.524ZM50.8237 42.7057C53.5688 42.5891 55.8804 41.5105 57.7875 39.4989C59.6946 37.4874 60.6192 35.0969 60.6192 32.2691C60.6192 35.0678 61.5728 37.4583 63.4799 39.4698C65.3869 41.4813 67.7274 42.56 70.4725 42.6766C67.7274 42.7932 65.3869 43.8718 63.4799 45.8834C61.5728 47.8949 60.6192 50.2854 60.6192 53.084C60.6192 50.2854 59.6657 47.8949 57.7875 45.8834C55.8804 43.901 53.5688 42.8223 50.8237 42.7057Z" fill="#00695C" fill-opacity="0.4"/></svg></div>' +
                    '<p class="no-data-title">There is no information about the building</p>' +
                '</div>' +
            '</div>' +
        '</div>';
    } else {
        return '<div class="card">' +
            `<h1 class="card-title">Information on ${information.entityName}</h1>` +
            '<div class="attributes">' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>place</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.address}</p>` +
                        '<span class="attribute_label">Address</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>person</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.contactPerson}</p>` +
                        '<span class="attribute_label">Contact person</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>call</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.phone}</p>` +
                        '<span class="attribute_label">Phone</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>mail_outline</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.buildingAttributesField.email}</p>` +
                        '<span class="attribute_label">Email</span>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>';
    }
}
```
{:.copy-code.expandable-5}

- A little further down, find the "Markdown/HTML CSS" section. Add Markdown/HTML CSS by taking it from the documentation:

```css
.card, .no-data-card {
    padding: 0px;
    height: 100%;
}

.card-title {
    position: sticky;
    top: 0;
    z-index: 2;
    font-size: 16px;
    letter-spacing: 0.25px;
    padding: 16px;
}
.attribute_container {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 16px;
    border-bottom: 1px solid #0000000d;
}

.icon {
    z-index: 1;
}

.icon_wrapper {
    display: flex;
    position: relative;
    align-items: center;
    padding: 8px;
    border: 1px solid var(--tb-primary-100, #305680);
    border-radius: 4px;
}

.icon_wrapper:before {
    content: '';
    z-index: 0;
    position: absolute;
    opacity: 0.1;
    background-color: var(--tb-primary-200, #305680);
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
}

.attribute, .attribute_label {
    font-size: 14px;
    line-height: 20px;
}

.attribute_label {
    color: #00000061;
}

.no-data-card {
    display: flex;
    flex-direction: column;
}

.no-data-block {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 100%;
    max-width: 345px;
    padding: 0 15px;
    margin: 0 auto;
    text-align: center;
}

.no-data-content {
    transform: translateY(-30%);
}

.no-data-block p {
    font-weight: 500;
}

.no-data-title {
    color: rgba(0, 0, 0, 0.54);
}

.no-data-subtitle {
    font-size: 13px;
    color: rgba(0, 0, 0, 0.38);
}
```
{:.copy-code.expandable-5}

- Navigate to the "Widget card" tab, disable "Enable fullscreen" and "Enable data export" options, and then click "Add" to confirm adding the widget.

We have added information card about the building. Resize the widget to your liking.

{% include images-gallery.html imageCollection="adding-markdown-card-widget" %}

### Map widget

Next, we will add a map widget that will display only the selected building. In a previous lesson, we added a similar [widget that displays all our buildings on the map](/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-1/#openstreet-map-widget){:target="_blank"}. 
ThingsBoard allows copying widgets, so let’s add the map widget by copying and pasting.

- Return to the default state of your dashboard where the original map widget is located;
- Enter the dashboard editing mode;
- Copy the map widget: right-click on the map widget and select "Copy" from the context menu;
- Go to the building state;
- Paste the map widget: right-click on the dashboard area and select "Paste" to place the copied widget on the dashboard.

{% include images-gallery.html imageCollection="copy-paste-map-widget-1" %}

Now, we should change the data source to display only the selected building:

- Click the "pencil" icon on the map widget to open its settings;
- Change the data source to the "Selected entity" alias to focus the map on the selected building;
- Go to the "Appearance" tab, find the "Tooltip" section, and delete the code fragment as shown in the screenshot. Confirm all changes;
- Place the widget in the upper-right corner of the dashboard and adjust its size. Save the dashboard by clicking "Save".

{% include images-gallery.html imageCollection="copy-paste-map-widget-2" %}

In the "Building list" widget, click on the row of any building to transition to its state.

{% include images-gallery.html imageCollection="copy-paste-map-widget-3" %}

### Offices list widget

Next, we will add a widget to display the list of offices in the selected building. It will be a table that, in addition to listing the offices, displays the floor each office is located on and the contact person&#39;s phone number.

#### Adding the necessary attributes

Information about the floor and the contact phone number should be added as attributes for each office. 
Additionally, as attributes, we will add information such as the office manager&#39;s first and last name, and office email, which will be used later in another widget.

{% include images-gallery.html imageCollection="adding-office-attributes-1" showListImageTitles="true" %} 

- Similarly, add the "phone", "email", and "officeManager" attributes.

After adding these attributes for both offices, your attributes list for each office should look like this:

{% include images-gallery.html imageCollection="adding-office-attributes-2" %}

Use the values for the attributes from the table below:

| **Offices** | **Floor** | **Email**         | **Phone**       | **Office manager** |
|:------------|:----------|:------------------|:----------------|:-------------------|
| Office A    | 3         | office.a@mail.com | +1 121 333 4455 | Emma Johnson       |
| Office B    | 4         | office.b@mail.com | +1 121 666 5522 | Millie Brown       |
| ---         

#### Adding Offices list widget

Now let's add the widget itself, which will display the list of offices. In this widget, we will use the "[Asset search query](/docs/{{docsPrefix}}user-guide/ui/aliases/#asset-search-query){:target="_blank"}" alias type. 
This alias allows displaying assets of specified asset types (asset profiles) up to a specified level that are linked to the root entity. In our case, the root entity is the selected building.

{% include images-gallery.html imageCollection="offices-list-widget-1" showListImageTitles="true" %}

<br>
The configured "building" state should look like this:

{% include images-gallery.html imageCollection="offices-list-widget-2" %}

## Office's state

By transitioning to the state of the selected office, you will access the contact information of the person responsible for the office, see a list of all devices in the office and their main telemetry readings, as well as see the office plan and the placement of devices on it.

### Navigation between the building and office states

Let's set up the ability to transition to the "office" state by clicking on the row with its name in the "Offices list" widget. Use the "[Navigation to dashboard state](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#navigate-to-new-dashboard-state){:target="_blank"}" action here as well.

{% include images-gallery.html imageCollection="navigate-to-office-state-1" showListImageTitles="true" %}

<br>
Navigate to the "Office A" state by selecting the appropriate office in the "Offices list" widget:

{% include images-gallery.html imageCollection="navigate-to-office-state-2" showListImageTitles="true" %}

Add a background image for this state. You already know how to do it. Use [the image from this tutorial](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/office-room.png){:target="_blank"} or upload your own image.

{% include images-gallery.html imageCollection="background-image-office-state" %}

### Adding information card about office

Let's add a widget card that will display contact information about the selected office, such as the building address, contact person, phone number, and email address.

- Click the large "Add new widget" icon in the center of the screen;
- Select the "Markdown/HTML Card" from the "Cards" widgets bundle;
- Specify the "Selected entity" alias as the data source;
- Add the following data keys: "floor", "officeManager", "email", and "phone";
- We need to add another alias to extract the building address. Click "Add datasource". Input "Entity with relation to dashboard state (asset)" as alias name. Then, click "Create a new one!";
- Specify "Relation type" as filter type. Turn on "Use dashboard state entity as root" option. Set the direction to "To", and maximum relation level to "1". Add a relation filter: set "Contains" as relation type, and "Asset" as entity type. Then, click "Add";
- Add "Address" to the data keys row;
- Navigate to the "Appearance" tab. Turn on "Use markdown/HTML value function" option;
- Add the markdown/HTML value function to the appropriate window by taking it from the documentation:

```html
if (data.length > 1) {
    const officeAttributes = ['floor', 'officeManager', 'phone', 'email'];

    let information = {
        entityName: data[0].entityName ? data[0].entityName : 'Not found',
        address: data[1].address ? data[1].address : 'Not found',
        officeAttributesField: {}
    };

    for (let key of officeAttributes) {
        information.officeAttributesField[key] = data[0][key] ? data[0][key] : 'Not found';
    }

    const attributesNotFound = Object.values(information.officeAttributesField).every(value => value === 'Not found');

    if (attributesNotFound && information.address === 'Not found') {
        return '<div class="no-data-card">' +
            `<h1 class="card-title">Information on ${information.entityName}</h1>` +
                '<div class="no-data-block">' +
                    '<div class="no-data-content">' +
                        '<div><svg xmlns="http://www.w3.org/2000/svg" width="81" height="80" viewBox="0 0 81 80" fill="none"><path d="M14.8203 46.1166C16.6985 46.0291 18.2877 45.3003 19.588 43.9301C20.8883 42.56 21.5529 40.9274 21.5529 39.0325C21.5529 40.9274 22.1886 42.56 23.4889 43.9301C24.7892 45.3003 26.3784 46.0291 28.2566 46.1166C26.3784 46.204 24.7892 46.9328 23.4889 48.303C22.8602 48.9489 22.3653 49.7146 22.0329 50.5555C21.7005 51.3963 21.5374 52.2955 21.5529 53.2006C21.5529 51.3057 20.9172 49.6732 19.588 48.303C18.2877 46.9328 16.6985 46.204 14.8203 46.1166ZM21.5529 25.1267C25.1937 24.9518 28.2855 23.5234 30.8283 20.8413C33.371 18.1593 34.6424 14.9817 34.6424 11.2793C34.6424 14.9817 35.9138 18.1593 38.4566 20.8413C40.9994 23.5234 44.0912 24.9227 47.7609 25.1267C45.3626 25.2434 43.1665 25.9139 41.1439 27.1966C39.1501 28.4501 37.5608 30.141 36.3761 32.24C35.2203 34.3389 34.6424 36.5837 34.6424 39.0325C34.6424 35.3301 33.371 32.1234 30.8283 29.4413C28.2855 26.7301 25.1937 25.3017 21.5529 25.1267ZM31.1461 56.524C33.8912 56.4074 36.2317 55.3288 38.1387 53.3172C40.0458 51.3057 40.9994 48.9152 40.9994 46.1166C40.9994 48.9152 41.9529 51.3057 43.86 53.3172C45.7671 55.3288 48.0787 56.4074 50.8237 56.524C48.0787 56.6406 45.7671 57.7193 43.86 59.7308C41.9529 61.7423 40.9994 64.1328 40.9994 66.9315C40.9994 64.1328 40.0458 61.7423 38.1387 59.7308C36.316 57.7765 33.8041 56.6245 31.1461 56.524ZM50.8237 42.7057C53.5688 42.5891 55.8804 41.5105 57.7875 39.4989C59.6946 37.4874 60.6192 35.0969 60.6192 32.2691C60.6192 35.0678 61.5728 37.4583 63.4799 39.4698C65.3869 41.4813 67.7274 42.56 70.4725 42.6766C67.7274 42.7932 65.3869 43.8718 63.4799 45.8834C61.5728 47.8949 60.6192 50.2854 60.6192 53.084C60.6192 50.2854 59.6657 47.8949 57.7875 45.8834C55.8804 43.901 53.5688 42.8223 50.8237 42.7057Z" fill="#00695C" fill-opacity="0.4"/></svg></div>' +
                        '<p class="no-data-title">There is no information about the office and the office building address</p>' +
                    '</div>' +
                '</div>' +
            '</div>';
        } else {
        return '<div class="card">' +
            `<h1 class="card-title">Information on ${information.entityName}</h1>` +
            '<div class="attributes">' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>place</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.address}</p>` +
                        '<span class="attribute_label">Address</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>mdi:floor-plan</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.officeAttributesField.floor}</p>` +
                        '<span class="attribute_label">Floor</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>person</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.officeAttributesField.officeManager}</p>` +
                        '<span class="attribute_label">Office manager</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>call</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.officeAttributesField.phone}</p>` +
                        '<span class="attribute_label">Phone</span>' +
                    '</div>' +
                '</div>' +
                '<div class="attribute_container">' +
                    '<div class="icon_wrapper">' +
                        '<tb-icon class="icon" color="primary" matButtonIcon>mail_outline</tb-icon>' +
                    '</div>' +
                    '<div class="attribute_content">' +
                        `<p class="attribute">${information.officeAttributesField.email}</p>` +
                        '<span class="attribute_label">Email</span>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>';
    }
}
```
{:.copy-code.expandable-5}

- A little further down, find the "Markdown/HTML CSS" section. Add Markdown/HTML CSS according to the example below:

```css
.card, .no-data-card {
    padding: 0px;
    height: 100%;
}

.card-title {
    position: sticky;
    top: 0;
    z-index: 2;
    font-size: 16px;
    letter-spacing: 0.25px;
    padding: 16px;
}
.attribute_container {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 16px;
    border-bottom: 1px solid #0000000d;
}

.icon {
    z-index: 1;
}

.icon_wrapper {
    display: flex;
    position: relative;
    align-items: center;
    padding: 8px;
    border: 1px solid var(--tb-primary-100, #305680);
    border-radius: 4px;
}

.icon_wrapper:before {
    content: '';
    z-index: 0;
    position: absolute;
    opacity: 0.1;
    background-color: var(--tb-primary-200, #305680);
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
}

.attribute, .attribute_label {
    font-size: 14px;
    line-height: 20px;
}

.attribute_label {
    color: #00000061;
}

.no-data-card {
    display: flex;
    flex-direction: column;
}

.no-data-block {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 100%;
    max-width: 345px;
    padding: 0 15px;
    margin: 0 auto;
    text-align: center;
}

.no-data-content {
    transform: translateY(-30%);
}

.no-data-block p {
    font-weight: 500;
}

.no-data-title {
    color: rgba(0, 0, 0, 0.54);
}

.no-data-subtitle {
    font-size: 13px;
    color: rgba(0, 0, 0, 0.38);
}

```
{:.copy-code.expandable-4}

- Navigate to the "Widget card" tab, disable "Enable fullscreen" and "Enable data export" options;
- Click "Add" to confirm adding the widget;
- Resize the widget to your liking. Afterwards, save the dashboard.

We have added an information card about the office.

{% include images-gallery.html imageCollection="adding-office-markdown-card-widget" %}

### Image Map widget

Our next goal is to visually display the locations of our devices on the floor plan. For this, we will use the "Image Map" widget. 
But before we add this widget, we need to do some preparatory work by specifying the coordinates for each device and upload office plan image.

#### Adding device's coordinates

For each device, you need to specify its location coordinates on the building’s floor plan as attributes. These coordinates should be within a range from 0 to 1.

{% include images-gallery.html imageCollection="device-coordinates-1" showListImageTitles="true" %}

Similarly, add attributes with coordinates for the "Energy Meter", "Water Meter", and "IAQ Sensor" devices.

The final list of attributes for devices should look like this:

{% include images-gallery.html imageCollection="device-coordinates-2" %}

Coordinates of the devices used in this example:

| **Device**                         | **xPos** | **yPos** |
|:-----------------------------------|:---------|----------|
| SD-001 (Indoor Air Quality Sensor) | 0.51     | 0.68     |
| EM-002 (Energy Meter)              | 0.14     | 0.95     |
| WM-003 (Water Flow Meter)          | 0.14     | 0.32     |
| AM-307 (IAQ Sensor)                | 0.49     | 0.38     |
| ---                                

#### Upload office plan image

Now we need to upload the Office A plan and the Office B plan as graphic files to the [Image gallery](/docs/{{docsPrefix}}user-guide/image-gallery){:target="_blank"} and add links to them as server attributes for the "Office A" and "Office B" assets, respectively.

For Office A use [the provided Office A plan image](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/office-a-plan.png){:target="_blank"} or upload your own image.

- Go to the "Image gallery" page of the "Resources" section;
- Click "Upload image" button. This will open a new window for uploading the image. Here, you can either drag and drop your office plan image file or select it through a file explorer. Then, click "Upload";
- Once the upload is successful and your image appears in the gallery, look for the "Embed image" icon next to the image. Click this to get a unique link that directly references your uploaded image;
- Go to the "Assets" page of the "Entities" section, and click on "Office A". Navigate to the "Attributes" tab, and click the "plus" icon to add a new attribute;
- Name this attribute "office-plan", choose "String" as the value type, and paste the previously copied link into the value field. Confirm the addition by clicking "Add";

We have added a new attribute with a link to the image of the Office A plan.

{% include images-gallery.html imageCollection="add-office-plan-1" %}

Similarly, upload the Office B plan image to the Image gallery, and add a link to it for "Office B" asset as a server attribute. Use the [provided Office B plan image](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/office-b-plan.png){:target="_blank"} or upload your own image.

{% include images-gallery.html imageCollection="add-office-plan-2" %}

#### Adding Image Map widget

Now that we've completed the preparatory steps, it's time to add the Image Map widget itself. In this widget, we will use the "[Device search query](/docs/{{docsPrefix}}user-guide/ui/aliases/#device-search-query){:target="_blank"}" alias type. 
This alias allows displaying devices of specified device types (device profiles) up to a specified level that are linked to the root entity. In our case, the root entity is the selected office.

- Go to the "office" state and enter dashboard editing mode;
- Click the "Add widget" button at the top of the screen;
- Select the "Image Map" widget from the "Maps" widgets bundle;
- Now we need to add a new alias. In the "Alias" field, enter a name for it - "Office sensors", and click "Create a new one";
- Select the "Device search query" alias type, turn on the "Use dashboard state entity as root" option, set "Max relation level" to 1, choose "Contains" as the relation type, and list the following device types: "air-sensor", "energy-sensor", and "water-sensor". Finally, click "Add";
- Add "xPos", "yPos", and "type" as data keys;

{% include images-gallery.html imageCollection="adding-image-map-widget-1" %}

The "Appearance" tab:

- Set the [previously uploaded office plan image](#upload-office-plan-image) as the background of the widget:
  - Navigate to the "Appearance" tab, and scroll to the "Map provider settings" section;
  - Specify "Selected entity" as the image URL source entity alias. This setting ensures that the widget uses the image linked to the selected office;
  - Specify the "office-plan" as the image URL source entity attribute. This is the attribute where the link to the office plan image is stored;

Now, whenever you select a specific office, the widget will automatically fetch and display the associated office plan image from the "office-plan" attribute.

{% include images-gallery.html imageCollection="adding-image-map-widget-2" %}

- Scroll to the "Label" section. Here you can change the style of the label that is displayed above the marker.
Please copy the label content from the documentation and insert it into the label field of the widget.

The label text used in the example:

```text
<div style='position: relative; white-space: nowrap; text-align: center; font-size: 14px; top: 2px;'><span style='margin-left: -500%;'></span><div style='border: 2px solid #00695c; border-radius: 10px; color: #000; background-color: #fff;  padding-left: 12px; padding-right: 12px; padding-top: 4px; padding-bottom: 4px;'>${entityLabel}</div></div>
```
{: .copy-code}

{% include images-gallery.html imageCollection="adding-image-map-widget-label" %}

- In the "Tooltip" section, keep only ${entityName}, which is responsible for the device name. Delete everything else;

{% include images-gallery.html imageCollection="adding-image-map-widget-tooltip" %}

- Use the marker image function to display the marker image with the corresponding index, depending on the device type:
  - Copy marker image function from the documentation and paste it into the "Marker image function" field.
  - Remove default markers, and upload new markers for each device type. Image markers are used in these examples: [Indoor Air Quality Sensor](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/sensor-indoor-air-quality-default.svg){:target="_blank"}, [Energy Sensor](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/sensor-energy-default.svg){:target="_blank"}, and [Water Flow Meter](/images/user-guide/advanced-guides-for-working-with-dashboard/images-from-tutorial/sensor-water-default.svg){:target="_blank"}.

{% capture difference %}
**Please note:**
Each marker has its own index (images[0], images[1], etc.). The marker&#39;s index must correspond to the device type specified in the marker image function. You can manually reorder the marker images by dragging them.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

The marker image function used in the example:

```text
var type = dsData[dsIndex]['Type'];
if (type == 'air-sensor') {
	var res = {
	    url: images[0],
	    size: 50
	}
	return res;
} else if (type == 'energy-sensor') {
    var res = {
	    url: images[1],
	    size: 50
	}
	return res;
} else if (type == 'water-sensor') {
    var res = {
	    url: images[2],
	    size: 50
	}
	return res;
}
```
{:.copy-code.expandable-5}

{% include images-gallery.html imageCollection="adding-image-map-widget-marker-image" %}

The "Widget card" tab:

- Navigate to the "Widget card" tab and change the title to "Office plan";

{% include images-gallery.html imageCollection="adding-image-map-widget-title" %}

- Scroll to the "Advanced widget style" section. This area allows you to make deeper widget settings. 
Input the following CSS code to the "Widget CSS" section:

```css
.leaflet-tooltip-pane .leaflet-tooltip-top{
    opacity: 1 !important;
}
```
{:.copy-code}

This CSS will make the label background opaque.

{% include images-gallery.html imageCollection="adding-image-map-widget-css" %}

- Uncheck the "Enable data export" option in the "Card buttons" section, and click "Add" to complete adding the Image Map widget.

{% include images-gallery.html imageCollection="adding-image-map-uncheck-option" %}

Move the "Office plan" widget to the right corner and adjust its size as shown in the screenshot.

{% include images-gallery.html imageCollection="adding-image-final" %}

<br>
Finally, let's make the Image Map widget automatically fill the layout by height:

- Go to the "Layout" settings;
- Enable the "Auto fill layout height" option, and click "Save";
- Apply layouts settings and save the dashboard.

As you can see, the Image Map widget has filled the entire height of the dashboard.

{% include images-gallery.html imageCollection="automatic-height-layout-filling" %}

A widget has been added that displays the plan of the selected office and the placement of devices on it.

{% include images-gallery.html imageCollection="image-map-widget" %}

### Office sensors list widget

Add another one widget to "office" state that will display devices and their telemetry in a list.

{% include images-gallery.html imageCollection="adding-office-list-widget-1" showListImageTitles="true" %}

<br>
The configured "office" state should look like this:

{% include images-gallery.html imageCollection="adding-office-list-widget-2" %}

## Final view of the dashboard for this lesson

As a result your dashboard should look like this:

{% include images-gallery.html imageCollection="dashboard-final-lesson-2" %}

## Next step

In the third part of this guide, we will continue to develop our dashboard. We will add individual states and widgets for each device.
When you're ready to continue, just click the button below.

<br>
<p><a href="/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-3/" class="button">Lesson 3: Adding and configuring individual states for each device</a></p>