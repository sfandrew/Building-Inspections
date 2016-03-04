FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "FakeName#{n}"
    end
    sequence :email do |n|
      "FakeEmail#{n}@example.com"
    end
    role { Role.find_by_name "Regular" }

    password "password"
    password_confirmation "password"

    factory :admin do 
      role { Role.find_by_name "Admin" }
    end
  end

end
