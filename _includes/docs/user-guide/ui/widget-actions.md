{% if docsPrefix == 'pe/' or docsPrefix contains 'paas/' %}
{% assign mobileDocsPrefix = "pe/" %}
{% assign mobilePrefix = "ThingsBoard PE Mobile Application" %}
{% else %}
{% assign mobileDocsPrefix = "" %}
{% assign mobilePrefix = "ThingsBoard Mobile Application" %}
{% endif %}

* TOC
{:toc}

Actions 功能可用于在 [dashboard 的 states](/docs/{{docsPrefix}}user-guide/dashboards/#states) 之间或不同 [dashboards](/docs/{{docsPrefix}}user-guide/dashboards/) 之间导航。
Actions 可快速配置跳转到已创建 state、切换到其它 dashboard 或更新当前 dashboard。
不同部件的 action 来源各异，但所有部件可选的动作类型相同。
可在编辑或创建部件时配置 Actions。

本指南以 Entities table 部件为例在编辑模式下配置 actions。请[在此了解](/docs/getting-started-guides/helloworld-pe/#step-32-add-an-entities-table-widget)如何将 Entity table 部件添加到 dashboard。

要完整理解 Actions 用法，需先在 dashboard 上添加 State。[添加方法见此处](/docs/{{docsPrefix}}user-guide/dashboards/#states)。

## Add action

添加第一个 action。本节仅概述通用步骤，不展开每项设置的细节。[action 类型](#action-types)和[action 来源](#action-sources)的使用示例将在后文说明。

多数部件提供 *basic* 和 *advanced* 两种配置。添加 action 的流程在这两种模式下略有不同。分别说明：

若使用 *basic* 部件配置：

- 进入要添加 action 的部件编辑模式，向下滚动找到“Actions”菜单项；
- 点击“Add action”按钮（创建一个或多个 action 后，该按钮会变为 `+` 图标）。
  “Actions”窗口将打开。当前为空，之后会显示所有已创建 actions；
- 点击屏幕右上角“plus”图标打开新“Add action”窗口。在此需输入名称、指定 action 来源、选择 action 类型以配置新 action。后续配置取决于所选 action 类型。然后点击“Add”继续；
- 在“Actions”窗口中可查看已配置 action，核对 action 来源、图标和类型。点击“Save”；
- 点击“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="add-new-action-1" %}

若使用 *advanced* 部件设置：

- 进入部件编辑模式，打开“Actions”选项卡。当前为空，之后所有已创建 actions 会显示在此；
- 点击屏幕右上角“plus”图标打开新“Add action”窗口。在此需输入名称、指定 action 来源、选择 action 类型以配置新 action。后续配置取决于所选 action 类型。然后点击“Add”继续；
- 可查看已配置 action，核对 action 来源、图标和类型。点击“Save”；
- 点击“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="add-new-action-2" %}

此时即可使用 action。可通过点击独立按钮、部件标题、实体单行等触发。

## Action types

action 类型定义将执行的具体操作。
适用于所有部件的七种 action 类型：
- **Navigate to new dashboard state** - 跳转到当前 dashboard 内的指定 state；
- **Update current dashboard state** - 更新当前所在 dashboard；
- **Navigate to other dashboard** - 跳转到指定 dashboard；
- **Custom action** - 允许为部件上的单个 action 手动配置函数；
- **Custom action (with HTML template)** - 允许在现有 HTML 模板中手动输入函数；
- **Mobile action** - 支持拍照、扫描 QR 码、获取设备位置、拨打电话等移动设备功能；
- **Open URL** - 跳转到 URL 所表示的任何资源。

[Map widgets](/docs/{{docsPrefix}}user-guide/widgets/map-widgets/){:target="_blank"} 另有专用 action 类型：
- **Place map item** — 可直接在地图部件上创建并放置新实体，仅需几次点击。

下面分别说明各类型。

### Navigate to new dashboard state

States 是用于在不同设备、资产和部件对象间导航以查看详细信息的层级。
选择 _Navigate to new dashboard state_ action 类型时，将跳转到此前创建的 state。

假设你已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states)并熟悉“[Add action](#add-action)”步骤。下面直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 本指南以“[Action cell button](#action-cell-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示按钮的图标，该图标将用于执行 action；
- 在“Action”下拉菜单中选择“Navigate to new dashboard state”类型；
- 选择类型后会出现“Target dashboard state”下拉菜单，选择要跳转的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states)；
- 选择 state 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中可查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="navigate-to-new-dashboard-state-1" %}

保存后，每个实体旁会显示 action 图标。点击任一图标即跳转到 action 指定的 state。

{% include images-gallery.html imageCollection="navigate-to-new-dashboard-state-2" %}

#### Open new dashboard state in a separate dialog or in a popup window

