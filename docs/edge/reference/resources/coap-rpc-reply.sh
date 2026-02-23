# Publish response to RPC request. Replace $THINGSBOARD_EDGE_HOST_NAME and$ACCESS_TOKENwith corresponding values.
coap-client -f rpc-response.json -m post coap://$THINGSBOARD_EDGE_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc/1
# For example, $THINGSBOARD_EDGE_HOST_NAME reference localhost,$ACCESS_TOKENis ABC123:
coap-client -f rpc-response.json -m post coap://localhost/api/v1/ABC123/rpc/1