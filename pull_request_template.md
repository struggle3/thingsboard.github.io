## PR 描述

本次文档更新内容：...

## 链接检查

创建或更新 PR 后，构建代理将自动检查链接。

可使用以下命令在本地检查失效链接：

```bash
docker run --rm -it --network=host --name=linkchecker ghcr.io/linkchecker/linkchecker --check-extern --no-warnings http://0.0.0.0:4000/
```
