# Publish response to RPC request. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
curl -v -X POST -d @rpc-response.json http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc/1 --header "Content-Type:application/json"
# For example,$THINGSBOARD_HOST_NAMEreference ThingsBoard Cloud (North America),$ACCESS_TOKENis ABC123:
curl -v -X POST -d @rpc-response.json https://thingsboard.cloud/api/v1/ABC123/rpc/1 --header "Content-Type:application/json"
# For example,$THINGSBOARD_HOST_NAMEreference ThingsBoard Cloud (Europe),$ACCESS_TOKENis ABC123:
curl -v -X POST -d @rpc-response.json https://eu.thingsboard.cloud/api/v1/ABC123/rpc/1 --header "Content-Type:application/json"