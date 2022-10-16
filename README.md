# Desafio Backend

## Stack
- Ruby 2.7.5
- Ruby on Rails 6
- Postgres 11
- Redis 5.0.2 (not really used currently)

## Run everything using Docker

The configuration of this project is correct assuming you will run everything using Docker.  If you want to run not within Docker see [Run Service Directly](#run-service-directly).

### Confirm that services are running

```
$ docker-compose ps
Name                        Command                           State           Ports         
--------------------------------------------------------------------------------------------
desafio-backend_web_1       bundle exec rails s -b 0.0.0.0    Up (healthy)    0.0.0.0:3000->3000/tcp
desafio-backend_postgres_1  docker-entrypoint.sh postgres     Up (healthy)    0.0.0.0:5432->5432/tcp
desafio-backend_test_1      bundle exec rspec spec            Exit 1
desafio-backend_redis_1     docker-entrypoint.sh redis ...    Up (healthy)    0.0.0.0:6381->6379/tcp
```

You should see output similar to the above.  Notice the port mappings for services such as "postgres" and "web".

### Set up the DB

The first time you run this project, you'll need to set up the database first:

```shell script
# create database, run migrations, and seed
docker-compose exec web bundle exec rake db:create

# run migrations
docker-compose exec web bundle exec rake db:migrate

# create default user
docker-compose exec web bundle exec rake db:seed
```

It's necessary to run the seed command in order to create the user necessary for uploading the csv file
- email: admin@email.com
- password: test@123456

### Confirm Rails landing page

- Go to http://localhost:3000/ (Make sure that the port matchs the port mapped in the "docker-compose ps" output from the previous step.)

## Run Service Directly

If you want to run the backend-challenge service directly on your computer and not within a Docker container you'll need to do the following.  Note that it's still convenient to run postgres and redis within docker.

- Install necessary prerequisites - PostgreSQL client library
  ```shell script
  brew install postgres
  bundle install
  ```
- Update database.yml to point to the postgres instance in the Docker container.
  ```
  development:
    <<: *default
    host: '127.0.0.1'
    port: 5432
    username: postgres
    database: desafio_backend_development
  ```

## Run lint and autocorrect offenses
```shell script
bundle exec rubocop -a
```
[Lint configuration](.rubocop.yml)

## Common Commands
```shell script
# install gems
bundle install

# start console
docker-compose exec web rails console

# create database, run migrations, and seed
docker-compose exec web bundle exec rake db:create

# run migrations
docker-compose exec web bundle exec rake db:migrate

# run migrations in TEST env
docker-compose run -e "RAILS_ENV=test" web bundle exec rake db:migrate

# run tests
docker-compose run -e "RAILS_ENV=test" web rspec
docker-compose exec web bundle exec rspec

# run schema:load
docker-compose exec web bundle exec rake db:schema:load

# seed dev database
docker-compose exec web bundle exec rake db:seed
```

## Load CSV files

You can load the CSV files whether by accessing the [Upload csv page]('http://localhost:3000/deputies/new') page and selecting the desired file or by running the task sync:csv

```
docker-compose exec web bundle exec rake sync:csv
```

If you want to upload the file within the system, make sure you have followed [these instructions](#set-up-the-db) about creating the default user, and that you are logged in 

There is [This file](/lib/tasks/seed/seed_files/csv/ano-2021.csv) that contains the data to be loaded. You can use it if you will

## Code coverage

I am using the SimpleCov tool to generate code coverage reports. After running the tests, open `coverage/index.html` in the browser.

You can open the reports running, in the terminal

Mac
```
open coverage/index.html
```

in a debian/ubuntu Terminal,
```
xdg-open coverage/index.html
```

For more information, see the documentation at [SimpleConv](https://github.com/simplecov-ruby/simplecov)

## License
[MIT](https://choosealicense.com/licenses/mit/)
