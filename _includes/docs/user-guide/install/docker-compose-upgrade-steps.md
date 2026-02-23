{% assign current_version = include.version %}

1. 修改`.env`文件中的`TB_VERSION`参数。

```.env
TB_VERSION={{ current_version }}
```

2. 执行以下命令：

{% if include.skipUpgrade %}

```bash
./docker-stop-services.sh  
./docker-start-services.sh
```
{: .copy-code}

{% else %}

```bash
./docker-stop-services.sh  
./docker-upgrade-tb.sh
./docker-start-services.sh
```
{: .copy-code}

{% endif %}
