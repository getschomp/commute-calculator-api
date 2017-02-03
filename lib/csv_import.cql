// model validations may not be enforced when inserting through raw cypher.
// The neo4j ORM does not support the load csv command.

LOAD CSV WITH HEADERS FROM "file:/boston/agency.txt" AS agency
CREATE (
  a:`Nodes::Agency` {
    agency_id: agency.agency_id,
    name: agency.agency_name,
    url: agency.agency_url,
    timezone: agency.agency_timezone,
    lang: agency.lang,
    lon: agency.stop_lon,
    phone: agency.agency_phone,
    fare_url: agency.fare_url,
    email: agency.email
  }
);

LOAD CSV WITH HEADERS FROM "file:/boston/routes.txt" AS route
MATCH (a:`Nodes::Agency` {agency_id: route.agency_id})
CREATE (a)-[:operates]->(
  r:`Nodes::Route` {
    route_id: route.route_id,
    agency_id: route.agency_id,
    short_name: route.short_name,
    long_name: route.route_long_name,
    desc: route.route_desc,
    type: route.route_type,
    url: route.url,
    color: route.route_color,
    text_color: route.route_text_color
  }
);

MATCH (a:`Nodes::Agency`)-[:OPERATES]->(r:`Nodes::Route`) RETURN * LIMIT 100

LOAD CSV WITH HEADERS FROM "file:/boston/trips.txt" AS trip
MATCH (r:`Nodes::Route` {route_id: trip.route_id})
CREATE (r)<-[:follows]-(
  t:`Nodes::Trip` {
    route_id: trip.route_id,
    service_id: trip.service_id,
    trip_id: trip.trip_id,
    headsign: trip.trip_headsign,
    short_name: trip.trip_short_name,
    direction_id: trip.direction_id,
    block_id: trip.block_id,
    shape_id: trip.shape_id,
    wheelchair_accessible: trip.wheelchair_accessible,
    bikes_allowed: trip.bikes_allowed
  }
);

LOAD CSV WITH HEADERS FROM "file:/boston/stops.txt" AS stop
CREATE (
  s:`Nodes::Stop` {
    stop_id: stop.stop_id,
    code: stop.stop_code,
    name: stop.stop_name,
    desc: stop.stop_desc,
    lat: stop.stop_lat,
    lon: stop.stop_lon,
    zone_id: stop.zone_id,
    url: stop.stop_url,
    location_type: stop.location_type,
    parent_station: stop.parent_station,
    wheelchair_boarding: stop.wheelchair_boarding
  }
);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM 'file:/boston/stop_times.txt' as stop_time
MATCH
  (t:`Nodes::Trip` {trip_id: stop_time.trip_id}),
  (s:`Nodes::Stop` {stop_id: stop_time.stop_id})
CREATE (t)<-[:part_of]-(
  st:`Nodes::StopTime` {
    trip_id: stop_time.trip_id,
    arrival_time: stop_time.arrival_time,
    departure_time: stop_time.departure_time,
    stop_sequence: stop_time.stop_sequence,
    stop_id: stop_time.stop_id,
    stop_headsign: stop_time.stop_id,
    pickup_type: stop_time.pickup_type,
    drop_off_type: stop_time.drop_off_type,
    shape_dist_traveled: stop_time.shape_dist_traveled,
    timepoint: stop_time.timepoint
  }
)-[:located_at]->(s);
