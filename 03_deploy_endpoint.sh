# Load Configs
. ./config

# Get Cloud Run URL and Hostname
ENDPOINTS_CLOUD_RUN_URL=$(gcloud run services list --format "value(status.url)" --filter "metadata.name=$ENDPOINTS_CLOUD_RUN_NAME")
ENDPOINTS_CLOUD_RUN_HOSTNAME="${ENDPOINTS_CLOUD_RUN_URL//https:\/\//}"
BACKEND_APP_URL=$(gcloud run services list --format "value(status.url)" --filter "metadata.name=$APP_CLOUD_RUN_NAME")
echo "ENDPOINTS_CLOUD_RUN_URL:       $ENDPOINTS_CLOUD_RUN_URL"
echo "ENDPOINTS_CLOUD_RUN_HOSTNAME:  $ENDPOINTS_CLOUD_RUN_HOSTNAME"
echo "BACKEND_APP_URL:               $BACKEND_APP_URL"

# Dynamically update openapi-run.yaml with the Cloud Run Hostname and URL
cp openapi-run.yaml.example openapi-run.yaml
sed -i "s@BACKEND_APP_URL@$BACKEND_APP_URL@" openapi-run.yaml
sed -i "s@ENDPOINTS_CLOUD_RUN_HOSTNAME@$ENDPOINTS_CLOUD_RUN_HOSTNAME@" openapi-run.yaml

# Deploy Google Endpoints Service
gcloud endpoints services deploy openapi-run.yaml \
    --project $GCP_PROJECT_ID
