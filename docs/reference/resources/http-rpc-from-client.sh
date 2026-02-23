# Post client-side rpc request. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
curl -X POST -d @rpc-client-request.json http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc --header "Content-Type:application/json"
# For example,$THINGSBOARD_HOST_NAMEreference ThingsBoard Cloud (North America),$ACCESS_TOKENis ABC123:
curl -X POST -d @rpc-client-request.json https://thingsboard.cloud/api/v1/ABC123/rpc --header "Content-Type:application/json"
# For example,$THINGSBOARD_HOST_NAMEreference ThingsBoard Cloud (Europe),$ACCESS_TOKENis ABC123:
curl -X POST -d @rpc-client-request.json https://eu.thingsboard.cloud/api/v1/ABC123/rpc --header "Content-Type:application/json"