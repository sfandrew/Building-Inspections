require 'rails_helper'

RSpec.describe InspectionTemplate, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:inspection_template)).to be_valid
  end

  it "is invalid without a unit" do
    expect(FactoryGirl.build(:inspection_template, unit: nil)).not_to be_valid
  end

end
