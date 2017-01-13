require 'rails_helper'

describe Nodes::Stop do

  describe '.create' do

    context 'with valid attributes' do

      before :each do
        @stop = Nodes::Stop.create(
          stop_id: 2,
          name: 'Siasconset',
          lat: 41.261660,
          lon: -69.963512,
          location_type: 0,
          wheelchair_boarding: 0
        )
      end

      it 'persists' do
        expect(@stop).to be_persisted
      end

    end

    context 'attributes are not valid' do

      before :each do
        @stop = Nodes::Stop.create(
          stop_id: '1dfsdf',
          name: 'Siasconset',
          lon: -69.963512,
          wheelchair_boarding: 9,
          location_type: 'F'
        )
      end

      it 'does not persist' do
        expect(@stop).not_to be_persisted
      end

      it 'has relevant error messages' do
        expect(@stop.errors.messages).to eq(
          {
            lat: ["can't be blank"],
            wheelchair_boarding: ["is not included in the list"]
          }
        )
      end

      it 'assigns optional properties(and uuid) nil' do
        optional_properties = [
          :uuid, :code, :created_at, :desc, :lat, :parent_station,
          :timezone, :updated_at, :url, :zone_id
        ]
        optional_properties.each do |property|
          expect(@stop.attributes[property]).to eq(nil)
        end
      end

    end

  end
end
