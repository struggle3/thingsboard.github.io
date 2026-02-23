
* TOC
{:toc}

前端能力的演进带来了更先进的浏览器功能，显著提升了 Web 端的用户交互与数据通信。
其中 WebSocket 是关键：作为一种可靠的通信协议，它重新定义了 Web 应用中的实时双向通信。

同时，MQTT 以其轻量结构和高可靠性著称，尤其适合资源受限、网络不稳定的环境。
该协议已成为 IoT 生态中消息传输的基石。
其低开销消息传递特性与 Web 端高效通信需求相契合，
尤其适用于移动设备以及传感器监控、关键通知等需要即时数据交换的场景。

MQTT over WebSocket 不仅是技术组合，更是网络通信方式的转变。
它让 MQTT 消息可直接在浏览器中收发，充分发挥 MQTT 与 WebSocket 的优势。
这种结合带来丰富可能：展示实时设备信息、接收实时告警、在移动 Web 应用中进行高效通信等。

## WebSocket 简介

WebSocket 是一种通信协议，使 Web 客户端与服务器通过一条长连接实现实时双向通信。
它明显不同于传统 HTTP 请求/响应模式，支持持续、低延迟的数据交换。
通过 HTTP 升级握手建立，支持未加密（ws://）和加密（wss://）连接。
WebSocket 是需实时内容更新的 Web 应用的重要基础，提供高效、持久的通信通道。

## MQTT over WebSocket 的优势

MQTT 与 WebSocket 的结合为 Web 端 IoT 应用带来诸多优势。
通过 MQTT over WebSocket，传统非 Web 的 MQTT 协议可有效延伸到 Web 应用。
该适配很有必要，因为 Web 浏览器本身不支持 MQTT，需借助 WebSocket 作为桥梁。

该结合的主要特点包括：

* **资源利用高效**：MQTT 为轻量协议，适合带宽或设备能力有限的场景。在 WebSocket 上使用时，可在 Web 应用场景下高效利用网络与设备资源。
* **实时通信**：WebSocket 提供持久连接，实现低延迟实时数据交换。
* **双向通信**：WebSocket 支持全双工，可同时双向传输数据。结合 MQTT 发布/订阅模型，实现动态、可交互的通信场景。
* **与 Web 生态兼容**：通过 MQTT over WebSocket，协议可与浏览器安全模型兼容，便于接入 Web 应用，而无需额外插件或特殊配置。
* **保留 MQTT 特性**：集成不牺牲 MQTT 原生功能（如保留消息、遗嘱、clean session），保障功能完整可靠。

## TBMQ 中的 MQTT over WebSocket

