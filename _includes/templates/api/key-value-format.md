## Key-value 格式

默认情况下，ThingsBoard 支持 JSON 形式的 key-value 内容。Key 始终为字符串，value 可为 string、boolean、double、long 或 JSON。
例如：

```json
{
 "stringKey":"value1", 
 "booleanKey":true, 
 "doubleKey":42.0, 
 "longKey":73, 
 "jsonKey": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
 }
}
```
{: .copy-code}