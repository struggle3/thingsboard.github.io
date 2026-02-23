# Send HTTP attributes request. Replace$ACCESS_TOKENwith corresponding value.
curl -v -X GET "{{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
# For example,$ACCESS_TOKENis ABC123:
curl -v -X GET "{{httpsUrl}}/api/v1/ABC123/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"