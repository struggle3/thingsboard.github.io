```bash
./scripts/docker-stop-services.sh
./scripts/docker-upgrade-tbmq.sh --fromVersion=FROM_VERSION
./scripts/docker-start-services.sh
```
{: .copy-code}

其中 `FROM_VERSION` 表示升级起始版本。
有关有效的 `fromVersion` 值，请参阅[升级说明](/docs/mqtt-broker/install/upgrade-instructions/)。

<br>