# Load Configs
. ./config

# Delete Endpoint Service
#CLOUD_RUN_URL=$(gcloud run services list --format "value(status.url)")
#CLOUD_RUN_HOSTNAME="${CLOUD_RUN_URL//https:\/\//}"
#gcloud endpoints services delete $CLOUD_RUN_HOSTNAME

# Delete Cloud Run Service
gcloud run services delete $CLOUD_RUN_NAME --region $GCP_REGION
