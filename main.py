import os

from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def main():
    return "Hi"

@app.route("/hello")
def hello():
    return "Hello World Works!"

@app.route("/sample_post", methods=["POST","GET"])
def sample_post():
    if request.method == 'POST':
        #request_form = request.form['attribute']
        requests_json = request.get_json()
        
        msg = f"Payload received: {requests_json}"
        print(f'[ INFO ] {msg}')
        return msg

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
