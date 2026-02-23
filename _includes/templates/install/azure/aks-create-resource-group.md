创建 AKS 集群之前，需要先创建 Azure 资源组——用于部署和管理 Azure 资源的逻辑组。可通过 Azure [门户](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)创建，
也可以使用 Azure CLI 工具。
```
az group create --name MyResourceGroup --location YOUR_LOCATION
```
{: .copy-code}


有关 `az group` 操作的更多信息请参阅[此处](https://docs.microsoft.com/en-us/cli/azure/group)

如需删除组可使用：

```
az group delete -n MyResourceGroup
```
{: .copy-code}
