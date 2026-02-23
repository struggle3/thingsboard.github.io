{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
本指南将介绍如何[在 {{deviceName}} 上安装 ThingsBoard Edge](#starting-edge-on-device)、[创建设备](#create-device-on-thingsboard-edge)、 
[安装所需库与工具](#install-required-libraries-and-tools)。  
随后将[修改代码并上传到设备](#connect-device-to-thingsboard-edge)， 
并[查看运行结果及通过导入的仪表板在 ThingsBoard Edge 上查看数据](#check-data-on-thingsboard-edge)。
设备将借助[客户端与共享属性请求功能](#synchronize-device-state-using-client-and-shared-attribute-requests)与 ThingsBoard Edge 保持同步。      
此外，您还将学习如何通过[共享属性](#control-device-using-shared-attributes)和 [RPC 请求](#control-device-using-rpc)控制设备。

### 前置条件

开始前请确保满足以下要求：  
{{ prerequisites }} {% if page.docsPrefix == "pe/edge/" %}
- [欧洲](https://eu.thingsboard.cloud/signup){: target="_blank"}或[北美](https://thingsboard.cloud/signup){: target="_blank"}的 ThingsBoard Cloud 账户，或已安装的[本地服务器](/docs/user-guide/install/pe/installation-options/){: target="_blank"}
{% else %}
- [ThingsBoard Cloud](https://thingsboard.io/installations/){: target="_blank"}账户或已安装的[本地服务器](/docs/user-guide/install/installation-options/){: target="_blank"}
{% endif %}

{% else %}

本指南将介绍如何[在 ThingsBoard 上创建设备](#create-device-on-thingsboard)、
[安装所需库与工具](#install-required-libraries-and-tools)。  
随后将[修改代码并上传到设备](#connect-device-to-thingsboard)，
并[查看运行结果及通过导入的仪表板在 ThingsBoard 上查看数据](#check-data-on-thingsboard)。
设备将借助[客户端与共享属性请求功能](#synchronize-device-state-using-client-and-shared-attribute-requests)与 ThingsBoard 保持同步。      
同时，我们将使用[共享属性](#control-device-using-shared-attributes)或 [RPC 请求](#control-device-using-rpc)控制设备。  

### 前置条件

继续本指南前，需具备：  
{{ prerequisites }} {% if page.docsPrefix == "pe/" %}
- [ThingsBoard Cloud（欧洲）](https://eu.thingsboard.cloud/signup){: target="_blank"}或[ThingsBoard Cloud（美洲）](https://thingsboard.cloud/signup){: target="_blank"}
{% else %}
- [ThingsBoard Cloud](https://thingsboard.io/installations/){: target="_blank"}账户或已安装的[本地服务器](/docs/user-guide/install/installation-options/){: target="_blank"}
{% endif %}

{% endif %}

