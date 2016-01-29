require 'rails_helper'

RSpec.describe Inspection, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:inspection)).to be_valid
  end

  it "is invalid without a unit" do
  	expect(FactoryGirl.build(:inspection, unit: nil)).not_to be_valid
  end

  it "is invalid without items" do 
  	expect(FactoryGirl.build(:inspection, inspection_items: [])).not_to be_valid
  end

  it "is invalid when created without a template" do
  	expect(FactoryGirl.build(:inspection, template: nil)).not_to be_valid
  end

  it "is valid on update without a template" do
  	inspection = FactoryGirl.create(:inspection)
  	inspection.template = nil
  	expect(inspection).to be_valid
  end

end
