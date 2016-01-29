FactoryGirl.define do
  factory :inspection do
    description "inspection description text"
    unit { FactoryGirl.create(:unit) }
    template { FactoryGirl.create(:inspection_template_with_items, items_count: 5) }
  end

end
