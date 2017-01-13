require 'rails_helper'

describe Nodes::Agency do
  describe '.create' do

    context 'with valid attributes' do

      before :each do
        @agency = Nodes::Agency.create(
          name: 'Trans-Siberian', url: 'www.ts.com', timezone: 'OMST'
        )
      end

      it 'persists' do
        expect(@agency).to be_persisted
      end

    end

    context 'without valid attributes' do

      let (:agency) { agency = Nodes::Agency.create }

      it 'does not persist' do
        agency = Nodes::Agency.create
      end

      it 'has expected errors' do
        expect(agency.errors[:name]).to include("can't be blank")
      end

    end

  end
end
