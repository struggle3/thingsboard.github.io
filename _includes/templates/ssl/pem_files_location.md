{% capture pem_files_location %}
**确保证书文件可被 ThingsBoard 进程访问：**

* Linux：使用 */etc/thingsboard/conf* 目录。确保文件权限与 *thingsboard.conf* 一致；使用相对路径，如 *server.pem*；
* Docker Compose：将卷挂载或使用现有卷至容器的 */config* 目录；使用完整路径，如 */config/server.pem*；
* K8S：将独立卷挂载至 */https-config* 或类似目录；使用完整路径，如 */https-config/server.pem*；
* Windows：使用 *C:\Program Files (x86)\thingsboard\conf\\* 目录。确保文件权限与 *thingsboard.conf* 一致；使用相对路径，如 *server.pem*；

{% endcapture %}
{% include templates/warn-banner.md content=pem_files_location %}