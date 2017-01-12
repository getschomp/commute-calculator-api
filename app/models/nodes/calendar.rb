module Nodes
  class Calendar
    include Neo4j::ActiveNode

    property :service_id, type: Integer
    property :monday, type: Integer
    property :tuesday, type: Integer
    property :wednesday, type: Integer
    property :thursday, type: Integer
    property :friday, type: Integer
    property :saturday, type: Integer
    property :sunday, type: Integer
    property :start_date, type: String
    property :end_date, type: String

    property :created_at
    property :updated_at

    validates :service_id, presence: true
    validates :monday, presence: true, inclusion: { in: 0..1}
    validates :tuesday, presence: true, inclusion: { in: 0..1}
    validates :wednesday, presence: true, inclusion: { in: 0..1}
    validates :thursday, presence: true, inclusion: { in: 0..1}
    validates :friday, presence: true, inclusion: { in: 0..1}
    validates :saturday, presence: true, inclusion: { in: 0..1}
    validates :sunday, presence: true, inclusion: { in: 0..1}
    validates :start_date, presence: true, length: { is: 8 }
    validates :end_date, presence: true, length: { is: 8 }
  end
end
