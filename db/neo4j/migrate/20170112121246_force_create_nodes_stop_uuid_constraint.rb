class ForceCreateNodesStopUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Nodes::Stop", :uuid, force: true
  end

  def down
    drop_constraint :"Nodes::Stop", :uuid
  end
end
