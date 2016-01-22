FactoryGirl.define do
  factory :unit do
    building { FactoryGirl.create(:building) }
    unit_number { Faker::Address::secondary_address }
  end

  factory :invalid_unit, parent: :unit do
    building { FactoryGirl.create(:building) }
    unit_number { nil }
  end

end
