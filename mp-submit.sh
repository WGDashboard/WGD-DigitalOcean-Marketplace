#!/bin/bash

IMG_ID=$(jq '.builds[-1].artifact_id | split(":")[1] | tonumber' manifest.json)
APP_VERSION=$($venv_python -c "import json; import urllib.request; data = urllib.request.urlopen('https://api.github.com/repos/donaldzou/WGDashboard/releases/latest').read(); output = json.loads(data);print(output['tag_name'])")

echo $IMG_ID
echo $APP_VERSION

# curl -X PATCH -H "Content-Type: application/json" -H "Authorization: Bearer ${DIGITALOCEAN_API_TOKEN}" -d "{\"reasonForUpdate\": \"new version\", \"version\": \"${APP_VERSION}\", \"imageId\": ${IMG_ID}}" https://api.digitalocean.com/api/v1/vendor-portal/apps/${APP_ID}