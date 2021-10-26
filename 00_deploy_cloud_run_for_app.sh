# Load Configs
. ./config

gcloud run deploy $APP_CLOUD_RUN_NAME \
    --source . \
    --allow-unauthenticated \
    --platform managed \
    --region $APP_CLOUD_RUN_REGION \
    --project=$GCP_PROJECT_ID