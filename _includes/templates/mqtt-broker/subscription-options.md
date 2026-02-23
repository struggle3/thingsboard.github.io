* **Topic filter**（主题过滤器）。MQTT主题过滤器。
* **QoS**。订阅的服务质量。
* **Retain as Published**。为true时，通过此订阅转发的消息保留其发布时的RETAIN标志。
* **Retain Handling**（保留消息处理）。该选项决定客户端订阅主题时broker如何处理保留消息。
    * 0 - 在订阅时发送保留消息；
    * 1 - 若订阅尚不存在，则在订阅时发送保留消息；
    * 2 - 在订阅时不发送保留消息。
* **No local**。为true时，broker不会将来自此客户端的消息转发回进行该订阅的连接。
* **Subscription Identifier**（订阅标识符）。分配给订阅的唯一数值，用于客户端区分不同订阅的消息。
