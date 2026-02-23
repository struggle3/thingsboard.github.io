
* TOC
{:toc}

TBMQ 通过 Spring Boot Actuator 框架支持 **健康检查**。
健康检查允许监控系统评估 TBMQ 及其依赖项的状态。
TBMQ 健康检查可通过 **8083** 端口上的 `/actuator/health` 端点访问，
可配置为包含与 **PostgreSQL**、**Kafka** 和 **Redis** 等关键服务的连接健康相关的详细信息。

## 健康端点响应状态码

* **200 OK**：系统健康，所有组件运行正常。
* **503 Service Unavailable**：一个或多个组件故障，系统视为不健康。

## 关键配置参数

以下参数用于配置健康检查并通过 actuator 端点暴露。

```yaml
management:
   health:
      diskspace:
         # Enable/disable disk space health check
         enabled: "${HEALTH_DISKSPACE_ENABLED:false}"
   endpoint:
      health:
         # Controls whether health endpoint shows full component details (e.g., Redis, DB, TBMQ).
         # Options:
         # - 'never': always hide details (default if security is enabled).
         # - 'when-authorized': show details only to authenticated users.
         # - 'always': always include full health details in the response
         show-details: "${HEALTH_SHOW_DETAILS:never}"
   endpoints:
      web:
         exposure:
            # Specify which Actuator endpoints should be exposed via HTTP.
            # Use 'health,info' to expose only basic health and information endpoints.
            # For exposing Prometheus metrics, update this to include 'prometheus' in the list (e.g., 'health,info,prometheus')
            include: "${METRICS_ENDPOINTS_EXPOSE:health,info,prometheus}"
```

### 参数说明

1. **`health.diskspace.enabled`**：

    * **描述**：启用或禁用磁盘空间健康检查。
    * **默认**：禁用（`false`）。
    * **用例**：启用时，检查容器的磁盘使用量，并在磁盘空间不足时报告。

2. **`endpoint.health.show-details`**：

    * **描述**：控制 `/actuator/health` 端点是否显示详细的健康信息。
    * **选项**：
        * `never`：始终隐藏详细组件信息（启用安全时的默认值）。
        * `when-authorized`：仅对已认证用户显示详情。
        * `always`：始终在响应中包含完整健康详情。
    * **默认**：`never`。
    * **用例**：根据安全和访问控制管理健康详情的暴露。

3. **`endpoints.web.exposure.include`**：

    * **描述**：指定应通过 HTTP 暴露哪些 Actuator 端点。
    * **示例**：`health,info,prometheus`。
    * **用例**：控制哪些端点可公开访问，如 `health`、`info` 或 `prometheus` 指标。

### 健康检查端点输出示例

`/actuator/health` 端点返回反映系统整体状态及单个组件状态的 JSON 数据，
包括 **TBMQ** 和 **Kafka** 等自定义检查。
当 `show-details` 未设置为 `never` 时，会包含此详细信息。
若 `show-details` 设为 `never`，端点仅返回整体状态，不包含组件详情。

**健康响应**：

```json
{
   "status":"UP",
   "components":{
      "db":{
         "status":"UP",
         "details":{
            "database":"PostgreSQL",
            "validationQuery":"isValid()"
         }
      },
      "kafka":{
         "status":"UP",
         "details":{
            "brokerCount":3
         }
      },
      "ping":{
         "status":"UP"
      },
      "redis":{
         "status":"UP",
         "details":{
            "version":"7.0.15"
         }
      },
      "tbmq":{
         "status":"UP"
      }
   }
}
```

**不健康响应**：

```json
{
   "status":"DOWN",
   "components":{
      "db":{
         "status":"UP",
         "details":{
            "database":"PostgreSQL",
            "validationQuery":"isValid()"
         }
      },
      "kafka":{
         "status":"UP",
         "details":{
            "brokerCount":1
         }
      },
      "ping":{
         "status":"UP"
      },
      "redis":{
         "status":"DOWN",
         "details":{
            "error":"org.springframework.dao.QueryTimeoutException: Redis command timed out"
         }
      },
      "tbmq":{
         "status":"UP"
      }
   }
}
```

