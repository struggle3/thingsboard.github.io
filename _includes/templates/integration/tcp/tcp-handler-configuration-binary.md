![image](/images/user-guide/integrations/tcp/tcp-handler-configuration-binary.png)

为正确解析 payload，请确保设置以下值：
- **Max Frame Length**：解码帧的最大长度，超出此值将抛出异常；本示例保持默认 **128** 即可；
- **Length Field Offset**：length 字段的偏移。本例中 length 字段为 payload 的第 5 字节 \x30\x30\x30\x30 **\x11** \x53...，设为 **4**；
- **Length Field Length**：length 字段的长度。本例为 1 字节 ...\x30 **\x11** \x53...，设为 **1**；
- **Length Adjustment**：length 字段的补偿值。本例 length 字段为 **17** 字节，无需补偿，保持 **0**；
- **Number of first bytes to strip out from the decoded frame**：从解码帧中去除的首字节数。需跳过前 5 字节以获取数据 \x30\x30\x30\x30\x11 **\x53\x4e\x2d\x30...**，设为 **5**；

![image](/images/user-guide/integrations/tcp/tcp-integration-setup-binary-4-pe.png)