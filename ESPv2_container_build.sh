# Load Configs
. ./config

# Get Cloud Run URL and Hostname
CLOUD_RUN_URL=$(gcloud run services list --format "value(status.url)")
CLOUD_RUN_HOSTNAME="${CLOUD_RUN_URL//https:\/\//}"
ENDPOINTS_CONFIG_ID=$(gcloud endpoints services list --format "value(serviceConfig.id)" --filter "serviceName=$CLOUD_RUN_HOSTNAME")

# Build ESPv2 Container Image
./gcloud_build_image -s $CLOUD_RUN_HOSTNAME -c $ENDPOINTS_CONFIG_ID -p $GCP_PROJECT_ID