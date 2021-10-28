# Load Configs
. ./config

# Get Cloud Run URL and Hostname
CLOUD_RUN_URL=$(gcloud run services list --format "value(status.url)" --filter "metadata.name=$ENDPOINTS_CLOUD_RUN_NAME")
CLOUD_RUN_HOSTNAME="${CLOUD_RUN_URL//https:\/\//}"
ENDPOINTS_CONFIG_ID=$(gcloud endpoints services list --format "value(serviceConfig.id)" --filter "serviceName=$CLOUD_RUN_HOSTNAME")

echo "[ INFO ] PROJECT_ID:          $GCP_PROJECT_ID"
echo "[ INFO ] CLOUD_RUN_HOSTNAME:  $CLOUD_RUN_HOSTNAME"
echo "[ INFO ] ENDPOINTS_CONFIG_ID: $ENDPOINTS_CONFIG_ID"

# Download Build Script
# https://cloud.google.com/endpoints/docs/openapi/get-started-cloud-run#configure_esp
wget https://raw.githubusercontent.com/GoogleCloudPlatform/esp-v2/master/docker/serverless/gcloud_build_image
chmod +x gcloud_build_image

# Build ESPv2 Container Image
./gcloud_build_image -s $CLOUD_RUN_HOSTNAME -c $ENDPOINTS_CONFIG_ID -p $GCP_PROJECT_ID

# Cleanup gcloud_build_image
rm gcloud_build_image
