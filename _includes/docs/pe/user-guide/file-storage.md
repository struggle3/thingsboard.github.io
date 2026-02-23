* TOC
{:toc}

## 概述

ThingsBoard 支持在数据库中存储二进制内容（文件）。
当前用于存储由 [Generate Dashboard Report Node](/docs/user-guide/rule-engine-2-0/nodes/action/generate-dashboard-report/) 生成的报告文件。
存储的文件由 [Send Email Node](/docs/user-guide/rule-engine-2-0/nodes/external/send-email/) 访问以创建邮件附件。
另一种发送文件的方式是 [REST API Call Node](/docs/user-guide/rule-engine-2-0/nodes/external/rest-api-call/)。
用户可通过 **Files** 或 **Reports** 部件访问存储的文件，这些部件属于 **Files** 部件包。   

## Files 部件

ThingsBoard 通过 **Files** 部件提供对存储文件的访问，该部件属于 **Files** 部件包。

![image](/images/user-guide/ui/file-storage-files-widget.png)
 
该部件支持按时间范围筛选文件，并按文件名搜索。
点击 **Download file** 按钮可下载每个文件。
