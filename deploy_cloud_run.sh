# Load Configs
. ./config

gcloud run deploy $CLOUD_RUN_NAME \
    --source . \
    --allow-unauthenticated \
    --platform managed \
    --region $GCP_REGION \
    --project=$GCP_PROJECT_ID