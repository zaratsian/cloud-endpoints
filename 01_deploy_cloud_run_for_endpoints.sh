# Load Configs
. ./config

# Deploy placeholder/temporary app for Cloud Run Endpoints container
gcloud run deploy $ENDPOINTS_CLOUD_RUN_NAME \
    --image="gcr.io/cloudrun/hello" \
    --region $ENDPOINTS_CLOUD_RUN_REGION \
    --allow-unauthenticated \
    --platform managed \
    --project=$GCP_PROJECT_ID