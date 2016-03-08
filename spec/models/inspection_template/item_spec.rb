require 'rails_helper'

RSpec.describe InspectionTemplate::Item, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:inspection_template_item)).to be_valid
  end

  it "is invalid without an inspection template" do
    expect(FactoryGirl.build(:inspection_template_item, inspection_template: nil)).not_to be_valid
  end

  it "is invalid without a position" do
    expect(FactoryGirl.build(:inspection_template_item, position: nil)).not_to be_valid
  end

  it "is invalid without a section" do
    expect(FactoryGirl.build(:inspection_template_item, section: nil)).not_to be_valid
  end

  it "is invalid without a name" do 
    expect(FactoryGirl.build(:inspection_template_item, name: nil)).not_to be_valid
  end

  it "is invalid without a weight" do
    expect(FactoryGirl.build(:inspection_template_item, weight: nil)).not_to be_valid
  end

  it "is invalid without a scoring type" do
    expect(FactoryGirl.build(:inspection_template_item, score_type: nil)).not_to be_valid
  end

  it "should have unique order number within same template" do
    template = FactoryGirl.create(:inspection_template_with_items, items_count: 5)
    expect(template.items.pluck(:position).uniq.length).to eq(template.items.length)
  end
end