上述示例中：

* 若系统为 **UP**，健康检查将为各组件（如 `db`、`redis`、`tbmq`、`kafka`）返回 `UP`。
这意味着 TBMQ 运行正常且所有依赖项健康。
* 若任何单个组件故障（如 `redis`、`kafka`），健康检查将为该服务返回 `DOWN`，
并提供说明服务不可用的错误信息（如「Redis 连接失败」或「Kafka broker 不可达」）。
* 若 **任一** 服务（如 `db`、`redis`、`tbmq`、`kafka`）为 down，健康检查的 **整体状态** 将为 `DOWN`。
即，即使仅一个组件不可用，整个系统也视为不健康。

### 超时配置

健康检查通过执行用于测试连接的命令验证与 Kafka、Redis 和 PostgreSQL 等必要依赖的连接性。
每条命令都有超时，用于在连接测试失败前等待的时间。
每个第三方服务的超时可根据应用需求自定义。

```yaml
# Kafka Admin client command timeout (in seconds). Applies to operations like describeCluster, listTopics, etc
queue.command-timeout: "${TB_KAFKA_ADMIN_COMMAND_TIMEOUT_SEC:30}"

# Maximum time (in seconds) to wait for a lettuce command to complete.
# This affects health checks and any command execution (e.g. GET, SET, PING).
# Reduce this to fail fast if Redis is unresponsive
lettuce.command-timeout: "${REDIS_LETTUCE_COMMAND_TIMEOUT_SEC:30}"

# Maximum time (in milliseconds) HikariCP will wait to acquire a connection from the pool.
# If exceeded, an exception is thrown. Default is 30 seconds
spring.connectionTimeout: "${SPRING_DATASOURCE_CONNECTION_TIMEOUT_MS:30000}"
```

## Integration Executor 微服务

**TBMQ Integration Executor (IE)** 也通过 Spring Boot Actuator 暴露健康检查。
此健康检查监控 Integration Executor 的健康状态，确保其能连接 Kafka。

* **端点**：健康检查可在 `/actuator/health` 访问。
* **健康检查 URL**：健康检查通过向 **8082** 端口的 `/actuator/health` 端点发送 HTTP 请求验证服务状态。

**健康响应**：

```json
{
   "status":"UP",
   "components":{
      "kafka":{
         "status":"UP",
         "details":{
            "brokerCount":3
         }
      },
      "ping":{
         "status":"UP"
      }
   }
}
```

## 总结

* **健康检查**：TBMQ 使用 Spring Boot Actuator 的健康检查机制监控自身及 **PostgreSQL**、**Kafka**、**Redis** 等依赖项。
* **可配置的健康详情**：可自定义健康检查响应中显示的详细程度，可选始终、基于授权或隐藏。

通过配置健康检查并暴露详细信息，
可确保 TBMQ 的运行状态得到妥善监控，并基于此数据设置告警系统。

**Docker Compose 配置示例**：

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8083/actuator/health"]
  interval: 30s
  retries: 3
  start_period: 30s
  timeout: 10s
```
{: .copy-code}

**在 Kubernetes 中**，可在 pod/statefulset/deployment 配置中设置存活探针和就绪探针：

```yaml
livenessProbe:
  httpGet:
    path: /actuator/health
    port: 8083
  initialDelaySeconds: 30
  periodSeconds: 30
  timeoutSeconds: 10
  failureThreshold: 3

readinessProbe:
  httpGet:
    path: /actuator/health
    port: 8083
  initialDelaySeconds: 30
  periodSeconds: 30
  timeoutSeconds: 10
  failureThreshold: 3
```
{: .copy-code}

这些资源提供在 **Docker** 和 **Kubernetes** 环境中配置和使用健康检查的详细信息。

* **Docker 健康检查文档**：[Docker Health Checks](https://docs.docker.com/reference/dockerfile/#healthcheck)。
* **Kubernetes 探针**：[Kubernetes Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)。
