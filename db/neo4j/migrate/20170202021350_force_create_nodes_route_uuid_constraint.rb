class ForceCreateNodesRouteUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Nodes::Route", :uuid, force: true
  end

  def down
    drop_constraint :"Nodes::Route", :uuid
  end
end
