集群就绪后，您必须创建 AWS 负载均衡器控制器。
您可以按照[此](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)指南操作。
集群预置脚本将创建多个负载均衡器：

* "tb-http-loadbalancer" - 负责 Web UI、REST API 和 HTTP 传输的 AWS ALB；
* "tb-mqtt-loadbalancer" - 负责 MQTT 传输的 AWS NLB；
* "tb-coap-loadbalancer" - 负责 CoAP 传输的 AWS NLB；
* "tb-edge-loadbalancer" - 负责 Edge 实例连接的 AWS NLB；

AWS 负载均衡器[控制器](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)的预置是**非常重要的一步**，这些负载均衡器需要它才能正常工作。
