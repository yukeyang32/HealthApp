# HealthApp
## API Specification

### 1) Create User
User makes account during sign-in, returns user info

### Base Endpoint:https://healtheat.herokuapp.com/

<code>POST</code> /api/users/

Request
```
{
  "name": <USER INPUT>,
  "height": <USER INPUT>,
  "weight": <USER INPUT>,
  "age": <USER INPUT>,
  "gender": <USER INPUT>
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <NAME>,
      "height": <USER INPUT>,
      "weight": <USER INPUT>,
      "age": <USER INPUT>,
      "gender": <USER INPUT>
    }
  ]
}
```

### 2) Get Specific User by ID
Return User Info by correponding ID

<code>GET</code> /api/users/{id}/

Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <USER INPUT>,
      "height": <USER INPUT>,
      "weight": <USER INPUT>,
      "age": <USER INPUT>,
      "gender": <USER INPUT>
    }
  ]
}
```


### 3) Record an Activity
Record an activity

<code>POST</code> /api/activities/

Request
```
{
  "name": <USER INPUT>,
  "calories_per_hour": <USER INPUT>,
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <NAME>,
      "calories_per_hour": <USER INPUT>
    }
  ]
}
```

### 4) Get Specific Activity by ID
Return Activity Info by correponding ID

<code>GET</code> /api/activities/{id}/

Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <NAME>,
      "calories_per_hour": <USER INPUT>
    }
  ]
}
```

### 5) Add Activity to User
Add an activity done by a user

<code>POST</code> /api/activities/{id}/add/

Request
```
{
  "user_id": <USER INPUT>,
  "hours": <USER INPUT>,
  "timestamp": <USER INPUT>
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "activity": <SERIALIZED Activity>
    }
  ]
}
```

### 6) Record a Food
Record a food

<code>POST</code> /api/foods/

Request
```
{
  "name": <USER INPUT>,
  "calories_per_unit": <USER INPUT>,
  "unit": <USER INPUT>
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <Name>,
      "calories_per_unit": <USER INPUT>,
      "unit": <USER INPUT>
    }
  ]
}
```

### 7) Get Specific Food by Name
Return Activity Info by correponding Food

<code>GET</code> /api/foods/{name}/

Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <Name>,
      "calories_per_unit": <USER INPUT>,
      "unit": <USER INPUT>
    }
  ]
}
```

### 8) Add Food to User
Add a food eaten by a user

<code>POST</code> /api/foods/{id}/add/

Request
```
{
  "user_id": <USER INPUT>,
  "amount": <USER INPUT>,
  "year": <USER INPUT>,
  "month": <USER INPUT>,
  "day": <USER INPUT>
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "food": <SERIALIZED Food>
    }
  ]
}
```

### 9) Create a Suggestion Plan
Record a suggestion plan

<code>POST</code> /api/suggestions/

Request
```
{
  "name": <USER INPUT>
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "foods": [],
      "total_calories": 0
    }
  ]
}
```

### 10) Get Specific Suggestion by ID
Return Activity Info by correponding ID

<code>GET</code> /api/suggestions/{id}/

Response
```
{
  "success": true,
  "data": [
    {
      "id": <ID>,
      "name": <Name>,
      "total_calories": <USER INPUT>,
      "foods": <SERIALIZED Food>
    }
  ]
}
```

### 11) Add Food to a Suggestion Plan by ID
Make changes to suggestion plan by adding a specific type of food by ID

<code>POST</code> /api/suggestions/{ID}/add/

Request
```
{
  "food_id": <USER INPUT>,
  "calories": <USER INPUT>
}
```
Response
```
{
  "success": true,
  "data": [
    {
      "suggestion": <SERIALIZED Suggestion>
    }
  ]
}
```






