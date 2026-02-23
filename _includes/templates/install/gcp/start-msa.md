执行以下命令部署第三方组件（zookeeper、kafka、redis）和主要 ThingsBoard 微服务：*tb-node*、*tb-web-ui* 和 *js-executors*：

```
./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后可运行 `kubectl get pods`。若一切正常，应能看到 `tb-node-0` Pod 处于 `READY` 状态。

还需部署传输微服务。为节省资源，可省略不使用的协议：

### HTTP 传输（可选）

```
kubectl apply -f transports/tb-http-transport.yml
```
{: .copy-code}

### MQTT 传输（可选）

```
kubectl apply -f transports/tb-mqtt-transport.yml
```
{: .copy-code}

### CoAP 传输（可选）

```
kubectl apply -f transports/tb-coap-transport.yml
```
{: .copy-code}

### LwM2M 传输（可选）

```
kubectl apply -f transports/tb-lwm2m-transport.yml
```
{: .copy-code}

### SNMP 传输（可选）

```
kubectl apply -f transports/tb-snmp-transport.yml
```
{: .copy-code}