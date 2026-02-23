要添加新的 RPC 方法，请按以下步骤操作：

{% assign creatingRPC = '
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-11-ce.png,
        title: 在 "**Requests mapping**" 部分点击 "**Add mapping**" 以添加新的服务端 RPC 命令。
    ===
        image: /images/gateway/mqtt-connector/mqtt-rpc-overview-1.png,
        title: 选择 "**Request type**"：`With response` 或 `Without response`。
    ===
        image: /images/gateway/mqtt-connector/mqtt-rpc-overview-3.png,
        title: 填写必填字段："**Device name filter**"、"**Method filter**"、"**Request topic expression**" 和 "**Value expression**"。
    ===
        image: /images/gateway/mqtt-connector/mqtt-rpc-overview-2.png,
        title: 对于双向 RPC，还需配置 "**Response topic expression**"、"**Response topic QoS**" 和 "**Response timeout**"。完成后点击 "**Add**"。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingRPC %}