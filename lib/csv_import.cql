LOAD CSV WITH HEADERS FROM "file:/boston/agency.txt" AS agency
CREATE (
  `Nodes::Agency` {
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
CREATE (a)-[:OPERATES]->(
  `Nodes::Route` {
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

LOAD CSV WITH HEADERS FROM "file:/boston/trips.txt" AS trip
CREATE (
  :Trip {

  }
);

LOAD CSV WITH HEADERS FROM "file:/boston/stops.txt" AS stop
CREATE (
  :Stop {
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
