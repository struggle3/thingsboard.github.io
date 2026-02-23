以下说明将帮助您安装 PostgreSQL。

```bash
# Update your system
sudo dnf update
```
{: .copy-code}

安装软件源。

**对于 CentOS/RHEL 8：**

```bash
# Install the repository RPM:
sudo dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```
{: .copy-code}

**对于 CentOS/RHEL 9：**

```bash
# Install the repository RPM:
sudo dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```
{: .copy-code}

安装软件包。

```bash
# Install packages
sudo dnf -qy module disable postgresql
sudo dnf -y install postgresql16 postgresql16-server postgresql16-contrib
# Initialize your PostgreSQL DB
sudo /usr/pgsql-16/bin/postgresql-16-setup initdb
sudo systemctl start postgresql-16
# Optional: Configure PostgreSQL to start on boot
sudo systemctl enable --now postgresql-16
```
{: .copy-code}

{% include templates/install/postgres-post-install.md %}
