import google.auth
from google.auth.transport.requests import AuthorizedSession


def impersonated_id_token():
    credentials, project = google.auth.default(scopes=['https://www.googleapis.com/auth/cloud-platform'])
    authed_session = AuthorizedSession(credentials)
    sa_to_impersonate = "<SA_NAME>@<GCP_PROJECT>.iam.gserviceaccount.com"
    request_body = {"audience": "<SOME_URL>"}
    response = authed_session.post( f'https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/{sa_to_impersonate}:generateIdToken',request_body)
    return response

if __name__ == "__main__":
    print(impersonated_id_token().json())