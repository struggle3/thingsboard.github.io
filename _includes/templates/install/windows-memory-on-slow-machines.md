以管理员身份打开记事本或其他编辑器（右键点击应用图标并选择“以管理员身份运行”）。  
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而非“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\thingsboard.xml
``` 
{: .copy-code}


在配置文件中找到以下行。 

```xml
<startargument>-Xms512m</startargument>
<startargument>-Xmx1024m</startargument>
```
{: .copy-code}

并将其修改为 

```xml
<startargument>-Xms2048m</startargument>
<startargument>-Xmx2048m</startargument>
```

将 "2048m" 改为约为总内存的 1/3（单位为 MB）
{: .copy-code}