有时不需要跳转到单独的 dashboard state 查看部件详情，而只需在同一 dashboard 页面上打开。
为此提供 _Dashboard state display option_ 功能，可在同一页面上以独立对话框或弹出窗口打开另一 [state](/docs/{{docsPrefix}}user-guide/dashboards/#states)。

在 action 设置中选择 dashboard state 的显示方式，并可配置窗口选项（如显示/隐藏 dashboard 工具栏、弹出窗口宽高）。

例如，在独立对话框中显示新 dashboard state：

- 在“Dashboard state display option”字段中选择“Open in separate dialog”；
- 默认勾选“Hide dashboard toolbar in dialog”。若需在对话框中显示工具栏，则取消勾选。工具栏显示实体、时间窗口、dashboard 导出按钮和全屏展开按钮；
- 可按百分比调整对话框宽高（宽度相对于视口高度，高度相对于宽度）；
- 配置完成后保存所有更改。

要执行 action 并以新 state 打开对话框，点击任意实体旁的 action 按钮。

{% include images-gallery.html imageCollection="navigate-to-new-dashboard-state-3" %}

### Update current dashboard state

该 action 类型用于更新当前所在的 dashboard。
在使用 dashboard 时可实时查看特定设备/资产的详细信息。
此类型最常用于 Chart 部件，便于更精确查看详情。

本例中，除“Entities table”部件外，还需在 dashboard 中添加“Timeseries Line Chart”部件。数据源请指定 [asset 类型“Entity from dashboard state”](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state)：

{% include images-gallery.html imageCollection="update-current-dashboard-state-1" showListImageTitles="true" %}

下面为“Entities table”部件添加类型为“Update current dashboard state”的 action。
假设已熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 本指南以“[Action cell button](#action-cell-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示按钮的图标；
- 在“Action”下拉菜单中选择“Update current dashboard state”类型；
- 点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="update-current-dashboard-state-2" %}

保存后，“Entities table”部件中实体名称旁会显示图标。点击任一图标将更新实体详情，并显示在当前 dashboard 的“Timeseries Line Chart”部件上。

{% include images-gallery.html imageCollection="update-current-dashboard-state-3" %}

### Navigate to other dashboard

该 action 类型可跳转到之前创建的 dashboard。

假设已熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 本指南以“[Widget header button](#widget-header-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示按钮的图标；
- 在“Action”下拉菜单中选择“Navigate to other dashboard”类型；
- 选择后会出现“Target dashboard state”下拉菜单，选择要跳转的 dashboard。也可选择该 dashboard 的已有 state；
- 选择 dashboard 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

保存后，部件右上角会显示图标。点击该图标即跳转到所选 dashboard（或该 dashboard 中的所选 state）。

{% include images-gallery.html imageCollection="navigate-to-other-dashboard" %}

### Custom action

Custom action 允许手动配置函数，为部件添加单个 action（例如删除列出的设备/资产）。
下面以设备删除为例配置带函数的 custom action：

假设已熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 本指南以“[Action cell button](#action-cell-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示 action 按钮的图标；
- 在“Action”下拉菜单中选择“Custom action”类型；
- 选择 Custom action 后会出现函数输入框；
- 在其中输入自定义函数。本例为在表格中直接删除设备的 action（下方提供示例函数）；

<details>
<summary>
<b>设备删除函数示例（点击展开）：</b>
</summary>

{% highlight ruby %}
let $injector = widgetContext.$scope.$injector;
let dialogs = $injector.get(widgetContext.servicesMap.get('dialogs'));
let deviceService = $injector.get(widgetContext.servicesMap.get('deviceService'));

openDeleteDeviceDialog();

function openDeleteDeviceDialog() {
    let title = "Are you sure you want to delete the device " + entityName + "?";
    let content = "Be careful, after the confirmation, the device and all related data will become unrecoverable!";
    dialogs.confirm(title, content, 'Cancel', 'Delete').subscribe(
        function(result) {
            if (result) {
                deleteDevice();
            }
        }
    );
}

function deleteDevice() {
    deviceService.deleteDevice(entityId.id).subscribe(
        function() {
            widgetContext.updateAliases();
        }
    );
}
{% endhighlight %}

</details>

- 输入函数后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="custom-action-1" %}

保存后，“Entities Table”部件中实体名称旁会显示 action 按钮。
点击任一按钮将执行删除对应对象的操作。

{% include images-gallery.html imageCollection="custom-action-2" %}

### Custom action (with HTML template)

Custom action（带 HTML 模板）允许在现有 HTML 模板中手动输入函数（例如创建用于新增或编辑列出的设备/资产的对话框窗口）。
选择 Custom action 类型（with HTML template）后，会出现四个用于配置 action 的选项卡：

- "_Resources_" 选项卡用于指定部件使用的外部 JavaScript/CSS 资源；

- "_CSS_" 选项卡包含 custom action 专用的 CSS 样式定义；

- "_HTML_" 选项卡包含 custom action 的 HTML 代码；

- "_JavaScript_" 选项卡包含 custom action 的 JS 代码。

本例将添加两个 action 按钮。部件右上角为添加新实体的 action 按钮，第二个 action 负责实体名称旁的编辑按钮。

先添加新增实体的 action 按钮。假设已完成“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 本指南以“[Widget header button](#widget-header-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示 action 按钮的图标；
- 在“Action”下拉菜单中选择“Custom action (with HTML template)”类型；
- 在出现的选项卡中选择“_JavaScript_”选项卡，输入 custom action 的 JavaScript 函数。本例使用可创建新实体的函数（下方有示例）；

<details>

<summary>
<b>添加设备或资产的 JavaScript 函数示例（点击展开）：</b>
</summary>

{% highlight ruby %}
let $injector = widgetContext.$scope.$injector;
let customDialog = $injector.get(widgetContext.servicesMap.get('customDialog'));
let assetService = $injector.get(widgetContext.servicesMap.get('assetService'));
let deviceService = $injector.get(widgetContext.servicesMap.get('deviceService'));
let attributeService = $injector.get(widgetContext.servicesMap.get('attributeService'));
let entityRelationService = $injector.get(widgetContext.servicesMap.get('entityRelationService'));

openAddEntityDialog();

function openAddEntityDialog() {
customDialog.customDialog(htmlTemplate, AddEntityDialogController).subscribe();
}

function AddEntityDialogController(instance) {
let vm = instance;

    vm.allowedEntityTypes = ['ASSET', 'DEVICE'];
    vm.entitySearchDirection = {
        from: "FROM",
        to: "TO"
    }

    vm.addEntityFormGroup = vm.fb.group({
     entityName: ['', [vm.validators.required]],
     entityType: ['DEVICE'],
     entityLabel: [null],
     type: ['', [vm.validators.required]],
     attributes: vm.fb.group({
         latitude: [null],
         longitude: [null],
         address: [null],
         owner: [null],
         number: [null, [vm.validators.pattern(/^-?[0-9]+$/)]],
         booleanValue: [null]
     }),
     relations: vm.fb.array([])
    });

    vm.cancel = function() {
        vm.dialogRef.close(null);
    };

    vm.relations = function() {
        return vm.addEntityFormGroup.get('relations');
    };

    vm.addRelation = function() {
        vm.relations().push(vm.fb.group({
         relatedEntity: [null, [vm.validators.required]],
         relationType: [null, [vm.validators.required]],
         direction: [null, [vm.validators.required]]
        }));
    };

    vm.removeRelation = function(index) {
        vm.relations().removeAt(index);
        vm.relations().markAsDirty();
    };

    vm.save = function() {
        vm.addEntityFormGroup.markAsPristine();
        saveEntityObservable().subscribe(
            function (entity) {
                widgetContext.rxjs.forkJoin([
                    saveAttributes(entity.id),
                    saveRelations(entity.id)
                ]).subscribe(
                    function () {
                        widgetContext.updateAliases();
                        vm.dialogRef.close(null);
                    }
                );
            }
        );
    };

    function saveEntityObservable() {
        const formValues = vm.addEntityFormGroup.value;
        let entity = {
            name: formValues.entityName,
            type: formValues.type,
            label: formValues.entityLabel
        };
        if (formValues.entityType == 'ASSET') {
            return assetService.saveAsset(entity);
        } else if (formValues.entityType == 'DEVICE') {
            return deviceService.saveDevice(entity);
        }
    }

    function saveAttributes(entityId) {
        let attributes = vm.addEntityFormGroup.get('attributes').value;
        let attributesArray = [];
        for (let key in attributes) {
            if(attributes[key] !== null) {
                attributesArray.push({key: key, value: attributes[key]});
            }
        }
        if (attributesArray.length > 0) {
            return attributeService.saveEntityAttributes(entityId, "SERVER_SCOPE", attributesArray);
        }
        return widgetContext.rxjs.of([]);
    }

    function saveRelations(entityId) {
        let relations = vm.addEntityFormGroup.get('relations').value;
        let tasks = [];
        for(let i=0; i < relations.length; i++) {
            let relation = {
                type: relations[i].relationType,
                typeGroup: 'COMMON'
            };
            if (relations[i].direction == 'FROM') {
                relation.to = relations[i].relatedEntity;
                relation.from = entityId;
            } else {
                relation.to = entityId;
                relation.from = relations[i].relatedEntity;
            }
            tasks.push(entityRelationService.saveRelation(relation));
        }
        if (tasks.length > 0) {
            return widgetContext.rxjs.forkJoin(tasks);
        }
        return widgetContext.rxjs.of([]);
    }
}

{% endhighlight %}
</details>

- 在“_HTML_”选项卡中输入 custom action 的 HTML 代码（下方有示例）；

<details>

<summary>
<b>添加设备或资产的 HTML 代码示例（点击展开）：</b>
</summary>

{% highlight ruby %}
<form #addEntityForm="ngForm" [formGroup]="addEntityFormGroup"
      (ngSubmit)="save()" class="add-entity-form">
    <mat-toolbar fxLayout="row" color="primary">
        <h2>Add entity</h2>
        <span fxFlex></span>
        <button mat-icon-button (click)="cancel()" type="button">
            <mat-icon class="material-icons">close</mat-icon>
        </button>
    </mat-toolbar>
    <mat-progress-bar color="warn" mode="indeterminate" *ngIf="isLoading$ | async">
    </mat-progress-bar>
    <div style="height: 4px;" *ngIf="!(isLoading$ | async)"></div>
    <div mat-dialog-content fxLayout="column">
        <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
            <mat-form-field fxFlex class="mat-block">
                <mat-label>Entity Name</mat-label>
                <input matInput formControlName="entityName" required>
                <mat-error *ngIf="addEntityFormGroup.get('entityName').hasError('required')">
                    Entity name is required.
                </mat-error>
            </mat-form-field>
            <mat-form-field fxFlex class="mat-block">
                <mat-label>Entity Label</mat-label>
                <input matInput formControlName="entityLabel" >
            </mat-form-field>
        </div>
        <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
            <tb-entity-type-select
                    class="mat-block"
                    formControlName="entityType"
                    [showLabel]="true"
                    [allowedEntityTypes]="allowedEntityTypes"
            ></tb-entity-type-select>
            <tb-entity-subtype-autocomplete
                    fxFlex *ngIf="addEntityFormGroup.get('entityType').value == 'ASSET'"
                    class="mat-block"
                    formControlName="type"
                    [required]="true"
                    [entityType]="'ASSET'"
            ></tb-entity-subtype-autocomplete>
            <tb-entity-subtype-autocomplete
                    fxFlex *ngIf="addEntityFormGroup.get('entityType').value != 'ASSET'"
                    class="mat-block"
                    formControlName="type"
                    [required]="true"
                    [entityType]="'DEVICE'"
            ></tb-entity-subtype-autocomplete>
        </div>
        <div formGroupName="attributes" fxLayout="column">
            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Latitude</mat-label>
                    <input type="number" step="any" matInput formControlName="latitude">
                </mat-form-field>
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Longitude</mat-label>
                    <input type="number" step="any" matInput formControlName="longitude">
                </mat-form-field>
            </div>
            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Address</mat-label>
                    <input matInput formControlName="address">
                </mat-form-field>
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Owner</mat-label>
                    <input matInput formControlName="owner">
                </mat-form-field>
            </div>
            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Integer Value</mat-label>
                    <input type="number" step="1" matInput formControlName="number">
                    <mat-error *ngIf="addEntityFormGroup.get('attributes.number').hasError('pattern')">
                        Invalid integer value.
                    </mat-error>
                </mat-form-field>
                <div class="boolean-value-input" fxLayout="column" fxLayoutAlign="center start" fxFlex>
                    <label class="checkbox-label">Boolean Value</label>
                    <mat-checkbox formControlName="booleanValue" style="margin-bottom: 40px;">
                        {{ (addEntityFormGroup.get('attributes.booleanValue').value ? "value.true" : "value.false") | translate }}
                    </mat-checkbox>
                </div>
            </div>
        </div>
        <div class="relations-list">
            <div class="mat-body-1" style="padding-bottom: 10px; color: rgba(0,0,0,0.57);">Relations</div>
            <div class="body" [fxShow]="relations().length">
                <div class="row" fxLayout="row" fxLayoutAlign="start center" formArrayName="relations" *ngFor="let relation of relations().controls; let i = index;">
                    <div [formGroupName]="i" class="mat-elevation-z2" fxFlex fxLayout="row" style="padding: 5px 0 5px 5px;">
                        <div fxFlex fxLayout="column">
                            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                                <mat-form-field class="mat-block" style="min-width: 100px;">
                                    <mat-label>Direction</mat-label>
                                    <mat-select formControlName="direction" name="direction">
                                        <mat-option *ngFor="let direction of entitySearchDirection | keyvalue" [value]="direction.value">
                                            {{ ("relation.search-direction." + direction.value) | translate}}
                                        </mat-option>
                                    </mat-select>
                                    <mat-error *ngIf="relation.get('direction').hasError('required')">
                                        Relation direction is required.
                                    </mat-error>
                                </mat-form-field>
                                <tb-relation-type-autocomplete
                                        fxFlex class="mat-block"
                                        formControlName="relationType"
                                        [required]="true">
                                </tb-relation-type-autocomplete>
                            </div>
                            <div fxLayout="row" fxLayout.xs="column">
                                <tb-entity-select
                                        fxFlex class="mat-block"
                                        [required]="true"
                                        formControlName="relatedEntity">
                                </tb-entity-select>
                            </div>
                        </div>
                        <div fxLayout="column" fxLayoutAlign="center center">
                            <button mat-icon-button color="primary"
                                    aria-label="Remove"
                                    type="button"
                                    (click)="removeRelation(i)"
                                    matTooltip="Remove relation"
                                    matTooltipPosition="above">
                                <mat-icon>close</mat-icon>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <button mat-raised-button color="primary"
                        type="button"
                        (click)="addRelation()"
                        matTooltip="Add Relation"
                        matTooltipPosition="above">
                    Add
                </button>
            </div>
        </div>
    </div>
    <div mat-dialog-actions fxLayout="row" fxLayoutAlign="end center">
        <button mat-button color="primary"
                type="button"
                [disabled]="(isLoading$ | async)"
                (click)="cancel()" cdkFocusInitial>
            Cancel
        </button>
        <button mat-button mat-raised-button color="primary"
                type="submit"
                [disabled]="(isLoading$ | async) || addEntityForm.invalid || !addEntityForm.dirty">
            Create
        </button>
    </div>
</form>

{% endhighlight %}
</details>

- 输入函数后，点击“Add action”窗口底部的“Add”按钮。

{% include images-gallery.html imageCollection="custom-action-html-1" %}

下面添加用于编辑实体的 action 按钮。

- 再次点击屏幕右上角“plus”图标打开新“Add action”窗口；
- 本指南以“[Action cell button](#action-cell-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示 action 按钮的图标；
- 在“Action”下拉菜单中选择“Custom action (with HTML template)”类型；
- 在出现的选项卡中选择“JavaScript”选项卡，输入 custom action 的 JavaScript 函数。本例使用可编辑实体的函数（下方有示例）；

<details>
<summary>
<b>编辑设备或资产的 JavaScript 函数示例（点击展开）：</b>
</summary>

{% highlight ruby %}
let $injector = widgetContext.$scope.$injector;
let customDialog = $injector.get(widgetContext.servicesMap.get('customDialog'));
let entityService = $injector.get(widgetContext.servicesMap.get('entityService'));
let assetService = $injector.get(widgetContext.servicesMap.get('assetService'));
let deviceService = $injector.get(widgetContext.servicesMap.get('deviceService'));
let attributeService = $injector.get(widgetContext.servicesMap.get('attributeService'));
let entityRelationService = $injector.get(widgetContext.servicesMap.get('entityRelationService'));

openEditEntityDialog();

function openEditEntityDialog() {
customDialog.customDialog(htmlTemplate, EditEntityDialogController).subscribe();
}

function EditEntityDialogController(instance) {
let vm = instance;

    vm.entityName = entityName;
    vm.entityType = entityId.entityType;
    vm.entitySearchDirection = {
        from: "FROM",
        to: "TO"
    };
    vm.attributes = {};
    vm.oldRelationsData = [];
    vm.relationsToDelete = [];
    vm.entity = {};

    vm.editEntityFormGroup = vm.fb.group({
        entityName: ['', [vm.validators.required]],
        entityType: [null],
        entityLabel: [null],
        type: ['', [vm.validators.required]],
        attributes: vm.fb.group({
            latitude: [null],
            longitude: [null],
            address: [null],
            owner: [null],
            number: [null, [vm.validators.pattern(/^-?[0-9]+$/)]],
            booleanValue: [false]
        }),
        oldRelations: vm.fb.array([]),
        relations: vm.fb.array([])
    });

    getEntityInfo();

    vm.cancel = function() {
        vm.dialogRef.close(null);
    };

    vm.relations = function() {
        return vm.editEntityFormGroup.get('relations');
    };

    vm.oldRelations = function() {
        return vm.editEntityFormGroup.get('oldRelations');
    };

    vm.addRelation = function() {
        vm.relations().push(vm.fb.group({
            relatedEntity: [null, [vm.validators.required]],
            relationType: [null, [vm.validators.required]],
            direction: [null, [vm.validators.required]]
        }));
    };

    function addOldRelation() {
        vm.oldRelations().push(vm.fb.group({
            relatedEntity: [{value: null, disabled: true}, [vm.validators.required]],
            relationType: [{value: null, disabled: true}, [vm.validators.required]],
            direction: [{value: null, disabled: true}, [vm.validators.required]]
        }));
    }

    vm.removeRelation = function(index) {
        vm.relations().removeAt(index);
        vm.relations().markAsDirty();
    };

    vm.removeOldRelation = function(index) {
        vm.oldRelations().removeAt(index);
        vm.relationsToDelete.push(vm.oldRelationsData[index]);
        vm.oldRelations().markAsDirty();
    };

    vm.save = function() {
        vm.editEntityFormGroup.markAsPristine();
        widgetContext.rxjs.forkJoin([
            saveAttributes(entityId),
            saveRelations(entityId),
            saveEntity()
        ]).subscribe(
            function () {
                widgetContext.updateAliases();
                vm.dialogRef.close(null);
            }
        );
    };

    function getEntityAttributes(attributes) {
        for (var i = 0; i < attributes.length; i++) {
            vm.attributes[attributes[i].key] = attributes[i].value;
        }
    }

    function getEntityRelations(relations) {
        let relationsFrom = relations[0];
        let relationsTo = relations[1];
        for (let i=0; i < relationsFrom.length; i++) {
            let relation = {
                direction: 'FROM',
                relationType: relationsFrom[i].type,
                relatedEntity: relationsFrom[i].to
            };
            vm.oldRelationsData.push(relation);
            addOldRelation();
        }
        for (let i=0; i < relationsTo.length; i++) {
            let relation = {
                direction: 'TO',
                relationType: relationsTo[i].type,
                relatedEntity: relationsTo[i].from
            };
            vm.oldRelationsData.push(relation);
            addOldRelation();
        }
    }

    function getEntityInfo() {
        widgetContext.rxjs.forkJoin([
            entityRelationService.findInfoByFrom(entityId),
            entityRelationService.findInfoByTo(entityId),
            attributeService.getEntityAttributes(entityId, 'SERVER_SCOPE'),
            entityService.getEntity(entityId.entityType, entityId.id)
        ]).subscribe(
            function (data) {
                getEntityRelations(data.slice(0,2));
                getEntityAttributes(data[2]);
                vm.entity = data[3];
                vm.editEntityFormGroup.patchValue({
                    entityName: vm.entity.name,
                    entityType: vm.entityType,
                    entityLabel: vm.entity.label,
                    type: vm.entity.type,
                    attributes: vm.attributes,
                    oldRelations: vm.oldRelationsData
                }, {emitEvent: false});
            }
        );
    }

    function saveEntity() {
        const formValues = vm.editEntityFormGroup.value;
        if (vm.entity.label !== formValues.entityLabel){
            vm.entity.label = formValues.entityLabel;
            if (formValues.entityType == 'ASSET') {
                return assetService.saveAsset(vm.entity);
            } else if (formValues.entityType == 'DEVICE') {
                return deviceService.saveDevice(vm.entity);
            }
        }
        return widgetContext.rxjs.of([]);
    }

    function saveAttributes(entityId) {
        let attributes = vm.editEntityFormGroup.get('attributes').value;
        let attributesArray = [];
        for (let key in attributes) {
            if (attributes[key] !== vm.attributes[key]) {
                attributesArray.push({key: key, value: attributes[key]});
            }
        }
        if (attributesArray.length > 0) {
            return attributeService.saveEntityAttributes(entityId, "SERVER_SCOPE", attributesArray);
        }
        return widgetContext.rxjs.of([]);
    }

    function saveRelations(entityId) {
        let relations = vm.editEntityFormGroup.get('relations').value;
        let tasks = [];
        for(let i=0; i < relations.length; i++) {
            let relation = {
                type: relations[i].relationType,
                typeGroup: 'COMMON'
            };
            if (relations[i].direction == 'FROM') {
                relation.to = relations[i].relatedEntity;
                relation.from = entityId;
            } else {
                relation.to = entityId;
                relation.from = relations[i].relatedEntity;
            }
            tasks.push(entityRelationService.saveRelation(relation));
        }
        for (let i=0; i < vm.relationsToDelete.length; i++) {
            let relation = {
                type: vm.relationsToDelete[i].relationType
            };
            if (vm.relationsToDelete[i].direction == 'FROM') {
                relation.to = vm.relationsToDelete[i].relatedEntity;
                relation.from = entityId;
            } else {
                relation.to = entityId;
                relation.from = vm.relationsToDelete[i].relatedEntity;
            }
            tasks.push(entityRelationService.deleteRelation(relation.from, relation.type, relation.to));
        }
        if (tasks.length > 0) {
            return widgetContext.rxjs.forkJoin(tasks);
        }
        return widgetContext.rxjs.of([]);
    }
}
{% endhighlight %}
</details>

- 在“<b>HTML</b>”选项卡中输入 custom action 的 HTML 代码（下方有示例）；

<details>

<summary>
<b>编辑设备或资产的 HTML 代码示例（点击展开）：</b>
</summary>

{% highlight ruby %}
<form #editEntityForm="ngForm" [formGroup]="editEntityFormGroup"
      (ngSubmit)="save()"  class="edit-entity-form">
    <mat-toolbar fxLayout="row" color="primary">
        <h2>Edit {{entityType.toLowerCase()}} {{entityName}}</h2>
        <span fxFlex></span>
        <button mat-icon-button (click)="cancel()" type="button">
            <mat-icon class="material-icons">close</mat-icon>
        </button>
    </mat-toolbar>
    <mat-progress-bar color="warn" mode="indeterminate" *ngIf="isLoading$ | async">
    </mat-progress-bar>
    <div style="height: 4px;" *ngIf="!(isLoading$ | async)"></div>
    <div mat-dialog-content fxLayout="column">
        <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
            <mat-form-field fxFlex class="mat-block">
                <mat-label>Entity Name</mat-label>
                <input matInput formControlName="entityName" required readonly="">
            </mat-form-field>
            <mat-form-field fxFlex class="mat-block">
                <mat-label>Entity Label</mat-label>
                <input matInput formControlName="entityLabel">
            </mat-form-field>
        </div>
        <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
            <mat-form-field fxFlex class="mat-block">
                <mat-label>Entity Type</mat-label>
                <input matInput formControlName="entityType" readonly>
            </mat-form-field>
            <mat-form-field fxFlex class="mat-block">
                <mat-label>Type</mat-label>
                <input matInput formControlName="type" readonly>
            </mat-form-field>
        </div>
        <div formGroupName="attributes" fxLayout="column">
            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Latitude</mat-label>
                    <input type="number" step="any" matInput formControlName="latitude">
                </mat-form-field>
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Longitude</mat-label>
                    <input type="number" step="any" matInput formControlName="longitude">
                </mat-form-field>
            </div>
            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Address</mat-label>
                    <input matInput formControlName="address">
                </mat-form-field>
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Owner</mat-label>
                    <input matInput formControlName="owner">
                </mat-form-field>
            </div>
            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                <mat-form-field fxFlex class="mat-block">
                    <mat-label>Integer Value</mat-label>
                    <input type="number" step="1" matInput formControlName="number">
                    <mat-error *ngIf="editEntityFormGroup.get('attributes.number').hasError('pattern')">
                        Invalid integer value.
                    </mat-error>
                </mat-form-field>
                <div class="boolean-value-input" fxLayout="column" fxLayoutAlign="center start" fxFlex>
                    <label class="checkbox-label">Boolean Value</label>
                    <mat-checkbox formControlName="booleanValue" style="margin-bottom: 40px;">
                        {{ (editEntityFormGroup.get('attributes.booleanValue').value ? "value.true" : "value.false") | translate }}
                    </mat-checkbox>
                </div>
            </div>
        </div>
        <div class="relations-list old-relations">
            <div class="mat-body-1" style="padding-bottom: 10px; color: rgba(0,0,0,0.57);">Relations</div>
            <div class="body" [fxShow]="oldRelations().length">
                <div class="row" fxLayout="row" fxLayoutAlign="start center" formArrayName="oldRelations" 
                     *ngFor="let relation of oldRelations().controls; let i = index;">
                    <div [formGroupName]="i" class="mat-elevation-z2" fxFlex fxLayout="row" style="padding: 5px 0 5px 5px;">
                        <div fxFlex fxLayout="column">
                            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                                <mat-form-field class="mat-block" style="min-width: 100px;">
                                    <mat-label>Direction</mat-label>
                                    <mat-select formControlName="direction" name="direction">
                                        <mat-option *ngFor="let direction of entitySearchDirection | keyvalue" [value]="direction.value">
                                            {{ ("relation.search-direction." + direction.value) | translate}}
                                        </mat-option>
                                    </mat-select>
                                    <mat-error *ngIf="relation.get('direction').hasError('required')">
                                        Relation direction is required.
                                    </mat-error>
                                </mat-form-field>
                                <tb-relation-type-autocomplete
                                        fxFlex class="mat-block"
                                        formControlName="relationType"
                                        required="true">
                                </tb-relation-type-autocomplete>
                            </div>
                            <div fxLayout="row" fxLayout.xs="column">
                                <tb-entity-select
                                        fxFlex class="mat-block"
                                        required="true"
                                        formControlName="relatedEntity">
                                </tb-entity-select>
                            </div>
                        </div>
                        <div fxLayout="column" fxLayoutAlign="center center">
                            <button mat-icon-button color="primary"
                                    aria-label="Remove"
                                    type="button"
                                    (click)="removeOldRelation(i)"
                                    matTooltip="Remove relation"
                                    matTooltipPosition="above">
                                <mat-icon>close</mat-icon>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="relations-list">
            <div class="mat-body-1" style="padding-bottom: 10px; color: rgba(0,0,0,0.57);">New Relations</div>
            <div class="body" [fxShow]="relations().length">
                <div class="row" fxLayout="row" fxLayoutAlign="start center" formArrayName="relations" *ngFor="let relation of relations().controls; let i = index;">
                    <div [formGroupName]="i" class="mat-elevation-z2" fxFlex fxLayout="row" style="padding: 5px 0 5px 5px;">
                        <div fxFlex fxLayout="column">
                            <div fxLayout="row" fxLayoutGap="8px" fxLayout.xs="column"  fxLayoutGap.xs="0">
                                <mat-form-field class="mat-block" style="min-width: 100px;">
                                    <mat-label>Direction</mat-label>
                                    <mat-select formControlName="direction" name="direction">
                                        <mat-option *ngFor="let direction of entitySearchDirection | keyvalue" [value]="direction.value">
                                            {{ ("relation.search-direction." + direction.value) | translate}}
                                        </mat-option>
                                    </mat-select>
                                    <mat-error *ngIf="relation.get('direction').hasError('required')">
                                        Relation direction is required.
                                    </mat-error>
                                </mat-form-field>
                                <tb-relation-type-autocomplete
                                        fxFlex class="mat-block"
                                        formControlName="relationType"
                                        [required]="true">
                                </tb-relation-type-autocomplete>
                            </div>
                            <div fxLayout="row" fxLayout.xs="column">
                                <tb-entity-select
                                        fxFlex class="mat-block"
                                        [required]="true"
                                        formControlName="relatedEntity">
                                </tb-entity-select>
                            </div>
                        </div>
                        <div fxLayout="column" fxLayoutAlign="center center">
                            <button mat-icon-button color="primary"
                                    aria-label="Remove"
                                    type="button"
                                    (click)="removeRelation(i)"
                                    matTooltip="Remove relation"
                                    matTooltipPosition="above">
                                <mat-icon>close</mat-icon>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <button mat-raised-button color="primary"
                        type="button"
                        (click)="addRelation()"
                        matTooltip="Add Relation"
                        matTooltipPosition="above">
                    Add
                </button>
            </div>
        </div>
    </div>
    <div mat-dialog-actions fxLayout="row" fxLayoutAlign="end center">
        <button mat-button color="primary"
                type="button"
                [disabled]="(isLoading$ | async)"
                (click)="cancel()" cdkFocusInitial>
            Cancel
        </button>
        <button mat-button mat-raised-button color="primary"
                type="submit"
                [disabled]="(isLoading$ | async) || editEntityForm.invalid || !editEntityForm.dirty">
            Save
        </button>
    </div>
</form>

{% endhighlight %}
</details>

- 输入函数后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中可查看已配置 actions，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="custom-action-html-2" %}

点击部件顶部的“Add device”action 按钮添加新设备。
在打开的“Add entity”窗口中，选择新实体类型“Device”并输入名称。输入必要数据后点击“Create”。

{% include images-gallery.html imageCollection="custom-action-html-3" %}

点击要编辑设备名称旁的 action 按钮。点击后即打开设备编辑窗口。完成修改后点击“Save”。

{% include images-gallery.html imageCollection="custom-action-html-4" %}

### Mobile action

Mobile action 在移动应用配置中说明。详见 [Mobile actions](/docs/{{mobileDocsPrefix}}mobile/mobile-actions/)。

### Open URL

该 action 类型将跳转到 URL 所表示的资源。资源可以是 HTML 页面、文档、图片、ThingsBoard 内部页面（如 Alarms）等。

假设已熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 本指南以“[Widget header button](#widget-header-button)”为例，选择该 action 来源；
- 输入 action 名称并选择表示按钮的图标；
- 在“Action”下拉菜单中选择“Open URL”类型；
- 选择后会出现“URL”菜单。填入点击 action 按钮时要跳转的页面 URL；
- 可选：启用在新浏览器标签页中打开 URL 页面；
- 点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="open-url-1" %}

保存后，部件右上角会显示图标。点击该图标即跳转到 action 中指定的 URL。本例为“Working with ThingsBoard widgets”文档页面。

{% include images-gallery.html imageCollection="open-url-2" %}

#### Place map item

**Place map item** action 类型允许用户创建新实体并立即在地图部件上放置。

<br>
例如，添加一个供用户在地图上放置充电站的按钮：

首先，为确保新建实体立即显示在地图上，需配置数据源。

- 在“**Overlays**”部分的“**Marker**”选项卡下，新建实体别名作为数据源，命名为“**EV stations**”。
- 因将创建类型为“**EV station**”的实体，将 filter 类型设为“**Asset type**”，类型指定为“**EV station**”。
- 应用更改。

{% include images-gallery.html imageCollection="data-source-for-action" %}

下面配置 action：

- 向下滚动到“**Actions**”部分，点击“**Add action**”按钮。
- 新窗口将打开并显示所有已创建 actions。点击右上角“plus”图标添加一个。
- 选择 action 来源为“**Widget header button**”，输入按钮名称并选择类型。
- 可选：更换按钮旁图标或完全隐藏，也可为按钮设置自定义颜色。
- 在下拉菜单中选择要执行的 action 类型。本例为“**Place map item**”。
- 选择要放置的 **map item 类型** — 本例为“**Marker**”。
- **custom action function** 字段已包含用于打开创建设备或资产对话框的默认函数，可直接使用。
- 在“**Action**”部分从下拉菜单选择“**Place map item**”。选择要放置的 map item 类型 — 本例为“**Marker**”。Custom action function 字段包含打开创建设备或资产对话框的默认函数。
- 点击“**Add**”。
- 应用所有更改并保存 dashboard。

{% include images-gallery.html imageCollection="action" %}

地图顶部会出现标签为“**Add EV station**”的新 action 按钮。使用该按钮即可。

{% include images-gallery.html imageCollection="action-place-marker" showListImageTitles="true" %}

前往“**Assets**”页面 — 可找到新建资产“**EV station 1**”。

{% include images-gallery.html imageCollection="action-created-asset" %}

## Action sources

Action sources 是达成目标所需执行的具体操作（如点击部件标题按钮、双击行或地图 marker）。不同部件提供的 action 来源不同。
下面以最常用的“[Navigate to new dashboard state](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#navigate-to-new-dashboard-state)”为例，分别说明各类部件的 action 来源。

下面以“Entities table”部件为例演示各 action 来源的用法。
若不清楚如何添加 Entity table 部件，可[在此了解](/docs/getting-started-guides/helloworld-pe/#step-32-add-an-entities-table-widget)。

### Action cell button

“Action cell button”为部件中每个实体添加 action 按钮，如删除设备/资产或编辑。
该 action 按钮常用于“Entity table”部件。下面以该部件为例说明“Action cell button”用法。
点击所选实体的 action 图标将跳转到显示该实体详细信息的另一 state。

假设已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}并熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 选择“Action cell button”作为 action 来源；
- 输入 action 名称并选择表示按钮的图标；
- 在“Action”下拉菜单中选择“Navigate to new dashboard state”类型；
- 选择后会出现“Target dashboard state”下拉菜单，选择要跳转的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states)；
- 选择 state 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="action-cell-button-1" %}

可见每个实体名称旁都有 action cell 按钮。点击该按钮将执行对应 action，即跳转到所选 state。

{% include images-gallery.html imageCollection="action-cell-button-2" %}

### On cell click 

<i>* 仅适用于 Entities table、Alarms table、Device admin table 和 Asset admin table 部件。</i>

“On cell click”为指定表格列中每个单元格添加点击功能。

以“Entities table”部件为例，该部件显示设备列表及其最新温度和湿度读数。
将配置为：点击某列单元格时打开包含所选设备详细 telemetry 信息的弹出窗口。

为此需为表格每列添加 action。

假设已在 dashboard 上添加两个新 [states](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}并熟悉“[Add action](#add-action)”步骤，直接进行 action 配置。

先为“temperature”列添加 action：

- 选择“On cell click”作为 action 来源；
- 在“Column index”下拉菜单中选择“temperature”列；
- 输入 action 名称，可选选择图标；
- action 类型选择“Navigate to new dashboard state”；
- 指定“Target dashboard state”，用于显示所选设备的详细温度数据；
- 在“Dashboard state display options”字段选择“Open in popover”；
- 指定 popover 位置；
- 可选：指定 popover 宽高；
- 点击“Add”添加 action。

“temperature”列的 action 已配置完成。

{% include images-gallery.html imageCollection="on-cell-click-1" %}

接下来为“humidity”列添加 action：

- 点击“Actions”窗口右上角“plus”图标添加新 action；
- 重复上述步骤，此次在“Column index”下拉菜单中选择“humidity”列；
- 指定“Target dashboard state”，用于显示所选设备的详细湿度数据；
- 在“Dashboard state display options”字段选择“Open in popover”；
- 指定 popover 位置；
- 可选：指定 popover 宽高；
- 点击“Add”添加 action；
- 配置完成后，点击“Save”再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存整体 dashboard 配置。

{% include images-gallery.html imageCollection="on-cell-click-2" %}

此后，点击任意设备“temperature”列单元格时，将执行 action：弹出窗口显示所选设备的详细温度信息。

{% include images-gallery.html imageCollection="on-cell-click-3" %}

同样，点击“humidity”列单元格将弹出该设备详细湿度信息。

{% include images-gallery.html imageCollection="on-cell-click-4" %}

### Widget header button

“Widget header button”在部件标题栏添加 action 按钮。点击该按钮执行 action。该按钮作用于整个部件，而非单个实体。
Widget header button 是最常用的 action 来源，所有部件均支持。配置 _Widget header button_ action 来源步骤如下：

假设已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}并熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 选择“Widget header button”作为 action 来源；
- 输入 action 名称并选择表示按钮的图标；
- 在“Action”下拉菜单中选择“Navigate to new dashboard state”类型；
- 选择后会出现“Target dashboard state”下拉菜单，选择要跳转的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states)；
- 选择 state 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="widget-header-button-1" %}

