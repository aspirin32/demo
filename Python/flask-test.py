from flask import Flask
app = Flask(__name__)
@app.route("/<username>", methods=["GET"])
def index(username):
       return "Hello, %s!" % username
if __name__ == "__main__":
       app.run(debug=True)