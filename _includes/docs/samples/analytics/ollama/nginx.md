* TOC
{:toc}

## 概述 {#overview}

[Ollama](https://ollama.com/){:target="_blank"} 是本地运行大语言模型（LLM）的强力工具，但不包含内置认证机制。
当在网络上暴露 Ollama 时，保护 API 端点成为您的责任。

本指南演示如何将 Ollama 与 [Nginx](https://nginx.org/){:target="_blank"} 作为[反向代理](https://en.wikipedia.org/wiki/Reverse_proxy){:target="_blank"}部署，为 Ollama 部署添加认证。Nginx 代理充当安全守门人，在将请求转发到 Ollama 服务前验证凭据。

我们将介绍两种常见认证方式：
- **HTTP Basic Authentication**（用户名和密码）
- **Bearer Token Authentication**（密钥 API key）

Ollama 和 Nginx 两个服务将通过 Docker Compose 以容器形式一起部署。
本指南重点通过可工作的实现演示概念，您可在此基础上进一步定制。
我们使用标准 Ollama Docker 镜像且不启用 GPU 加速，以便设置简洁，之后可添加 GPU 支持以提升性能。

{% capture https_warning %}
完成本指南后，我们**强烈建议**按照[官方 Nginx HTTPS 配置指南](https://nginx.org/en/docs/http/configuring_https_servers.html){:target="_blank"}为 Nginx 代理配置 HTTPS，以确保凭据（密码或 bearer token）始终加密传输，不会以明文在网络上发送。
{% endcapture %}
{% include templates/warn-banner.md content=https_warning %}

## 前置条件 {#prerequisites}

开始前，请确保已安装 Docker 和 Docker Compose。
最简单的方式是安装 [Docker Desktop](https://docs.docker.com/desktop/){:target="_blank"} 并确保其已运行后再继续。

## 设置：项目目录 {#project-setup}

首先创建主项目目录 `ollama-nginx-auth`。本指南中创建的所有文件都将放在该目录内。

然后在 `ollama-nginx-auth` 目录内创建 `nginx` 子目录，用于存放 Nginx 相关配置文件。

完成后，目录结构应如下：
```
ollama-nginx-auth/
└── nginx/
```

确保后续步骤都在主目录 `ollama-nginx-auth` 下进行。

## 方式 1：HTTP Basic Authentication {#basic-auth}

此方式使用简单的用户名和密码保护端点。
收到请求时，Nginx 根据 `.htpasswd` 文件中的加密用户列表验证提供的凭据，以决定允许或拒绝访问。

`.htpasswd` 是用于在 Nginx 等 Web 服务器上存储 basic 认证用户名和密码的标准文件。
文件中每行代表一个用户，包含用户名后跟冒号和加密（哈希）密码。

### 步骤 1：创建凭据文件 {#basic-credentials}

从项目根目录（`ollama-nginx-auth`）在 `nginx` 目录内创建 `.htpasswd` 文件。以下命令创建用户名为 `myuser`、密码为 `mypassword` 的文件。

{% capture tabspec %}htpasswd-setup
htpasswd-setup-linux-macos,Linux/macOS,shell,/docs/samples/analytics/resources/htpasswd-setup-linux-macos.sh
htpasswd-setup-windows,Windows (PowerShell),text,/docs/samples/analytics/resources/htpasswd-setup-windows.ps1{% endcapture %}  
{% include tabs.html %}

### 步骤 2：创建 Nginx 配置文件 {#basic-config}

在 `nginx` 目录（`ollama-nginx-auth/nginx/basic_auth.conf`）下创建 `basic_auth.conf` 文件，并粘贴以下内容。
```
events {}

http {
    server {
        listen 80;
    
        location / {
            # This section enforces HTTP Basic Authentication
            auth_basic "Restricted Access";
            auth_basic_user_file /etc/nginx/.htpasswd; # Path to credentials file inside the container
    
            # If authentication is successful, forward the request to Ollama
            proxy_pass http://ollama:11434;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            
            # Increase timeouts for slow model responses to prevent 504 Gateway Timeout errors
            proxy_connect_timeout 300s;
            proxy_send_timeout 300s;
            proxy_read_timeout 300s;
        }
    }
}
```
{: .copy-code}

配置说明：
- `listen 80;`：Nginx 在 Docker 容器内监听 80 端口。
- `auth_basic "Restricted Access";`：启用 HTTP Basic Authentication。
- `auth_basic_user_file /etc/nginx/.htpasswd;`：指定容器内密码文件路径。我们将把本地文件挂载到该路径。
- `proxy_pass http://ollama:11434;`：将已认证的请求转发到 `ollama` 服务的内部地址。

### 步骤 3：创建 Docker Compose 文件 {#basic-compose}

在项目根目录（`ollama-nginx-auth/docker-compose.basic.yml`）创建 `docker-compose.basic.yml` 文件，并粘贴以下内容。
```yml
services:
  ollama:
    image: ollama/ollama
    container_name: ollama
    volumes:
      - ollama_data:/root/.ollama
    restart: unless-stopped

  nginx:
    image: nginx:latest
    container_name: nginx_proxy
    ports:
      - "8880:80"
    volumes:
      - ./nginx/basic_auth.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/.htpasswd:/etc/nginx/.htpasswd:ro
    depends_on:
      - ollama
    restart: unless-stopped

volumes:
  ollama_data:
```
{: .copy-code}

### 步骤 4：运行与测试 {#basic-test}

使用指定的 compose 文件启动服务。`-f` 参数指定要使用的文件。可能需要一定时间。
```shell
docker compose -f docker-compose.basic.yml up -d
```
{: .copy-code}

在 Ollama 容器内直接执行命令拉取模型。我们使用适合测试的轻量模型 `gemma3:1b`。可能需要一定时间。
```shell
docker exec -it ollama ollama pull gemma3:1b
```
{: .copy-code}

使用您的用户（`myuser`）测试：

{% capture tabspec %}http-basic-test
http-basic-test-linux-macos,Linux/macOS,shell,/docs/samples/analytics/resources/http-basic-test-linux-macos.sh
http-basic-test-windows,Windows (PowerShell),text,/docs/samples/analytics/resources/http-basic-test-windows.ps1{% endcapture %}  
{% include tabs.html %}

使用错误凭据进行 API 调用以验证失败情况：

{% capture tabspec %}http-basic-failed-test
http-basic-failed-test-linux-macos,Linux/macOS,shell,/docs/samples/analytics/resources/http-basic-failed-test-linux-macos.sh
http-basic-failed-test-windows,Windows (PowerShell),text,/docs/samples/analytics/resources/http-basic-failed-test-windows.ps1{% endcapture %}  
{% include tabs.html %}

输出将显示 `401 Unauthorized` 错误。

### 步骤 5（可选）：管理用户 {#basic-manage-users}

可在 `.htpasswd` 文件中轻松添加或删除用户。对该文件的修改会立即生效，无需重启 Nginx。

{% capture adding-users-via-htpasswd %}
添加用户时请始终使用 `htpasswd` 命令。该工具会正确加密密码并确保凭据以 Nginx 要求的格式存储。
手动向文件添加明文密码将无效。
{% endcapture %}
{% include templates/info-banner.md content=adding-users-via-htpasswd %}

**添加新用户：**

再次运行 `htpasswd` 命令。以下示例添加用户 `anotheruser`，密码为 `anotherpassword`。

{% capture tabspec %}http-basic-add-user
http-basic-add-user-linux-macos,Linux/macOS,shell,/docs/samples/analytics/resources/http-basic-add-user-linux-macos.sh
http-basic-add-user-windows,Windows (PowerShell),text,/docs/samples/analytics/resources/http-basic-add-user-windows.ps1{% endcapture %}  
{% include tabs.html %}

需要多少用户即可重复执行该命令。

**删除用户：**

在文本编辑器中打开 `./nginx/.htpasswd` 文件，删除对应用户所在行即可。

## 方式 2：Bearer Token（API Key）认证 {#bearer-token}

此方式使用密钥 token。您将在纯文本文件中管理密钥，Nginx 将配置为读取该文件且无需重启服务。

### 步骤 1：创建 API Keys 文件 {#bearer-keys}

在 `nginx` 目录（`ollama-nginx-auth/nginx/api_keys.txt`）下创建 `api_keys.txt` 文件，将 API key 粘贴进去，每行一个。
```
my-secret-api-key-1
admin-key-abcdef
```
{: .copy-code}

### 步骤 2：创建 Nginx 配置文件 {#bearer-config}

在 `nginx` 目录（`ollama-nginx-auth/nginx/bearer_token.conf`）下创建 `bearer_token.conf` 文件，并粘贴以下内容。
此配置包含用于动态读取 API keys 文件的 [Lua](https://www.lua.org/) 脚本。
```
events {}

http {
    server {
        listen 80;

        location / {
            # Lua script to read keys from a file and check against the Authorization header
            # This code runs for every request to this location.
            access_by_lua_block {
                local function trim(s)
                    return (s:gsub("^%s*(.-)%s*$", "%1"))
                end
            
                -- Function to read keys from the file into a set for quick lookups
                local function get_keys_from_file(path)
                    local keys = {}
                    local file = io.open(path, "r")
                    if not file then
                        ngx.log(ngx.ERR, "cannot open api keys file: ", path)
                        return keys
                    end
                    for line in file:lines() do
                        line = trim(line)
                        if line ~= "" then
                            keys[line] = true
                        end
                    end
                    file:close()
                    return keys
                end

                -- Path to the keys file inside the container
                local api_keys_file = "/etc/nginx/api_keys.txt"
                local valid_keys = get_keys_from_file(api_keys_file)

                -- Check the Authorization header
                local auth_header = ngx.var.http_authorization or ""
                local _, _, token = string.find(auth_header, "Bearer%s+(.+)")

                if not token or not valid_keys[token] then
                    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
                end
            }
         
            # If access is granted, forward the request to Ollama
            proxy_pass http://ollama:11434;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            
            # Increase timeouts for slow model responses to prevent 504 Gateway Timeout errors
            proxy_connect_timeout 300s;
            proxy_send_timeout 300s;
            proxy_read_timeout 300s;
        }
    }
}
```
{: .copy-code}

配置说明：
- `listen 80;`：Nginx 在 Docker 容器内监听 80 端口。
- `access_by_lua_block`：为每个请求执行 Lua 脚本以验证 Bearer token。
  - 脚本在每次请求时从 `/etc/nginx/api_keys.txt` 读取有效 API key。
  - 从 `Authorization: Bearer <token>` header 中提取 token。
  - 若 token 缺失或不在有效 key 列表中，返回 401 Unauthorized 响应。
- `proxy_pass http://ollama:11434;`：将已认证的请求转发到 `ollama` 服务的内部地址。

### 步骤 3：创建 Docker Compose 文件 {#bearer-compose}

在项目根目录（`ollama-nginx-auth/docker-compose.bearer.yml`）创建 `docker-compose.bearer.yml` 文件，并粘贴以下内容。
该 `docker-compose.bearer.yml` 使用包含所需 Lua 模块的 Nginx 镜像（`openresty/openresty`）。
```yml
services:
  ollama:
    image: ollama/ollama
    container_name: ollama
    volumes:
      - ollama_data:/root/.ollama
    restart: unless-stopped

  nginx:
    # Use the OpenResty image which includes the Nginx Lua module
    image: openresty/openresty:latest
    container_name: nginx_proxy
    ports:
      - "8880:80"
    volumes:
      # Mount the new Nginx config and the API keys file
      - ./nginx/bearer_token.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro
      - ./nginx/api_keys.txt:/etc/nginx/api_keys.txt:ro
    depends_on:
      - ollama
    restart: unless-stopped

volumes:
  ollama_data:
```
{: .copy-code}

### 步骤 4：运行与测试 {#bearer-test}

使用指定的 compose 文件启动服务。`-f` 参数指定要使用的文件。
```shell
docker compose -f docker-compose.bearer.yml up -d
```
{: .copy-code}

拉取模型（若已在方式 1 中执行过则较快）：
```shell
docker exec -it ollama ollama pull gemma3:1b
```
{: .copy-code}

使用有效 API key 测试请求：

{% capture tabspec %}bearer-test
bearer-test-linux-macos,Linux/macOS,shell,/docs/samples/analytics/resources/bearer-test-linux-macos.sh
bearer-test-windows,Windows (PowerShell),text,/docs/samples/analytics/resources/bearer-test-windows.ps1{% endcapture %}  
{% include tabs.html %}

使用无效 API key 测试以验证失败情况：

{% capture tabspec %}bearer-failed-test
bearer-failed-test-linux-macos,Linux/macOS,shell,/docs/samples/analytics/resources/bearer-failed-test-linux-macos.sh
bearer-failed-test-windows,Windows (PowerShell),text,/docs/samples/analytics/resources/bearer-failed-test-windows.ps1{% endcapture %}  
{% include tabs.html %}

### 步骤 5（可选）：管理 API Keys {#bearer-manage-keys}

在文本编辑器中打开 `./nginx/api_keys.txt` 文件。添加、修改或删除 key（每行一个），然后保存。

由于 Lua 脚本在每次请求时都会读取该文件，修改会在下一次 API 请求时立即生效。

例如，可编辑该文件，删除 `admin-key-abcdef` key，保存后尝试在测试请求中使用该 key。
请求将返回 401 Unauthorized 错误。

## 使用 {#usage}

启动或停止服务时，使用 `docker compose up` 和 `docker compose down` 命令，并确保为所选认证方式指定对应文件（`docker-compose.basic.yml` 或 `docker-compose.bearer.yml`）。
- 无论哪种方式，从项目目录运行以下命令启动服务，将 `<compose-file-name>` 替换为正确的文件名：
  ```shell
  docker compose -f <compose-file-name> up -d
  ```
  {: .copy-code}

- 完成后，使用对应文件名停止容器：
  ```shell
  docker compose -f <compose-file-name> down
  ```
  {: .copy-code}

## 下一步 {#next-steps}

Ollama 端点就绪后，建议执行以下操作：

- **启用 HTTPS**：按照[官方 Nginx HTTPS 配置指南](https://nginx.org/en/docs/http/configuring_https_servers.html){:target="_blank"}为 Nginx 代理配置 HTTPS。

- **添加 GPU 支持**：为 Ollama 启用 GPU 加速以显著提升推理速度。
  可参考 [Ollama Docker GPU 配置说明](https://github.com/ollama/ollama/blob/main/docs/docker.md){:target="_blank"}作为起点。
