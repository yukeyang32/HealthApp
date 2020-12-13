from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


association_food_suggestion_table = db.Table(
    'food_suggestion_association',
    db.Model.metadata,
    db.Column('food_id',db.Integer,db.ForeignKey('food.id')),
    db.Column('suggestion_id',db.Integer,db.ForeignKey('suggestion.id'))
)

class User(db.Model):
    __table__name = 'user'
    id = db.Column(db.Integer,primary_key = True)
    name = db.Column(db.String, nullable = False)
    height = db.Column(db.Integer, nullable = False)
    weight = db.Column(db.Integer, nullable = False)
    age = db.Column(db.Integer, nullable = False)
    # gender: male(True), female (False)
    gender = db.Column(db.Boolean, default = False, nullable = False)

    def __init__(self,**kwargs):
        self.name = kwargs.get('name','')
        self.height = kwargs.get('height',0)
        self.weight = kwargs.get('weight',0)
        self.age = kwargs.get('age',0)
        self.gender = kwargs.get('gender',False)
    
    def serialize(self):
        return{
            'id': self.id,
            'name': self.name,
            'height': self.height,
            'weight': self.weight,
            'gender': self.gender
        }

class Calories(db.Model):
    __table__name = 'calories'
    id = db.Column(db.Integer,primary_key = True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'),nullable = False)
    calories = db.Column(db.Integer, nullable = False)
    year = db.Column(db.Integer,nullable = False)
    month = db.Column(db.Integer,nullable = False)
    day = db.Column(db.Integer,nullable = False)

    def __init__(self,**kwargs):
        self.user_id = kwargs.get('user_id')
        self.calories = kwargs.get('calories',0)
        self.year = kwargs.get('year',2020)
        self.month = kwargs.get('month',1)
        self.day = kwargs.get('day',1)

    def serialize(self):
        return{
            'id': self.id,
            'user_id' : self.user_id,
            'calories': self.calories,
            'year': self.year,
            'month': self.month,
            'day': self.day,
        }

class UserActivity(db.Model):
    __table__name = 'userActivity'
    id = db.Column(db.Integer,primary_key = True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'),nullable = False)
    activity_id = db.Column(db.Integer, db.ForeignKey('activity.id'),nullable = False)
    name = db.Column(db.String, nullable = False)
    year = db.Column(db.Integer,nullable = False)
    month = db.Column(db.Integer,nullable = False)
    day = db.Column(db.Integer,nullable = False)
    hours = db.Column(db.Integer, nullable = False)

    def __init__(self,**kwargs):
        self.user_id = kwargs.get('user_id')
        self.activity_id = kwargs.get('activity_id')
        self.name = kwargs.get('name','')
        self.year = kwargs.get('year',2020)
        self.month = kwargs.get('month',1)
        self.day = kwargs.get('day',1)
        self.hours = kwargs.get('hours',0)

    def serialize(self):
        return{
            'id': self.id,
            'user_id' : self.user_id,
            'activity_id' : self.activity_id,
            'name': self.name,
            'year': self.year,
            'month': self.month,
            'day': self.day,
            'hours': self.hours
        }

class Activity(db.Model):
    __table__name = 'activity'
    id = db.Column(db.Integer,primary_key = True)
    name = db.Column(db.String, nullable = False)
    cal_per_hour = db.Column(db.Integer,nullable = False)

    def __init__(self,**kwargs):
        self.name = kwargs.get('name','')
        self.cal_per_hour = kwargs.get('cal_per_hour',0)

    def serialize(self):
        return{
            'id' : self.id,
            'name': self.name,
            'cal': self.cal_per_hour
        }

class UserFood(db.Model):
    __table__name = 'userFood'
    id = db.Column(db.Integer,primary_key = True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'),nullable = False)
    food_id = db.Column(db.Integer, db.ForeignKey('food.id'),nullable = False)
    name = db.Column(db.String, nullable = False)
    year = db.Column(db.Integer,nullable = False)
    month = db.Column(db.Integer,nullable = False)
    day = db.Column(db.Integer,nullable = False)
    amount = db.Column(db.Integer, nullable = False)

    def __init__(self,**kwargs):
        self.user_id = kwargs.get('user_id')
        self.food_id = kwargs.get('food_id')
        self.name = kwargs.get('name','')
        self.year = kwargs.get('year',2020)
        self.month = kwargs.get('month',1)
        self.day = kwargs.get('day',1)
        self.amount = kwargs.get('amount',0)

    def serialize(self):
        return{
            'id': self.id,
            'user_id' : self.user_id,
            'food_id' : self.food_id,
            'name': self.name,
            'year': self.year,
            'month': self.month,
            'day': self.day,
            'amount': self.amount
        }


class Food(db.Model):
    __table__name = 'food'
    id = db.Column(db.Integer,primary_key = True)
    name = db.Column(db.String, nullable = False)
    cal_per_unit = db.Column(db.Integer,nullable = False)
    unit = db.Column(db.String, nullable = False)
    suggestions = db.relationship('Suggestion', secondary = association_food_suggestion_table, back_populates = 'foods')

    def __init__(self,**kwargs):
        self.name = kwargs.get('name','')
        self.cal_per_unit= kwargs.get('cal_per_unit',0)

    def serialize(self):
        return{
            'id' : self.id,
            'name': self.name,
            'cal_per_unit': self.cal_per_unit
        }

class Suggestion(db.Model):
    __table__name = 'suggestion'
    id = db.Column(db.Integer,primary_key = True)
    name = db.Column(db.String, nullable = False)
    total_calories = db.Column(db.Integer,nullable = False)
    foods = db.relationship('Food', secondary = association_food_suggestion_table,back_populates = 'suggestions')

    def __init__(self,**kwargs):
        self.name = kwargs.get('name','')
        self.total_calories= kwargs.get('total_calories',0)

    def serialize(self):
        return{
            'suggestion_id' : self.id,
            'name': self.name,
            'total_calories': self.total_calories,
            'foods': [f.serialize() for f in self.foods]
        }
