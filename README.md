# Commute Calculator Api

A REST api designed to parse and transverse a public transportation graph and make recommendations on where a person or group of people should live based on supplied parameters. This api will back a commute calculator ui that will supply to the user geometrical definitions of areas of the a city based on various parameters that the user inputs.

## Up and Running

Make sure you have:
* Ruby version: `2.3.1`

* Rails version: `5`

* Database: `Postgresql`

* Database initialization:
  `$ rake db:create`
  `$ rake db:migrate`

* Run the server with: `rails s` and navigate to `http://localhost:3001`
(The default port is set to 3001 so that a second server can be easily run alongside the api using rails defaults)

* Run the tests with: `rspec spec`

# Other Tech

GTFS

GeoJSON

Docker

React based ui (separate repo)

## Services

* Services (job queues, cache servers, search engines, etc.) TBD
