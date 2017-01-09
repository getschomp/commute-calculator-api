module Nodes
  class Agency
    include Neo4j::ActiveNode

    property :agency_id, type: Integer
    property :name, type: String
    property :url, type: String
    property :timezone, type: String
    property :lang, type: String
    property :phone, type: String

    property :created_at
    property :updated_at

    validates :name, presence: true
    validates :url, presence: true
    validates :timezone, presence: true
  end
end
