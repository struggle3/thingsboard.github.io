{% capture install_docker_user_to_group %}
**不要忘记将 Linux 用户加入 docker 用户组。参见 [以非 root 用户管理 Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)。**
{% endcapture %}
{% include templates/warn-banner.md content=install_docker_user_to_group %}