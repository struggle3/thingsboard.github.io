# Publish response to RPC request. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
coap-client -f rpc-response.json -m post coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc/1
# For example,$THINGSBOARD_HOST_NAMEreference to ThingsBoard Cloud (North America),$ACCESS_TOKENis ABC123:
coap-client -f rpc-response.json -m post coap://coap.thingsboard.cloud/api/v1/ABC123/rpc/1
# For example,$THINGSBOARD_HOST_NAMEreference to ThingsBoard Cloud (Europe),$ACCESS_TOKENis ABC123:
coap-client -f rpc-response.json -m post coap://coap.eu.thingsboard.cloud/api/v1/ABC123/rpc/1