# geolcation-rest-sample

## How to run

**1. Setup DB**
```bash
docker compose run --rm api bundle exec rails db:setup
```

Seeder insert some records into users and geolocation table.

**2. Set IPSTACK_API_KEY**

This api needs [ipstack](https://ipstack.com/) api key. 
Set IPSTACK_API_KEY in .env

```
echo "IPSTACK_API_KEY=[ your api key ]" > .env
```

**2. Run docker compose up**

```bash
docker compose up
```

**3. Access the application at http://localhost:3000/api/v1**

**4. Try following endpoints with JWT token.**

| path | method | body |
| --- | --- | -- | 
| /api/v1/geolocations | GET | - |
| /api/v1/geolocations | POST | { "geolocation": { "ip_or_hostname": [ip_or_hostname] } } |
| /api/v1/geolocations/:id | GET | - |
| /api/v1/geolocations/:id | DELETE | - |

You can request them by setting the token generated in console like below in `Authorization` header.

```bash
 % docker compose run --rm api bundle exec rails c
Loading development environment (Rails 7.2.1)
api(dev)> Auth::Jwt.encode('jack@example.com') # this address is user's one for testing (the user has some geolocation records initially).
api(dev)>
=> "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYWNrQGV4YW1wbGUuY29tIn0.DCTJPCYsspY4Ry3PtPR2qr5R7vEPh32APjhK5ZuqbJc"
```
## Commands

### Test

```bash
docker compose run --rm -e RAILS_ENV=test api bundle exec rspec
```

### Connect api container

```bash
docker exec -it geolocation-rest-sample-api-1 bash
```
