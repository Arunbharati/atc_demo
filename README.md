# Demo App
#Software required
 * Ruby - 2.7.0
 * Rails - 6.1.3
 * Postgress
 * Redis

###Getting Started

#Installing a Local Server

First things first, you'll need to install Ruby 2.7.0.

```sh
$ rvm install 2.7.0
```

Next, you'll need to make sure that you have PostgreSQL installed.

```sh
$ brew install postgres
```

Next, you'll need to make sure that you have Redis installed.

```sh
$ brew install redis
```

# Checkout the repository by running command on terminal

```sh
$ git clone git@github.com:Arunbharati/atc_demo.git
```
# Run the below Tasks under project directory on terminal

##Change directory
```sh
$ cd atc_demo
```

##Installing Dependencies
```sh
$ bundle install
```

#configuration settings for accessing database
 * Open database.yml file (in config folder)
 # Update following points:
  * database (Database name)
  * username (Database username)
  * password (Database password)

##Creating database
```sh
$ ralis db:create
```
##Restore database from dump file
```sh
$ psql -d atc_demo < schema.sql
```
##add .env file to project directory and update with below environment variables.

  REDIS_URL=redis://127.0.0.1
  RESET_INBOUND_CACHE_TIME=14400
  RESET_OUTBOUND_CACHE_TIME=86400
