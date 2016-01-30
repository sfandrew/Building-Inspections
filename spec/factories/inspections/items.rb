FactoryGirl.define do
  factory :inspection_item, class: Inspection::Item do
    name "fake_item_name"
    weight "5"
    position 1
    section "FakeSection"
    score "4"
    inspection { FactoryGirl.create(:inspection) }
  end

end
