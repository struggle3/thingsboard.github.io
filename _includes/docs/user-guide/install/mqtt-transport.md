<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
      </tr>
    </thead>
    <tbody>
    <tr>
        <td>transport.mqtt.bind_address</td>
        <td>MQTT_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>MQTT 绑定地址</td>
    </tr>
    <tr>
        <td>transport.mqtt.bind_port</td>
        <td>MQTT_BIND_PORT</td>
        <td>1883</td>
        <td>MQTT 绑定端口</td>
    </tr>
    <tr>
        <td>transport.mqtt.timeout</td>
        <td>MQTT_TIMEOUT</td>
        <td>10000</td>
        <td>MQTT 处理超时（毫秒）</td>
    </tr>
    <tr>
        <td>transport.mqtt.msg_queue_size_per_device_limit</td>
        <td>MQTT_MSG_QUEUE_SIZE_PER_DEVICE_LIMIT</td>
        <td>100</td>
        <td>设备处于已连接状态之前在队列中等待的消息数。此限制在 TenantProfileLimits 机制之前的底层生效</td>
    </tr>
    <tr>
        <td>transport.mqtt.netty.leak_detector_level</td>
        <td>NETTY_LEAK_DETECTOR_LVL</td>
        <td>DISABLED</td>
        <td>Netty 泄漏检测级别</td>
    </tr>
    <tr>
        <td>transport.mqtt.netty.boss_group_thread_count</td>
        <td>NETTY_BOSS_GROUP_THREADS</td>
        <td>1</td>
        <td>Netty BOSS 线程数</td>
    </tr>
    <tr>
        <td>transport.mqtt.netty.worker_group_thread_count</td>
        <td>NETTY_WORKER_GROUP_THREADS</td>
        <td>12</td>
        <td>Netty worker 线程数</td>
    </tr>
    <tr>
        <td>transport.mqtt.netty.max_payload_size</td>
        <td>NETTY_MAX_PAYLOAD_SIZE</td>
        <td>65536</td>
        <td>最大 payload 大小（字节）</td>
    </tr>
    <tr>
        <td>transport.mqtt.netty.so_keep_alive</td>
        <td>NETTY_SO_KEEPALIVE</td>
        <td>false</td>
        <td></td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.enabled</td>
        <td>MQTT_SSL_ENABLED</td>
        <td>false</td>
        <td>启用/禁用 MQTTS 支持</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.bind_address</td>
        <td>MQTT_SSL_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>MQTT SSL 绑定地址</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.bind_port</td>
        <td>MQTT_SSL_BIND_PORT</td>
        <td>8883</td>
        <td>MQTT SSL 绑定端口</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.protocol</td>
        <td>MQTT_SSL_PROTOCOL</td>
        <td>TLSv1.2</td>
        <td>SSL 协议：参见 <a href="http://docs.oracle.com/javase/8/docs/technotes/guides/security/StandardNames.html#SSLContext">此链接</a></td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.type.</td>
        <td>MQTT_SSL_CREDENTIALS_TYPE</td>
        <td>PEM</td>
        <td>服务器凭据类型（PEM - PEM 证书文件；KEYSTORE - Java keystore）</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.pem.cert_file</td>
        <td>MQTT_SSL_PEM_CERT</td>
        <td>mqttserver.pem</td>
        <td>服务器证书文件路径（含证书或证书链，可包含服务器私钥）</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.pem.key_file</td>
        <td>MQTT_SSL_PEM_KEY</td>
        <td>mqttserver_key.pem</td>
        <td>服务器证书私钥文件路径（可选）</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.pem.key_password</td>
        <td>MQTT_SSL_PEM_KEY_PASSWORD</td>
        <td>server_key_password</td>
        <td>服务器证书私钥密码（可选）</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.keystore.type</td>
        <td>MQTT_SSL_KEY_STORE_TYPE</td>
        <td>PKCS12</td>
        <td>Key store 类型：PKCS12 或 JKS</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.keystore.store_file</td>
        <td>MQTT_SSL_KEY_STORE</td>
        <td>mqttserver.jks</td>
        <td>存放 SSL 证书的 key store 路径</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.keystore.store_password</td>
        <td>MQTT_SSL_KEY_STORE_PASSWORD</td>
        <td>server_ks_password</td>
        <td>访问 key store 的密码</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.credentials.keystore.key_password</td>
        <td>MQTT_SSL_KEY_PASSWORD</td>
        <td>server_key_password</td>
        <td>访问密钥的密码</td>
    </tr>
    <tr>
        <td>transport.mqtt.ssl.skip_validity_check_for_client_cert</td>
        <td>MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT</td>
        <td>false</td>
        <td>跳过客户端证书的有效性校验</td>
    </tr>
    </tbody>
</table>
