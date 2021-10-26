# Load Configs
. ./config

# Set Container Repo Tag (based on previous ESPv2_container_build step)
CONTAINER_REPO_TAG=$(gcloud container images list-tags gcr.io/$GCP_PROJECT_ID/endpoints-runtime-serverless --format "value(tags)" | grep $ENDPOINTS_CLOUD_RUN_NAME | head -1)

echo "[ INFO ] CONTAINER_REPO_TAG:       $CONTAINER_REPO_TAG"
echo "[ INFO ] Using this Docker Image:  gcr.io/$GCP_PROJECT_ID/endpoints-runtime-serverless:$CONTAINER_REPO_TAG"

gcloud run deploy $ENDPOINTS_CLOUD_RUN_NAME \
  --image="gcr.io/$GCP_PROJECT_ID/endpoints-runtime-serverless:$CONTAINER_REPO_TAG" \
  --region $ENDPOINTS_CLOUD_RUN_REGION \
  --allow-unauthenticated \
  --platform managed \
  --project=$GCP_PROJECT_ID