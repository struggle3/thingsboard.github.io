{% capture tbmq_pem_files_location %}
**确保证书文件可被 TBMQ 进程访问：**

* Docker Compose：将 volume 挂载到容器的 */config* 目录；使用完整路径，如 */config/server.pem*；
* K8S：将单独 volume 挂载到 */https-config* 或类似目录。使用完整路径，如 */https-config/server.pem*。

{% endcapture %}
{% include templates/warn-banner.md content=tbmq_pem_files_location %}
