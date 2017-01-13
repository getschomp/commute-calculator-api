module Nodes
  class Stop
    include Neo4j::ActiveNode

    property :stop_id, type: Integer
    property :code, type: String
    property :name, type: String
    property :desc, type: String
    property :lat, type: Float
    property :lon, type: Float
    property :zone_id, type: Integer
    property :url, type: String
    property :location_type, type: Float
    property :parent_station, type: String
    property :timezone, type: String
    property :wheelchair_boarding, type: Integer

    property :created_at
    property :updated_at

    validates :stop_id, presence: true
    validates :name, presence: true
    validates :lat, presence: true
    validates :lon, presence: true
    validates :location_type, inclusion: { in: 0..1}
    validates :wheelchair_boarding, inclusion: { in: 0..2}
  end
end
