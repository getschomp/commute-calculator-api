class ForceCreateNodesAgencyUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Nodes::Agency", :uuid, force: true
  end

  def down
    drop_constraint :"Nodes::Agency", :uuid
  end
end
