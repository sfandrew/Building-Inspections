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

  it "gets items in item_order" do 
    inspection_template = FactoryGirl.build(:inspection_template)

    FactoryGirl.create(:inspection_template_item, item_order: 3, inspection_template: inspection_template)
    FactoryGirl.create(:inspection_template_item, item_order: 1, inspection_template: inspection_template)
    FactoryGirl.create(:inspection_template_item, item_order: 2, inspection_template: inspection_template)

    item_orders = inspection_template.items.pluck(:item_order)
    expect(item_orders).to eq(item_orders.sort)
  end

end
