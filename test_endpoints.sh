# Load Configs
. ./config

# Get Cloud Run URL and Hostname
CLOUD_RUN_URL=$(gcloud run services list --format "value(status.url)" --filter "metadata.name=$ENDPOINTS_CLOUD_RUN_NAME")
echo ""
echo "[ INFO ] Testing against base URL: $CLOUD_RUN_URL"
echo ""

# CURL to Cloud Run Endpoint (GET)
echo ""
echo "Testing /"
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $CLOUD_RUN_URL
echo ""

# CURL to Cloud Run Endpoint (GET)
echo ""
echo "Testing /hello"
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $CLOUD_RUN_URL/hello
echo ""

# CURL to Cloud Run Endpoint (POST)
echo ""
echo "Testing /sample_post"
curl -X POST -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
    -H "Content-Type: application/json" \
    -d '{"key1":"value1"}' \
    $CLOUD_RUN_URL/sample_post 
echo ""


#curl --request GET --header "content-type:application/json" -H "Authorization: Bearer $(gcloud auth print-identity-token)" "https://${ENDPOINTS_HOST}/hello"