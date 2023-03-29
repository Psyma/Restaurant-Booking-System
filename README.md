# Restaurant Booking System 
```
A simple booking system using Ruby on Rails  
```
# QUICK START
* Run bundle install
* Run rails db:migrate
* Run rails db:seed

# ENVIRONMENT VARIABLE
Createa an .env file in the root directory and edit.

* SECRET_KEY_BASE: # use rake secret and paste it value
* GOOGLE_ID:
* GOOGLE_SECRET:
* FACEBOOK_ID:
* FACEBOOK_SECRET:
* TWITTER_ID:
* TWITTER_SECRET:
* LINKEDIN_ID:
* LINKEDIN_SECRET:
* SENDMAIL_USERNAME: # you can use gmail app
* SENDMAIL_PASSWORD: # you can use gmail app
* MAIL_HOST: '0.0.0.0:3000'
* RAILS_ENV=production
* POSTGRES_HOST=restoran-postgres
* POSTGRES_DB=restoran
* POSTGRES_USER=username
* POSTGRES_PASSWORD=password
* RAILS_MASTER_KEY= # use rake secret and paste it value

# DEPLOY USING DOCKER
If you want to deploy it on docker follow the steps below.

* Change the config/database-docker.yml into database.yml
* docker compose build && docker compose up
* docker compose run restoran-web rake db:migrate
* docker compose run restoran-web rake db:seed
