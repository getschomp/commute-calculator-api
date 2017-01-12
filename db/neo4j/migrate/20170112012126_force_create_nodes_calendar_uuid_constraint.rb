class ForceCreateNodesCalendarUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Nodes::Calendar", :uuid, force: true
  end

  def down
    drop_constraint :"Nodes::Calendar", :uuid
  end
end
