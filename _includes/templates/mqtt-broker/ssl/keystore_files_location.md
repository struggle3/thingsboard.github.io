{% capture tbmq_keystore_files_location %}
**确保 keystore 文件可被 TBMQ 进程访问：**

* Docker Compose：将 volume 挂载到容器的 */config* 目录；使用完整路径，如 */config/keystore.p12*；
* K8S：将单独 volume 挂载到 */https-config* 或类似目录。使用完整路径，如 */https-config/keystore.p12*。

{% endcapture %}
{% include templates/warn-banner.md content=tbmq_keystore_files_location %}
