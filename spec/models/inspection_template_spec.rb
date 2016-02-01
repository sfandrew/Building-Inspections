require 'rails_helper'

RSpec.describe InspectionTemplate, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:inspection_template)).to be_valid
  end

  it "has a factory to create with multiple items" do
    expect(FactoryGirl.create(:inspection_template_with_items, items_count: 5).items.length).to eq(5)
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:inspection_template, name: nil)).not_to be_valid
  end

  it "is valid without a unit" do
    expect(FactoryGirl.build(:inspection_template, unit: nil)).to be_valid
  end

  it "gets items in position order" do 
    inspection_template = FactoryGirl.build(:inspection_template)

    FactoryGirl.create(:inspection_template_item, position: 3, inspection_template: inspection_template)
    FactoryGirl.create(:inspection_template_item, position: 1, inspection_template: inspection_template)
    FactoryGirl.create(:inspection_template_item, position: 2, inspection_template: inspection_template)

    positions = inspection_template.items.pluck(:position)
    expect(positions).to eq(positions.sort)
  end

end
