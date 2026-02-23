# Post client-side rpc request. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
cat rpc-client-request.json | coap post coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc
# For example,$THINGSBOARD_HOST_NAMEreference your local installation,$ACCESS_TOKENis ABC123:
cat rpc-client-request.json | coap post coap://localhost/api/v1/ABC123/rpc