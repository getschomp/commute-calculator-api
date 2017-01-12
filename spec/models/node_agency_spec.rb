require 'rails_helper'

describe Nodes::Agency do
  describe '.create' do
    it 'persists a user with valid attributes' do
      agency = Nodes::Agency.create(
        name: 'Trans-Siberian', url: 'www.ts.com', timezone: 'OMST')

      expect(agency).to be_persisted
    end

    it 'does not persist if attributes are not valid' do
      agency = Nodes::Agency.create

      expect(agency).not_to be_persisted
      expect(agency.errors[:name]).to include("can't be blank")
    end
  end
end
