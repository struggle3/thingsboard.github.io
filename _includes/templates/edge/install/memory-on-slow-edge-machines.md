执行以下命令编辑 **ThingsBoard Edge** 配置文件：

```bash
echo 'export JAVA_OPTS="$JAVA_OPTS -Xms512M -Xmx1G"' | sudo tee -a /etc/tb-edge/conf/tb-edge.conf
```
{: .copy-code}

该命令在 JAVA_OPTS 当前值后追加两个选项：
* **Xms512M：** 将 Java 虚拟机（JVM）初始堆大小设为 512 MB。
* **Xmx1G：** 将 JVM 最大堆大小设为 1 GB。

建议根据服务器资源调整这些参数。  
应至少设为 2G，若有更多 RAM 可相应增加。  
一般情况下，若不运行其他内存密集型进程（如 Cassandra），可设为总 RAM 的 1/2，否则设为 1/3。