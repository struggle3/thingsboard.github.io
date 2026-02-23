**ThingsBoard 内置 In Memory 队列服务，默认使用且无需额外配置。**

```text
nano tb-node.env
```
{: .copy-code}

将以下内容添加到文件中。

```bash
TB_QUEUE_TYPE=in-memory
```
{: .copy-code}

如需配置端口，请检查 docker-compose.yml：

```bash
nano docker-compose.yml
```

```bash
services:
  tbpe:
    restart: always
    image: "${DOCKER_REPO}/${TB_NODE_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
```
{: .copy-code}
