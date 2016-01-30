require 'rails_helper'

RSpec.describe Inspection, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:inspection)).to be_valid
  end

  it "has a factory which creates items" do 
    expect(FactoryGirl.create(:inspection_with_items, items_count: 5).items.length).to eq(5)
  end

  it "is invalid without a unit" do
  	expect(FactoryGirl.build(:inspection, unit: nil)).not_to be_valid
  end

  it "is invalid without items" do 
  	skip("check item presence validations after we get items generating from template properly")
    expect(FactoryGirl.build(:inspection, items: [])).not_to be_valid
  end

  it "is invalid when created without a template" do
  	expect(FactoryGirl.build(:inspection, template: nil)).not_to be_valid
  end

  it "is valid on update without a template" do
  	inspection = FactoryGirl.create(:inspection)
  	inspection.template = nil
  	expect(inspection).to be_valid
  end

  it "gets its items in position order" do
    inspection = FactoryGirl.build(:inspection_with_items, items_count: 5)

    FactoryGirl.create(:inspection_item, position: 3, inspection: inspection)
    FactoryGirl.create(:inspection_item, position: 1, inspection: inspection)
    FactoryGirl.create(:inspection_item, position: 2, inspection: inspection)

    positions = inspection.items.pluck(:position)
    expect(positions).to eq(positions.sort)
  end

  it "automatically creates items that match its template when created" do
    skip("Not yet implemented")
    template = FactoryGirl.create(:inspection_template_with_items, items_count: 5)
    inspection = FactoryGirl.create(:inspection, template: template)
    inspection.items.each do |inspection_item|
      #inspection
    end
  end

end
