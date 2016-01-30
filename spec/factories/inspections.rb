FactoryGirl.define do
  factory :inspection do
    description "inspection description text"
    unit { FactoryGirl.create(:unit) }
    template { FactoryGirl.create(:inspection_template_with_items, items_count: 5) }

    factory :inspection_with_items do
        transient do
          items_count 2
        end
        
        after(:create) do |inspection, evaluator|
          create_list(:inspection_item, evaluator.items_count, inspection: inspection)
        end
    end
  end

end
