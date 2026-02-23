# Send subscribe attributes request with 20 seconds timeout. Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.
curl -v -X GET http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes/updates?timeout=20000
# For example,$THINGSBOARD_HOST_NAMEreference ThingsBoard Cloud (North America),$ACCESS_TOKENis ABC123:
curl -v -X GET https://thingsboard.cloud/api/v1/ABC123/attributes/updates?timeout=20000
# For example,$THINGSBOARD_HOST_NAMEreference ThingsBoard Cloud (Europe),$ACCESS_TOKENis ABC123:
curl -v -X GET https://eu.thingsboard.cloud/api/v1/ABC123/attributes/updates?timeout=20000