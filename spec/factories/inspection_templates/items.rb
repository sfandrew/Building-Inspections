FactoryGirl.define do
  factory :inspection_template_item, :class => InspectionTemplate::Item do
    type ""
    section "SectionName"
    weight "10.0"
    name "template name"
    sequence(:position)
    score_type "PassFail"
    inspection_template { FactoryGirl.create(:inspection_template) }
  end

end
