from db import db, User, Food, UserFood, UserActivity
from flask import Flask, request
from db import Activity
import json
import os



app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True


sample_acivities = {"Swimming":590, "Jogging":390, "Badminton":135, "Bowling": 90}
sample_food = {"apple":30, "banana":120, "watermellon": 230}

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

def create_foods():
    for k,v in sample_food.items():
        new_food = Food(
                name = k,
                cal_per_unit = v,
                unit = "g"
            )
        db.session.add(new_food)
    db.session.commit()


db.init_app(app)
with app.app_context():
    db.create_all()
    create_users()
    create_activities()
    create_foods()






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


@app.route("/api/users/", methods=["GET"])
def get_users():
    users = [user.serialize() for user in User.query.all()]
    return success_response(users)


@app.route("/api/activities/date/<int:user_id>/",methods=["POST"])
def get_activities_user_by_date(user_id):
    print("boday is ok first")
    body = json.loads(request.data)
    print("boday is ok")
    year = body.get('year')
    if year is None:
        return failure_response("year can't be none")
    month = body.get('month')
    day = body.get('day')
    acts = [acts.serialize() for acts in UserActivity.query.filter_by(user_id = user_id).filter_by(year = year).filter_by(month = month).filter_by(day = day).all()]
    return success_response(acts)


@app.route("/api/acts/<string:act_name>/add/",methods = ["POST"])
def add_act_to_user(act_name):
    act = Activity.query.filter_by(name = act_name).first()
    body = json.loads(request.data)
    user_id = body.get('user_id')
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        user = User(id = user_id,)
    amount = body.get('amount')
    year = body.get('year')
    month = body.get('month')
    day = body.get('day')
    new_user_act = UserActivity(
        user_id = user_id,
        name = act_name,
        year = year,
        month = month,
        day = day,
        amount = amount
    )
    db.session.add(new_user_act)
    db.session.commit()
    return success_response(act.serialize())





### Food API
@app.route("/api/foods/",methods = ["POST"])
def create_food():
    body = json.loads(request.data)
    if body.get('name') is None:
        return failure_response('Fail to create a food')
    new_food = Food(
        name = body.get('name'),
        cal_per_unit = body.get('calories_per_unit'),
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
    day = body.get('day')
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


@app.route("/api/food/date/<int:user_id>/",methods=["POST"])
def get_food_user_by_date(user_id):
    body = json.loads(request.data)
    year = body.get('year')
    if year is None:
        return failure_response("year can't be none")
    month = body.get('month')
    day = body.get('day')
    foods = [foods.serialize() for foods in UserFood.query.filter_by(user_id = user_id).filter_by(year = year).filter_by(month = month).filter_by(day = day).all()]
    return success_response(foods)




if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