TBMQ 使用 WS（WebSocket）和 WSS（WebSocket Secure）两个监听器支持 WebSocket 通信。
可在此[查看](/docs/{{docsPrefix}}mqtt-broker/security/#ws-listener)监听器概览。

{% capture difference %}
**说明**：v1.3.0 之前的既有部署需更新配置文件以启用 WebSocket 通信。
例如在 AWS 部署中，需在 AWS 负载均衡器上开放额外端口。
请拉取最新配置文件或修改现有配置以应用必要更改。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

WebSocket 相关参数详情请参阅[此处](/docs/{{docsPrefix}}mqtt-broker/install/config/#mqtt-listeners-parameters)
（查找 `LISTENER_WS_ENABLED` 及相关环境变量）。

## 快速开始

本指南演示如何使用 [MQTT.js](https://github.com/mqttjs/MQTT.js) 库连接 TBMQ、订阅主题并收发消息的示例。

### 安装 TBMQ

开始前，请确保 TBMQ 已成功安装。
不同平台安装步骤请参阅[安装选项](/docs/{{docsPrefix}}mqtt-broker/install/installation-options/)文档。

本指南使用以下快速安装说明。

{% capture contenttogglespec %}
Linux & Mac OS%,%linuxmacos%,%templates/mqtt-broker/install/linux-macos/linux-macos.md%br%
Windows%,%windows%,%templates/mqtt-broker/install/windows/windows.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tbmqGettingStartedInstallation" toggle-spec=contenttogglespec %}

### 安装 MQTT WebSocket 客户端

安装 MQTT.js 前，请确保已安装 Node.js 运行环境。
安装 Node.js 可参考[此处](https://nodejs.org/en/learn/getting-started/how-to-install-nodejs)。

安装 Node.js 后，可使用 `npm` 或 `yarn` 安装 MQTT.js 库。

```bash
npm install mqtt --save
```
{: .copy-code}

```bash
yarn add mqtt
```
{: .copy-code}

若需全局安装，可使用 npm 的 `-g` 参数或 yarn 的 `global` 选项。

```bash
npm install -g mqtt
```
{: .copy-code}

```bash
yarn global add mqtt
```
{: .copy-code}

注意：全局安装可能引发版本冲突，请谨慎使用。

### 连接客户端

连接选项、订阅主题及发布消息的详细说明请参阅 [MQTT.js 文档](https://github.com/mqttjs/MQTT.js?tab=readme-ov-file#api)。

{% capture difference %}
**说明**：用户名 `tbmq_websockets_username` 对应系统中预置的默认 MQTT 客户端凭据，专用于 WebSocket 客户端。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

```javascript
const mqtt = require('mqtt');

const url = 'ws://localhost:8084/mqtt';
const topic = 'sensors/temperature';
const message = 'Hello World';

const options = {
    clean: true,
    clientId: 'tbmq_websockets_client_id',
    username: 'tbmq_websockets_username',
    password: null
};

console.log('Connecting client...');

const client = mqtt.connect(url, options); // connect client

client.on('connect', function () {
    console.log('Client connected!');
    client.subscribe(topic, function (error) { // subscribe to a topic
        if (!error) {
            client.publish(topic, message); // publish a message
        }
    });
});

client.on('message', (topic, message) => { // handle received messages
    console.log(`Received message. Payload: ${message.toString()}. Topic: ${topic}`);
    client.end(); // end client session
});

client.on('error', (error) => { // handle errors
    console.log('Error: ', error?.message);
});

client.on('packetreceive', (packet) => { // handle received packet
    console.log('Packet receive...', packet);
});

client.on('packetsend', (packet) => { // handle sent packet
    console.log('Packet send...', packet);
});

client.on('reconnect', () => {
    console.log('Reconnecting...');
});

client.on('close', () => {
    console.log('Closing client...');
});
```
{: .copy-code}

Please save the provided code to a file named `ws_example.js` and then execute it.

```bash
node ws_example.js
```
{: .copy-code}

The provided example establishes a WebSocket client, connecting it to TBMQ. 
Upon successful connection, the client subscribes to the 'sensors/temperature' topic. 
Following a successful subscription, the client publishes a message to the same topic. 
Subsequently, upon receiving this message, the client disconnects, effectively closing the connection.

Here is the output from executing the ws_example.js file:

```text
Connecting client...
Packet receive... Packet {
  cmd: 'connack',
  retain: false,
  qos: 0,
  dup: false,
  length: 2,
  topic: null,
  payload: null,
  sessionPresent: false,
  returnCode: 0
}
Client connected!
Packet send... {
  cmd: 'subscribe',
  subscriptions: [ { topic: 'sensors/temperature', qos: 0 } ],
  messageId: 64109
}
Packet receive... Packet {
  cmd: 'suback',
  retain: false,
  qos: 0,
  dup: false,
  length: 3,
  topic: null,
  payload: null,
  granted: [ 0 ],
  messageId: 64109
}
Packet send... {
  cmd: 'publish',
  topic: 'sensors/temperature',
  payload: 'Hello World',
  qos: 0,
  retain: false,
  messageId: 0,
  dup: false
}
Packet receive... Packet {
  cmd: 'publish',
  retain: false,
  qos: 0,
  dup: false,
  length: 32,
  topic: 'sensors/temperature',
  payload: <Buffer 48 65 6c 6c 6f 20 57 6f 72 6c 64>
}
Received message. Payload: Hello World. Topic: sensors/temperature
Packet send... { cmd: 'disconnect' }
Closing client...
```

Moreover, you can utilize the [WebSocket client](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/websocket-client/) to subscribe to the topic and receive messages, allowing you to verify the result.

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/ws/ws_example.png)
{% else %}
![image](/images/mqtt-broker/ws/ws_example.png)
{% endif %}

### Connection details

The URL `ws://localhost:8084/mqtt` is composed of several components, as detailed below:

* **ws://**: This specifies the WebSocket protocol scheme. It can be either **ws** for unencrypted connections or **wss** for encrypted connections.
* **localhost**: Refers to the hostname of the local machine where the TBMQ is running. This can be replaced with a DNS hostname if applicable.
* **8084**: Indicates the port number on which the WebSocket server is listening for incoming connections.
* **/mqtt**: This is the required path used by TBMQ for MQTT over WebSocket. The choice of '/mqtt' for the path is based on the MQTT specification.

### MQTT over WebSocket Secure (WSS)

Using MQTT over WebSocket Secure (WSS) in TBMQ offers enhanced security for your data. 
It encrypts communication, making sure that information sent between devices and the broker is protected from unauthorized access.

When using MQTT over WebSocket Secure in TBMQ, it's crucial to understand the difference between certificates signed by well-known Certificate Authorities (CAs) and self-signed certificates. 
Certificates signed by well-known CAs offer a higher level of trust and are widely recognized by clients and browsers. 
This makes them ideal for public-facing applications, as they assure users that the connection is secure and the server is authenticated by a trusted authority.

On the other hand, self-signed certificates can be used for internal or testing purposes. 
While they provide the same level of encryption as CA-signed certificates, they lack the trust endorsement from a recognized CA. 
This means clients might receive security warnings when connecting to the server. 
Self-signed certificates are cost-effective for development or private networks but are not recommended for public or production environments due to trust issues with end users.
{% capture difference %}
If you're utilizing a self-signed certificate for the broker, it's crucial to manually include it within the browser's trust store to ensure seamless connectivity.
This step is essential for [WebSocket client](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/websocket-client/) functionality within the browser environment.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

In summary, for maximum security and user trust in TBMQ, it's best to use certificates signed by well-known CAs for public deployments, 
while self-signed certificates are suitable for internal or development environments.

Two-way authentication, also known as mutual TLS/SSL authentication, involves both the client and the server verifying each other's identity through certificate chains. 
While this is a robust security measure, it poses challenges when implemented in a browser environment using WSS. 
In a typical browser scenario, the server presents its certificate to the client, which the browser checks against a list of trusted CAs. 
This is the standard one-way SSL authentication process.

However, for two-way SSL authentication, the client also needs to present a certificate to the server. 
The challenge in a browser context is that browsers do not universally support client-side certificates for WebSocket connections. 
This lack of support stems from complexities in browser security models and user interfaces, 
which make it challenging to seamlessly implement client-side certificate handling for WSS. 
Moreover, managing client certificates in a browser environment can be cumbersome and poses user experience challenges.

As a result, while two-way authentication is technically possible and highly secure, its practical implementation in browsers using WSS is limited and often not feasible. 
Therefore, for web-based applications using WSS, one-way SSL authentication with additional layers of security, 
like API keys or OAuth tokens, is commonly used to ensure secure communication.

In non-browser environments such as Node.js, and programming languages like Python and Java, when utilizing the appropriate MQTT library, 
two-way authentication functions seamlessly and remains an exceptionally effective security measure.

Let's review the example. Make sure WSS listener is [enabled and configured](/docs/{{docsPrefix}}mqtt-broker/security/#wss-listener) properly. 

For establishing a two-way authenticated connection, ensure that the MQTT client credentials of type 'X.509 Certificate Chain' are created, 
with the client certificate Common Name (CN) specified. Refer to [this guide](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/mqtt-client-credentials/#ssl-credentials) for detailed instructions.
Replace `example.com` with your actual DNS and replace `/path/to/your/client/key/file.pem`, `/path/to/your/client/cert/file.pem`,
and `/path/to/your/ca/cert/file.pem` with the respective paths to your certificate files.

Alternatively, if you prefer to authenticate via 'Basic' credentials (one-way auth) in the example below, you can set options.username to 'tbmq_websockets_username' instead of 'null'.
Additionally, you'll need to comment out lines where options are set, such as 'options.key', 'options.cert', and any other related to client certificate lines.

```javascript
const mqtt = require('mqtt');
const fs = require('fs');

const url = 'wss://example.com:8085/mqtt';
const topic = 'sensors/temperature';
const message = 'Hello World';

// File paths
const keyFile = '/path/to/your/client/key/file.pem';
const certFile = '/path/to/your/client/cert/file.pem';
const caFile = '/path/to/your/ca/cert/file.pem';

const options = {
  clean: true,
  clientId: 'tbmq_websockets_client_id',
  username: null,
  password: null
};

try {
  const dataKey = fs.readFileSync(keyFile);
  const dataCert = fs.readFileSync(certFile);
  const dataCa = fs.readFileSync(caFile);

  // Set the certificate and key options
  options.key = dataKey;
  options.cert = dataCert;
  options.ca = dataCa;
  options.rejectUnauthorized = true;

  console.log('Connecting client...');

  const client = mqtt.connect(url, options); // connect client

  client.on('connect', function () {
    console.log('Client connected!');
    client.subscribe(topic, function (error) { // subscribe to a topic
      if (!error) {
        client.publish(topic, message); // publish a message
      }
    });
  });

  client.on('message', (topic, message) => { // handle received messages
    console.log(`Received message. Payload: ${message.toString()}. Topic: ${topic}`);
    client.end(); // end client session
  });

  client.on('error', (error) => { // handle errors
    console.log('Error: ', error?.message);
  });

  client.on('packetreceive', (packet) => { // handle received packet
    console.log('Packet receive...', packet);
  });

  client.on('packetsend', (packet) => { // handle sent packet
    console.log('Packet send...', packet);
  });

  client.on('reconnect', () => {
    console.log('Reconnecting...');
  });

  client.on('close', () => {
    console.log('Closing client...');
  });

} catch (err) {
  console.error('Error reading certificate file:', err);
}
```
{: .copy-code}

Please save the provided code to a file named `wss_example.js` and then execute it.

```bash
node wss_example.js
```
{: .copy-code}

Upon successful execution of the wss.example.js file, you should observe a similar output as for the ws_example.js example.

## Conclusion

In this guide, we explored the powerful combination of MQTT and WebSocket, a solution that enhances IoT communication with efficiency and flexibility. 
We delved into how MQTT over WebSocket provides a real-time, bi-directional communication channel that operates seamlessly in web environments, ensuring data is exchanged swiftly and reliably. 
Emphasizing security, we discussed the implementation of SSL/TLS encryption for secure data transmission and the distinction between certificates signed by well-known CAs and self-signed certificates. 
Additionally, we tackled practical aspects, including code examples and the limitations of two-way authentication in browser environments. 
This guide aims to serve as a comprehensive resource for anyone looking to implement MQTT over WebSocket, ensuring an efficient, secure, and robust IoT communication system.
