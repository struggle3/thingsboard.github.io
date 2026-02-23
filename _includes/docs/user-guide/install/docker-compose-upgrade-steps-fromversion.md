{% assign current_version = include.version %}
{% assign from_version = include.fromversion %}

1. 修改`.env`文件中的`TB_VERSION`参数。

```.env
TB_VERSION={{ current_version }}
```

2. 执行以下命令：

```bash
./docker-stop-services.sh
./docker-upgrade-tb.sh --fromVersion={{ from_version }}
./docker-start-services.sh
```
{: .copy-code}