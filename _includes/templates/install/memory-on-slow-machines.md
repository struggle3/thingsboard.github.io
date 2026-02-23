编辑 ThingsBoard 配置文件

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

在配置文件中添加以下行：

```bash
# 更新 ThingsBoard 内存使用并限制为 2G，路径：/etc/thingsboard/conf/thingsboard.conf
export JAVA_OPTS="$JAVA_OPTS -Xms2G -Xmx2G"
```
{: .copy-code}

建议根据服务器资源调整这些参数。该值应至少设置为 2G（GB），若有更多可用 RAM 可相应增加。通常，若不运行其他内存密集型进程（如 Cassandra），可设置为总 RAM 的 1/2，否则设为 1/3。
