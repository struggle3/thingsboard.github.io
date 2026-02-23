![image](/images/user-guide/integrations/tcp/tcp-handler-configuration-text.png)

为正确解析 payload，请确保设置以下值：
- **Max Frame Length**：解码帧的最大长度，超出此值将抛出异常；本示例保持默认 **128** 即可；
- **Strip Delimiter**：是否从解码帧中去除分隔符；勾选后将从 payload 中去掉换行符；
- **Message Separator**：指定为 **System Line Separator**，此时将使用换行符作为分隔符；

![image](/images/user-guide/integrations/tcp/tcp-integration-setup-text-4-pe.png)