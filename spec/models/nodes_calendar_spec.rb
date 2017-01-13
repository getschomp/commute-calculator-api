require 'rails_helper'

describe Nodes::Calendar do
  describe '.create' do

    context 'with valid attributes' do

      before :each do
        @calendar = Nodes::Calendar.create(
          service_id: 20,
          monday: 0,
          tuesday: 1,
          wednesday: 0,
          thursday: 1,
          friday: 1,
          saturday: 0,
          sunday: 1,
          start_date: '20170101',
          end_date: '20171208'
        )
      end

      it 'persists' do
        expect(@calendar).to be_persisted
      end

    end

    context 'attributes are not valid' do

      before :each do
        @calendar = Nodes::Calendar.create(
          service_id: 20,
          monday: 0,
          tuesday: 1,
          wednesday: 0,
          saturday: 9,
          sunday: 1,
          start_date: '20170101',
          end_date: '20171208754'
        )
      end

      it 'does not persist' do
        expect(@calendar).not_to be_persisted
      end

      it 'has relevant error messages' do
        expect(@calendar.errors.messages).to eq(
          thursday: ["can't be blank", "is not included in the list"],
          friday: ["can't be blank", "is not included in the list"],
          saturday: ["is not included in the list"],
          end_date: ["is the wrong length (should be 8 characters)"]
        )
      end

    end

  end
end
