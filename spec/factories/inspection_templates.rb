FactoryGirl.define do
  factory :inspection_template do
    unit { FactoryGirl.create(:unit) }
  end

end
