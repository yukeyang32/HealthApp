# HealthApp
## API Specification

### 1) Create User
User makes account during sign-in, returns user info

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
Return User Infro by correponding ID

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
