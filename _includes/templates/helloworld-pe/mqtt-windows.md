请按以下步骤在 Windows 中下载、安装、配置并运行 mosquitto_pub：

1. 下载并安装 Eclipse Mosquitto。访问 [Mosquitto 官方下载页](https://mosquitto.org/download/){:target="_blank"}，选择适合您系统的 Windows 安装程序（32 位或 64 位）。
2. 下载完成后运行安装程序并按提示操作，即可在 Windows 上安装 Mosquitto。默认安装在 `C:\Program Files\mosquitto`。
3. 更新系统的「Path」变量。可执行文件 `mosquitto_pub.exe` 和 `mosquitto_sub.exe` 位于 Mosquitto 安装目录。需要将该目录添加到系统的「Path」环境变量，以便 Windows 可在任意当前目录下找到这些可执行文件。

将 Mosquitto 目录添加到「Path」变量的步骤如下： 

{% assign mosquitto-windows = '
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-1.png,
        title: 按 Win + X，选择「System」，然后点击「System」页面；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-2.png,
        title: 进入「About」部分，点击「Advanced system settings」；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-3.png,
        title: 在「System Properties」弹出窗口中，点击「Advanced」选项卡上的「Environment Variables」按钮；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-4.png,
        title: 在「Environment Variables」弹出窗口中选中「Path」，点击「Edit」按钮；
    === 
        image: /images/helloworld/getting-started-pe/mosquitto-windows-5.png,
        title: In the "Edit environment variable" pop-up window click on the "New" button and add the path to the directory containing &#39;mosquitto_pub.exe&#39; and &#39;mosquitto_sub.exe&#39; (&#39;C:\Program Files\mosquitto&#39; by default). Click "OK" button;
    === 
        image: /images/helloworld/getting-started-pe/mosquitto-windows-6.png,
        title: 点击「OK」保存环境变量更改；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-7.png,
        title: 最后点击「OK」应用系统属性中的所有更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=mosquitto-windows %}
