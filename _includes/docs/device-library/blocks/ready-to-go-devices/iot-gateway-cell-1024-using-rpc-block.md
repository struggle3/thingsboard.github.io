{% assign sendRpcCommand = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-rpc-button.png,
        title: 可向设备发送命令以执行特定任务。方法参数必须为 JSON 格式。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=sendRpcCommand %} 
要了解更多 RPC 命令，请参阅[此文](/docs/{{page.docsPrefix}}user-guide/rpc/#server-side-rpc)。
所有可发送至设备的命令说明请参见 EXXN IoT 网关手册。
