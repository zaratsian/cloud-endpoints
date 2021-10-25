# Load Configs
. ./config

# Set Container Repo Tag (based on previous ESPv2_container_build step)
CONTAINER_REPO_TAG=$(gcloud container images list-tags gcr.io/$GCP_PROJECT_ID/endpoints-runtime-serverless --format "value(tags)")

gcloud run deploy $CLOUD_RUN_NAME \
  --image="gcr.io/$GCP_PROJECT_ID/endpoints-runtime-serverless:$CONTAINER_REPO_TAG" \
  --allow-unauthenticated \
  --platform managed \
  --project=$GCP_PROJECT_ID