LOAD CSV WITH HEADERS FROM "file:/boston/stops.txt" AS stop
CREATE (
  :Stop {
    stop_id: stop.stop_id, code: stop.stop_code, name: stop.stop_name,
    desc: stop.stop_desc, lat: stop.stop_lat, lon: stop.stop_lon,
    zone_id: stop.zone_id, url: stop.stop_url, location_type: stop.location_type,
    parent_station: stop.parent_station, wheelchair_boarding: stop.wheelchair_boarding
  }
);

LOAD CSV WITH HEADERS FROM "file:/boston/agency.txt" AS stop
CREATE (
  :Stop {
    stop_id: stop.stop_id, code: stop.stop_code, name: stop.stop_name,
    desc: stop.stop_desc, lat: stop.stop_lat, lon: stop.stop_lon,
    zone_id: stop.zone_id, url: stop.stop_url, location_type: stop.location_type,
    parent_station: stop.parent_station, wheelchair_boarding: stop.wheelchair_boarding
  }
);
