[![Code Climate](https://codeclimate.com/github/getschomp/commute-calculator-api/badges/gpa.svg)](https://codeclimate.com/github/getschomp/commute-calculator-api)
[![Build Status](https://travis-ci.org/getschomp/commute-calculator-api.svg?branch=master)](https://travis-ci.org/getschomp/commute-calculator-api)
[![Coverage Status](https://coveralls.io/repos/github/getschomp/commute-calculator-api/badge.svg?branch=master)](https://coveralls.io/github/getschomp/commute-calculator-api?branch=master)

# Commute Calculator Api

A REST api designed to parse and transverse a public transportation graph and make recommendations on where a person or group of people should live based on supplied parameters. This api will back a commute calculator ui that will supply to the user geometrical definitions of areas of the a city based on various parameters that the user inputs.

## Planning

https://trello.com/b/kDyDUx2I/commute-calculator-api
ERB diagram to be developed

## Up and Running


### Install

Make sure you have:
* Ruby version: `2.3.1`

* Rails version: `5`

### Database Setup

##### Postgresql

With postgres installed, initialize the database with:
  `$ rake db:create`
  `$ rake db:migrate`

##### neo4j
Since this is a less typical setup, and has a few gotchyas I'll cover it in more detail.
Download the dmg from the neo4j website then
`$ brew install neo4j`

If you are using zsh you should alias rake or put noglob before each neo4j rake task
`alias rake='noglob bundle exec rake'`

Install the databases for each environment into the project
```ruby
rake neo4j:install[community-3.1.0,test]
rake neo4j:install[community-3.1.0,development]
```

Configure and migrate
```ruby
rake neo4j:config[test,7474]
rake neo4j:config[development,7575]
rake neo4j:disable_auth[development]
rake neo4j:disable_auth[test]
rake neo4j:migrate:all
```

Run the Databases
```ruby
rake neo4j:start[test]
rake neo4j:start[development]
```

You should be able to navigate to `http://localhost:7575` or `http://localhost:7474`  in your browser and see a neo4j ui with a display of any data and basic tutorials.

#### Running the api

* Run the server with: `rails s` and navigate to `http://localhost:3001`
(The default port is set to 3001 so that a second server can be easily run alongside the api using rails defaults)

* Run the tests with: `rspec spec` (make sure neo4j and postgres are up and in the proper state)

# Other Tech

GTFS

GeoJSON

React based ui (separate repo)

## Services

* Services (job queues, cache servers, search engines, etc.) TBD
