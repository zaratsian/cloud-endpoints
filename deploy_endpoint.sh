# Load Configs
. ./config

# Get Cloud Run URL and Hostname
CLOUD_RUN_URL=$(gcloud run services list --format "value(status.url)")
CLOUD_RUN_HOSTNAME="${CLOUD_RUN_URL//https:\/\//}"
echo "Cloud Run URL:  $CLOUD_RUN_URL"
echo "Cloud Run Host: $CLOUD_RUN_HOSTNAME"

# Dynamically update openapi-run.yaml with the Cloud Run Hostname and URL
cp openapi-run.yaml.example openapi-run.yaml
sed -i "s@CLOUD_RUN_URL@$CLOUD_RUN_URL@" openapi-run.yaml
sed -i "s@CLOUD_RUN_HOSTNAME@$CLOUD_RUN_HOSTNAME@" openapi-run.yaml

# Deploy Google Endpoints Service
gcloud endpoints services deploy openapi-run.yaml \
    --project $GCP_PROJECT_ID

# Cleanup file - remove openapi-run.yaml
#rm openapi-run.yaml
