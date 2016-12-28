require 'rails_helper'

RSpec.describe "neo4j config" do
  it "creates a neo4j session" do
    expect { Neo4j::ActiveBase.current_session } .to_not raise_error
  end
end
