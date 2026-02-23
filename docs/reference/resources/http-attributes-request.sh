# Send HTTP attributes request. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
curl -v -X GET "http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
# For example,$THINGSBOARD_HOST_NAMEreference to ThingsBoard Cloud (North America),$ACCESS_TOKENis ABC123:
curl -v -X GET "https://thingsboard.cloud/api/v1/ABC123/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
# For example,$THINGSBOARD_HOST_NAMEreference to ThingsBoard Cloud (Europe),$ACCESS_TOKENis ABC123:
curl -v -X GET "https://eu.thingsboard.cloud/api/v1/ABC123/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"