若合并过程中出现与您修改无关的冲突，
建议接受远程分支的所有新变更。

可通过执行以下命令撤销合并操作：
```bash
git merge --abort
```
{: .copy-code}

然后通过接受 **theirs** 变更重新执行合并：

```bash
git pull origin {{ site.release.broker_branch }} -X theirs
```
{: .copy-code}

默认合并策略的常用选项：
* **-X ours** - 此选项强制以我方版本自动解决冲突块。
* **-X theirs** - 与 **ours** 相反。更多详情请参阅 [此处](https://git-scm.com/docs/merge-strategies#_merge_strategies)。
