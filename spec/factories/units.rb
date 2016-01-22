FactoryGirl.define do
  factory :unit do
    building { FactoryGirl.create(:building) }
    unit_number { Faker::Address::secondary_address }
  end

end
