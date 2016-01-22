FactoryGirl.define do
  factory :building do |f|
    f.name "building1"
    f.address_line_1 "123 Fake st."
    f.zip "90210"
    f.city "Beverly Hills"
    f.state "CA"
  end
end