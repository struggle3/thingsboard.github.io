以下说明将帮助您安装 PostgreSQL。

```bash
# 若尚未安装 **wget**，请先安装：
sudo apt install -y wget

# 导入软件源签名密钥：
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# 将软件源添加到系统：
echo "deb https://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list

# 安装并启动 postgresql 服务：
sudo apt update
sudo apt -y install postgresql
sudo service postgresql start
```
{: .copy-code}

{% include templates/install/postgres-post-install.md %}
