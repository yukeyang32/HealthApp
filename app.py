from db import db
from flask import Flask, request
from db import Activity
import json




app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True


sample_acivities = {"Swimming":590, "Jogging":390, "Badminton":135, "Bowling": 90}

def create_activities():
	for k,v in sample_acivities.items():
		new_activity = Activity(
				name = k,
				cal_per_hour = v
			)
		print("here")
		db.session.add(new_activity)
	db.session.commit()

db.init_app(app)
with app.app_context():
    db.create_all()
    create_activities()






def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

@app.route("/")


## get all activities
@app.route("/api/activities/", methods=["GET"])
def get_activities():
    activities = [act.serialize() for act in Activity.query.all()]
    return success_response(activities)



@app.route("/api/activities/<int:user_id>/<int:weekday>/",methods=["GET"])
def get_activities_user(user_id,weekday):
	act_user = UserActivity.query.filter_by(user_id == user_id).filter_by(timestamp == weekday).all()


if __name__ == "__main__":
	app.run(host="0.0.0.0", port=5000, debug=True)
