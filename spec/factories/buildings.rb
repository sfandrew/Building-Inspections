FactoryGirl.define do
  factory :building do |f|
    f.name { Faker::App.name }
    f.address_line_1 { Faker::Address.street_address }
    f.zip { Faker::Address.zip }
    f.city { Faker::Address.city }
    f.state { Faker::Address.state }
  end

  factory :invalid_building, parent: :building do |f|
    f.name { nil }
  end
end