FactoryGirl.define do
  factory :inspection_template do
    unit { FactoryGirl.create(:unit) }

    factory :inspection_template_with_items do
        ignore do
          items_count 2
        end
        
        after(:create) do |inspection_template, evaluator|
          create_list(:inspection_template_item, evaluator.items_count, inspection_template: inspection_template)
        end
    end
  end

end
