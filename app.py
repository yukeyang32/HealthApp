from db import db
from flask import Flask, request
from db import Activity
import json




app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

@app.route("/")


## get all activities
@app.route("/api/activities/", methods=["GET"])
def get_activities():
    activities = [act.serialize() for act in Activity.query.all()]
    return success_response(courses)



@app.route("/api/activities/<int:user_id>/<int:weekday>/",methods=["GET"])
def get_activities_user(user_id,weekday):
	act_user = UserActivity.query.filter_by(user_id == user_id).filter_by(timestamp == weekday).all()
	




