FactoryGirl.define do
  factory :inspection_template_item, :class => InspectionTemplate::Item do
    type ""
    section "MyString"
    weight "9.99"
    name "template name"
    sequence(:position)
    inspection_template { FactoryGirl.create(:inspection_template) }
  end

end