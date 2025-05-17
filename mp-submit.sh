#!/bin/bash

IMG_ID=$(cat manifest.json | jq .builds[-1].artifact_id | tr -d '"' | cut -d':' -f2)
APP_VERSION=$(python3 -c "import json; import urllib.request; data = urllib.request.urlopen('https://api.github.com/repos/donaldzou/WGDashboard/releases/latest').read(); output = json.loads(data);print(output['tag_name'])")

echo "$IMG_ID"
echo "$APP_VERSION"

# curl -X PATCH -H "Content-Type: application/json" -H "Authorization: Bearer ${DIGITALOCEAN_API_TOKEN}" -d "{\"reasonForUpdate\": \"new version\", \"version\": \"${APP_VERSION}\", \"imageId\": ${IMG_ID}}" https://api.digitalocean.com/api/v1/vendor-portal/apps/${APP_ID}