此时部件标题栏会出现 action 按钮。点击后即执行 action，即跳转到所选 state。

{% include images-gallery.html imageCollection="widget-header-button-2" %}

### On row click

“On row click”在点击部件中某行时触发 action。常用于“Entity table”部件。以该部件为例说明：点击所选实体行将跳转到显示该实体详细信息的 state。

假设已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}并熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 选择“On row click”作为 action 来源；
- 输入 action 名称，可选选择图标；
- 在“Action”下拉菜单中选择“Navigate to new dashboard state”类型；
- 选择后会出现“Target dashboard state”下拉菜单，选择要跳转的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states)；
- 选择 state 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="on-row-click-1" %}

点击任意实体行即可执行 action，即跳转到所选 state 并显示所选设备详细信息。

{% include images-gallery.html imageCollection="on-row-click-2" %}

### On row double click

“On row double click”在双击部件中某行时触发 action。常用于“Entities table”部件。
双击所选实体行将跳转到显示该实体详细信息的 state。

假设已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}并熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入部件编辑模式，打开“Add action”窗口；
- 选择“On row double click”作为 action 来源；
- 输入 action 名称，可选选择图标；
- 在“Action”下拉菜单中选择“Navigate to new dashboard state”类型；
- 选择后会出现“Target dashboard state”下拉菜单，选择要跳转的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states)；
- 选择 state 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="on-row-double-click-1" %}

