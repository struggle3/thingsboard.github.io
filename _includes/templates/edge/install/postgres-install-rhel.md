要安装 **PostgreSQL**，请按以下说明操作。

更新系统：
```bash
sudo dnf update
```
{: .copy-code}

安装仓库 RPM：

* **CentOS/RHEL 8：**

```bash
sudo dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```
{: .copy-code}

* **CentOS/RHEL 9：**

```bash
sudo dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```
{: .copy-code}

安装软件包并初始化 PostgreSQL。PostgreSQL 服务将在系统启动时自动运行。

```bash
sudo dnf -qy module disable postgresql && \
sudo dnf -y install postgresql16 postgresql16-server postgresql16-contrib && \
sudo /usr/pgsql-16/bin/postgresql-16-setup initdb && \
sudo systemctl enable --now postgresql-16
```
{: .copy-code}

{% include templates/install/postgres-post-install.md %}
