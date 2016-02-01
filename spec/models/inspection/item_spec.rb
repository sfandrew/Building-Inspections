require 'rails_helper'

RSpec.describe Inspection::Item, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:inspection_item)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:inspection_item, name: nil)).not_to be_valid
  end

  it "is invalid without a weight" do
    expect(FactoryGirl.build(:inspection_item, weight: nil)).not_to be_valid
  end

  it "is invalid without a section" do
    expect(FactoryGirl.build(:inspection_item, section: nil)).not_to be_valid
  end

  it "is invalid without a position" do
    expect(FactoryGirl.build(:inspection_item, position: nil)).not_to be_valid
  end  

  it "is invalid without a inspection" do
    expect(FactoryGirl.build(:inspection_item, inspection: nil)).not_to be_valid      
  end

  it "is built correctly from an inspection template item" do
    template_item = FactoryGirl.create(:inspection_template_item,
      section: "template_section",
      weight: 15.55,
      item_order: 4)
    inspection_item = Inspection::Item.build_from_template_item(template_item)
    expect(inspection_item.matches_template_item?(template_item)).to be true
  end
end