双击实体行即可执行 action，即跳转到所选 state。本例中，点击节点将跳转到显示所选节点详情的 state。

{% include images-gallery.html imageCollection="on-row-double-click-2" %}

### On node selected

<i>* 仅适用于 Entities Hierarchy 部件。</i>

本例将在 dashboard 上添加“Entity hierarchy”部件。Entities Hierarchy 部件按实体关系显示实体层级。
有关实体和 relations 的更多信息见[此处](/docs/{{docsPrefix}}user-guide/entities-and-relations/#step-1-provision-entities-and-relations){:target="_blank"}。点击 Entities hierarchy 中任意实体（节点）将执行已配置的 action。

假设已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}。开始配置 action：

{% include images-gallery.html imageCollection="on-node-selected-1" showListImageTitles="true" %}

点击 Entities hierarchy 中任意节点即可执行 action。本例中，点击节点将跳转到显示所选节点详情的 state。

{% include images-gallery.html imageCollection="on-node-selected-2" %}

### On HTML element click

<table style="width:auto"><thead><tr><td style="text-align: center"><strong><em>仅适用于 HTML 部件</em></strong></td></tr></thead></table> 

**On HTML element click** 允许在用户点击部件 HTML 布局中的元素时触发 action（跳转 state、打开链接、执行 custom action 等）。   

