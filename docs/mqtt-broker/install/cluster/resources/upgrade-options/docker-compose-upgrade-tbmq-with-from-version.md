```bash
./scripts/docker-stop-services.sh
./scripts/docker-upgrade-tbmq.sh --fromVersion=FROM_VERSION
./scripts/docker-start-services.sh
```
{: .copy-code}

其中 `FROM_VERSION` 表示升级的起始版本。
参见 [升级说明](/docs/{{docsPrefix}}mqtt-broker/install/upgrade-instructions/) 了解有效的 `fromVersion` 取值。

<br>