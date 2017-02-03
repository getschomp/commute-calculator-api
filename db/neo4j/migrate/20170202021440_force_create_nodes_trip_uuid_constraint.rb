class ForceCreateNodesTripUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Nodes::Trip", :uuid, force: true
  end

  def down
    drop_constraint :"Nodes::Trip", :uuid
  end
end
