class ForceCreateNodesStopTimeUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Nodes::StopTime", :uuid, force: true
  end

  def down
    drop_constraint :"Nodes::StopTime", :uuid
  end
end
