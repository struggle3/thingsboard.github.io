# Send rpc request with 20 seconds timeout. Replace$ACCESS_TOKENwith corresponding value.
curl -v -X GET {{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc?timeout=20000
# For example,$ACCESS_TOKENis ABC123:
curl -v -X GET {{httpsUrl}}/api/v1/ABC123/rpc?timeout=20000