<br><b><font size="3">工作原理</font></b>

配置 **On HTML element click** 时，`id` 属性是部件 **HTML 代码**与部件 **Actions** 选项卡中定义的 **action** 之间的关联。

可将 `id` 赋给任意 HTML 元素（如 `<div>`、`<span>`、`<p>`、`<h1>`、`<button>`）。通常 `id` 用于容器元素（如 `<p>` 或 `<div>`），使整个块可点击。   

```html
<p id="details" class="blue-box">
    Current temperature: <span>22.5 °C</span>
</p>
```

<b><font size="3">提示</font></b>
- **仅适用于 HTML 部件**；表格、图表等请使用其专用 action 来源（[On row click](#on-row-click)、[On cell click](#on-cell-click)、[On node selected](#on-node-selected) 等）。
- `ID` 必须与 **Name** 完全一致（区分大小写）。
- 更复杂场景（对话框、表单）请使用支持它的部件中的 [Custom action with HTML template](#custom-action-with-html-template){:target="_blank"} / *widgetContext.dialogs* / *widgetContext.customDialog*。

<b><font size="3">逐步配置</font></b>
1. 进入 **部件编辑模式** → 打开 **Actions** 选项卡 → 点击 **+**（**Add action**）。
2. 在 Action source 中选择 **On HTML element click**。
3. 设置 **Name**（同时作为 HTML 元素的 **ID**）。
4. 在 **Action** 中选择 action 类型（如 [Navigate to new dashboard state](#navigate-to-new-dashboard-state){:target="_blank"}）并指定目标 state。
5. 保存 action（**Add**）。
6. 进入 **Appearance** 选项卡 → **HTML** 部分，添加 `id` **与 action 的 Name 完全一致**的元素。
7. 应用更改（**Apply**）并**保存 dashboard**。

保存后，ThingsBoard 会监听该部件中 id 与已创建 action 的 Name 匹配的元素的点击。若匹配，则执行所选 action 类型（跳转、更新 state、custom action 等）。

<br><b><font size="3">示例：Markdown/HTML Card 部件 — 点击蓝色区域</font></b>

**准备：**
1. 使用下方提供的 HTML 和 CSS 将 [Markdown/HTML Card](/docs/{{docsPrefix}}user-guide/widgets/cards/markdown-html-card/){:target="_blank"} 部件添加到 dashboard。
2. [创建新 dashboard state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}，包含设备**温度详情**。

**可选：** 可[下载预配置 dashboard](/docs/pe/user-guide/widgets/resources/smart_device_details.json){:target="_blank" download="smart_device_details.json"}（已含 Markdown/HTML Card 部件和 details state），然后[导入](/docs/{{docsPrefix}}user-guide/dashboards/#import-dashboard){:target="_blank"}到 ThingsBoard 实例。

{% capture difference %}
**重要：** 导入后，更新部件 datasource 中的 **target entity** 和 **data key**。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<b><font size="3">添加 Markdown/HTML Card</font></b>

**Markdown/HTML pattern:**

```html
const entity = data[0];
const color = entity.temperature > 25 ? "red" : entity.temperature > 20 ? 'green' : 'blue'
const entityName = `### Temperature value card\n - Current entity: <span >${entity.entityName}</span>\n `
const temp = `- Current temperature: <span style="color:${color};">${entity.temperature.toFixed(1)} °C</span>\n `
return entityName + temp;
```
{:.copy-code}

**Markdown/HTML CSS:**

```css
.office-card {
  box-sizing: border-box;
  padding: 16px;
  margin: 6px 0;
  text-align: center;
  font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, "Noto Sans";
}

.office-card h3 {
  margin: 0 0 12px;
  font-size: 24px;
}

.blue-box {
  background: #2196F31A;
  border: 2px solid #2196F3;
  border-radius: 10px;
  padding: 10px;
  margin: 8px 0;
  font-weight: 700;
}

.green-box {
  background: #4CAF501A;
  border: 2px solid #4CAF50;
  border-radius: 10px;
  padding: 10px;
  margin: 6px 0;
  font-weight: 700;
}

.temp-value,
.hum-value {
  font-weight: 700;
  font-variant-numeric: tabular-nums;
}
```
{:.copy-code.expandable-10}

<b><font size="3">添加 action</font></b>

1. 进入 **部件编辑模式** → 打开 **Actions** 选项卡 → 点击 **+**（**Add action**）。
2. 选择 **Action source**：**On HTML element click**。
3. 将 **action name** 设为 **details**。
4. 在 **Action** 中选择 **Navigate to new dashboard state**。
5. 在 **Target dashboard state** 中选择[此前创建](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}的 state。
6. 点击 **Add** 保存 action。

{% include images-gallery.html imageCollection="on-html-element-click-1" %}

<b><font size="3">在 HTML 中添加 id</font></b>

1. 进入 **Appearance** 选项卡 → **HTML** 部分。
2. 将 `id=details` 添加到 `<p class="blue-box">` 行。
   替换为：

    ```text
    <p id="details" class="blue-box">
    ```
    {: .copy-code}

    使整个蓝色块可点击，并与 **details** action 关联。

3. 应用更改（**Apply**）并**保存 dashboard**。

{% include images-gallery.html imageCollection="on-html-element-click-2" %}

<b><font size="3">结果</font></b>

点击**包含当前温度的蓝色块**将执行已配置的 action 并跳转到目标 state。

{% include images-gallery.html imageCollection="on-html-element-click-3" %}

### Map widget action sources

Map 部件有独立的 action 来源，需单独说明。

先添加地图部件（如 OpenStreetMap 部件）。另有[创建和配置地图部件的指南](/docs/{{docsPrefix}}user-guide/ui/trip-animation-widget/){:target="_blank"}，请先阅读。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/actions/guide/map-widget-action-sources-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/widgets/actions/guide/map-widget-action-sources-1-pe.png)
{% endif %}

下面添加 action。
后续关于 action 的说明均假定你已在 dashboard 上添加[新 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}并熟悉“[Add action](#add-action)”步骤，直接进行 action 配置。

#### On circle click

Circle 是平面上所有边界点到固定中心距离相等的图形。我们使用的 circle 基于设备中指定的坐标。
如何在地图部件上添加 circle 见[此处](/docs/{{docsPrefix}}user-guide/ui/trip-animation-widget/#circle-settings){:target="_blank"}。

{% include images-gallery.html imageCollection="on-circle-click-1" %}

- 进入部件编辑模式，打开“Add action”窗口；
- 选择“On circle click”作为 action 来源；
- 输入 action 名称，可选选择图标；
- 在“Action”下拉菜单中选择“Navigate to new dashboard state”类型；
- 选择后会出现“Target dashboard state”下拉菜单，选择要跳转的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}；
- 选择 state 后，点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="on-circle-click-2" %}

点击地图上的 circle 将执行 action，即跳转到指定 state。

{% include images-gallery.html imageCollection="on-circle-click-3" %}

#### On marker click

点击地图上的红色实体 marker 将执行 action。

- 进入部件编辑模式并打开「Add action」窗口；
- 选择「On marker click」作为 action 来源；
- 输入 action 名称，可选选择图标；
- 在「Action」下拉菜单中选择「Navigate to new dashboard state」action 类型；
- 选择 action 类型后，「Target dashboard state」下拉菜单会出现，选择要跳转到的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}；
- 选择所需 state 后，点击「Add action」窗口底部的「Add」按钮；
- 在「Actions」窗口中可看到已配置的 action，可核对 action 来源、图标和类型。点击「Save」，然后点击「Apply」保存部件设置。
- 点击 dashboard 右上角「Save」保存 dashboard。

{% include images-gallery.html imageCollection="on-marker-click-1" %}

点击地图上的 marker 将跳转到指定 state。

{% include images-gallery.html imageCollection="on-marker-click-2" %}

#### On polygon click

Polygon 是由有限个点描述的平面图形。原句： that’s described by a finite number of dots. 我们使用的 polygon 基于设备中指定的坐标，也可使用其它实体。
可使用 polygon 选项标注资产和其它实体。
如何在地图部件上添加 polygon 见[此处](/docs/{{docsPrefix}}user-guide/ui/trip-animation-widget/#polygon-settings){:target="_blank"}。

{% include images-gallery.html imageCollection="on-polygon-click-1" %}

- 进入部件编辑模式并打开「Add action」窗口；
- 选择「On polygon click」作为 action 来源；
- 输入 action 名称，可选选择图标；
- 在「Action」下拉菜单中选择「Navigate to new dashboard state」action 类型；
- 选择 action 类型后，「Target dashboard state」下拉菜单会出现，选择要跳转到的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}；
- 选择所需 state 后，点击「Add action」窗口底部的「Add」按钮；
- 在「Actions」窗口中可看到已配置的 action，可核对 action 来源、图标和类型。点击「Save」，然后点击「Apply」保存部件设置。
- 点击 dashboard 右上角「Save」保存 dashboard。

{% include images-gallery.html imageCollection="on-polygon-click-2" %}

在 polygon 内任意位置点击即可执行 action。

{% include images-gallery.html imageCollection="on-polygon-click-3" %}

#### Tooltip tag action

可配置地图部件，使点击 marker 时显示 tooltip。Tooltip 可包含用于执行已配置 action 的链接。
本指南仅说明 tooltip tag action 来源的基本用法。可为不同设备/资产配置返回不同值的多个链接。
使用地图部件高级模式下的 [tooltip 函数](/docs/{{docsPrefix}}user-guide/ui/trip-animation-widget/#tooltip-function){:target="_blank"} 实现。

- 进入部件编辑模式并打开「Add action」窗口；
- 选择「Tooltip tag action」作为 action 来源；
- 输入 action 名称，可选选择图标；
- 在「Action」下拉菜单中选择「Navigate to new dashboard state」action 类型；
- 选择 action 类型后，「Target dashboard state」下拉菜单会出现，选择要跳转到的[已创建 state](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}；
- 选择所需 state 后，点击「Add action」窗口底部的「Add」按钮；
- 在「Actions」窗口中可看到已配置的 action，可核对 action 来源、图标和类型。
- 进入部件的「Appearance」选项卡；
- 向下滚动到 Tooltip 配置，勾选「Show tooltip」复选框；
- 在 Tooltip 行中找到 link-act name，输入 action 的 ID（即其名称），格式如下：

```
<link-act name='TooltipTag'>Navigate to the ${entityName}</link-act>
```
{: .copy-code}

其中 _TooltipTag_ 为 action 名称，_Navigate to the Building A_ 为 tooltip 中显示为链接的文本。

- 点击“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="tooltip-tag-action-1" %}

点击地图上的 marker 显示 tooltip。要执行 action，点击 tooltip 底部的链接文本。

{% include images-gallery.html imageCollection="tooltip-tag-action-2" %}

## Special actions settings

### Open right dashboard layout (mobile view)

{% capture difference %}
若使用 [{{mobilePrefix}}](/docs/{{mobileDocsPrefix}}mobile/)，这些设置会很有用。若尚未使用，[不妨试试](/docs/{{mobileDocsPrefix}}mobile/getting-started/)！随时随地掌握 IoT 方案中的各类事件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

用户常需要在相邻部件上查看某实体的更新信息。例如，“Entity table”部件中有资产列表，希望在旁边的“Time series chart”部件中查看其详情。
在桌面上，可将两个部件并排放置并选择 action 类型“[Update current dashboard state](#update-current-dashboard-state)”轻松实现。
但在 [{{mobilePrefix}}](/docs/{{mobileDocsPrefix}}mobile/) 的响应式屏幕上，部件会自动纵向排列。这意味着需要向下滚动才能看到第二个部件上的相关信息。

{% include images-gallery.html imageCollection="mob" %}

[Layouts](/docs/{{docsPrefix}}user-guide/dashboards/#layouts) 功能可解决此问题。配置 layouts 步骤如下：

{% include images-gallery.html imageCollection="mob-layout-1" showListImageTitles="true" %}

下面将“Time series chart”部件添加到右侧 layout：

{% include images-gallery.html imageCollection="mob-layout-2" showListImageTitles="true" %}

为“Entities table”部件的每个实体添加类型为“Update current dashboard state”的 action 按钮。
假设已熟悉“[Add action](#add-action)”步骤，直接进行 action 配置：

- 进入“Time series chart”部件的编辑模式，打开“Add action”窗口；
- 本指南以“[On row click](#on-row-click)”为例，选择该 action 来源；
- 输入 action 名称并选择表示按钮的图标；
- 在“Action”下拉菜单中选择“Update current dashboard state”类型；
- 开启“Open right dashboard layout (mobile view)”选项；
- 点击“Add action”窗口底部的“Add”按钮；
- 在“Actions”窗口中查看已配置 action，核对来源、图标和类型。点击“Save”，再点“Apply”保存部件设置；
- 点击 dashboard 页面右上角“Save”保存 dashboard。

{% include images-gallery.html imageCollection="mob-layout-3" %}

点击“Entity Table”部件中任意实体行即可执行 action，即更新所选实体的详情。该实体数据将显示在当前 dashboard 的“Time series chart”部件上。

{% include images-gallery.html imageCollection="mob-layout-4" %}

在 [{{mobilePrefix}}](/docs/{{mobileDocsPrefix}}mobile/) 中打开该 dashboard。点击“Entity table”部件中任意实体行，将直接跳转到“Time series chart”部件，查看主部件所选实体的详情。

{% include images-gallery.html imageCollection="mob-layout-5" %}

### Set entity from widget

_Set entity from widget_ 复选框用于将部件中的特定实体加入 state。通过创建“[Entity from dashboard state](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state)”或其它别名，可在目标 dashboard state 中使用该实体。例如，表格部件中有设备列表，希望点击表格行时显示对应设备详情。

有时需在 state 中保存多个实体。例如，先进入客户列表，再进入该客户的设备列表，最后进入某设备详情。此时可有三个 state：“Main”、“Customer Devices”和“Device Details”。
在“Device Details”state 中可使用两个不同的 state entity 参数引用当前客户（如“currentCustomer”）和当前设备（如“currentDevice”）。

{% include images-gallery.html imageCollection="entityfromwidget" %}