require 'rails_helper'

describe Nodes::Calendar do
  describe '.create' do
    it 'persists a user with valid attributes' do
      calendar = Nodes::Calendar.create(
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

      expect(calendar).to be_persisted
    end

    it 'does not persist if attributes are not valid' do
      calendar = Nodes::Calendar.create(
      service_id: 20,
      monday: 0,
      tuesday: 1,
      wednesday: 0,
      saturday: 9,
      sunday: 1,
      start_date: '20170101',
      end_date: '20171208754'
    )

      expect(calendar).not_to be_persisted
      expect(calendar.errors.messages).to eq(
        thursday: ["can't be blank", "is not included in the list"],
        friday: ["can't be blank", "is not included in the list"],
        saturday: ["is not included in the list"],
        end_date: ["is the wrong length (should be 8 characters)"]
      )
    end
  end
end
