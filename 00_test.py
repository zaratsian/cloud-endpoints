import requests
import subprocess 

subprocess.run(["gcloud", "run", "services", "list", "--format", '"value(status.url)"', "--filter", '"metadata.name=$APP_CLOUD_RUN_NAME"'])
