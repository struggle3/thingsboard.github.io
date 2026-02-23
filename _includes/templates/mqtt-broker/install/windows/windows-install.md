**注意：** 请确保下载的 PowerShell 脚本可在您的系统上运行。

* **打开 PowerShell**（以管理员身份运行）。
* **（可选）查看当前执行策略**。
它决定了系统上运行脚本的安全级别。例如，若返回 `Restricted`，表示 PowerShell 不执行任何脚本。

```bash
Get-ExecutionPolicy
```
{: .copy-code}

* **（可选）如需，更改当前执行策略**。
设置为允许运行 PowerShell 脚本且符合您安全要求的策略。
例如，`Unrestricted` 为限制最少，允许执行所有脚本。

```bash
Set-ExecutionPolicy Unrestricted
```
{: .copy-code}

* **安装 TBMQ**

{% if docsPrefix == null %}

```bash
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/msa/tbmq/configs/windows/tbmq-install-and-run.ps1" `
-OutFile ".\tbmq-install-and-run.ps1"; .\tbmq-install-and-run.ps1
```
{: .copy-code}

{% else %}

```bash
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/thingsboard/tbmq-pe-docker-compose/{{ site.release.broker_branch }}/basic/windows/tbmq-install-and-run.ps1" `
-OutFile ".\tbmq-install-and-run.ps1"; .\tbmq-install-and-run.ps1
```
{: .copy-code}

{% endif %}
