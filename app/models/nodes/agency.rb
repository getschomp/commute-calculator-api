module Nodes
  class Agency < ApplicationRecord
    include Neo4j::ActiveNode

    property :agency_id, type: Integer
    property :agency_name, type: String
    property :agency_url, type: String
    property :agency_timezone, type: String
    property :agency_lang, type: String
    property :agency_phone, type: String

    property :created_at
    property :updated_at
  end
end
