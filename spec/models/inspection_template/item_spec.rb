require 'rails_helper'

RSpec.describe InspectionTemplate::Item, type: :model do
  it "has a valid factory" do
  	expect(FactoryGirl.create(:inspection_template_item)).to be_valid
  end

  it "is invalid without an inspection template" do
  	expect(FactoryGirl.build(:inspection_template_item, inspection_template: nil)).not_to be_valid
  end

  it "is invalid without an item order" do
  	expect(FactoryGirl.build(:inspection_template_item, item_order: nil)).not_to be_valid
  end

  it "is invalid without a section" do
  	expect(FactoryGirl.build(:inspection_template_item, section: nil)).not_to be_valid
  end

  it "should have unique order number within same template" do
    template = FactoryGirl.create(:inspection_template_with_items, items_count: 5)
    expect(template.items.pluck(:item_order).uniq.length).to eq(template.items.length)
  end
end
