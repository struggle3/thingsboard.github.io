您还应部署传输微服务。为节省资源，可省略不使用的协议：

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
