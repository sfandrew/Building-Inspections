require 'rails_helper'

RSpec.describe Building, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:building)).to be_valid
  end

  it "is invalid without name" do
    expect(FactoryGirl.build(:building, name: nil)).not_to be_valid
  end

  it "is invalid without address line 1" do 
    expect(FactoryGirl.build(:building, address_line_1: nil)).not_to be_valid    
  end

  it "is invalid without zip" do
    expect(FactoryGirl.build(:building, zip: nil)).not_to be_valid    
  end

  it "is invalid without city" do
    expect(FactoryGirl.build(:building, city: nil)).not_to be_valid    
  end

  it "is invalid without state" do
    expect(FactoryGirl.build(:building, state: nil)).not_to be_valid    
  end
end
