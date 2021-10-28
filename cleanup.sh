# Load Configs
. ./config

# Delete Cloud Run Services
gcloud run services delete $APP_CLOUD_RUN_NAME --region $GCP_REGION
gcloud run services delete $ENDPOINTS_CLOUD_RUN_NAME --region $GCP_REGION
