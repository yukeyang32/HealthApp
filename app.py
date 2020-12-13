from db import db, User, Food, UserFood
from flask import Flask, request
from db import Activity
import json




app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True


sample_acivities = {"Swimming":590, "Jogging":390, "Badminton":135, "Bowling": 90}
sample_users = {"Swimming":590, "Jogging":390, "Badminton":135, "Bowling": 90}

def create_users():
	new_user = User(
			name = "Jack",
			height = 180,
			weight = 80,
			age = 23,
			gender = True
		)
	db.session.add(new_user)
	db.session.commit()

def create_activities():
	for k,v in sample_acivities.items():
		new_activity = Activity(
				name = k,
				cal_per_hour = v
			)
		db.session.add(new_activity)
	db.session.commit()



db.init_app(app)
with app.app_context():
    db.create_all()
    create_users()
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


### Food API
@app.route("/api/foods/",methods = ["POST"])
def create_food():
    body = json.loads(request.data)
    if body.get('name') is None:
        return failure_response('Fail to create a food')
    new_food = Food(
        name = body.get('name'),
        calories_per_unit = body.get('calories_per_unit'),
		unit = body.get('unit')
    )
    db.session.add(new_food)
    db.session.commit()
    return success_response(new_food.serialize(),201)


@app.route("/api/foods/<string:food_name>/")
def get_food_by_name(food_name):
    food = Food.query.filter_by(name = food_name).first()
    if food is None:
        return failure_response('Food not found!')
    return success_response(food.serialize())

@app.route("/api/foods/<string:food_name>/add/",methods = ["POST"])
def add_food_to_user(food_name):
    food = Food.query.filter_by(name = food_name).first()
    body = json.loads(request.data)
    user_id = body.get('user_id')
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        user = User(id = user_id,)
    amount = body.get('amount')
    year = body.get('year')
    month = body.get('month')
    day = body.get('month')
    new_user_food = UserFood(
        user_id = user_id,
        name = food_name,
        year = year,
        month = month,
        day = day,
        amount = amount
    )
    db.session.add(new_user_food)
    db.session.commit()
    return success_response(food.serialize())


if __name__ == "__main__":
	app.run(host="0.0.0.0", port=4000, debug=True)
