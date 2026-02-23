# Send rpc request with 20 seconds timeout. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
curl -v -X GET http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc?timeout=20000
# For example,$THINGSBOARD_HOST_NAMEreference your local installation,$ACCESS_TOKENis ABC123:
curl -v -X GET http://localhost:8080/api/v1/ABC123/rpc?timeout=20000