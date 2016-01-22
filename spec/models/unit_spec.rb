require 'rails_helper'

RSpec.describe Unit, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:unit)).to be_valid
  end

  it "is invalid without unit number" do
    expect(FactoryGirl.build(:unit, unit_number: nil)).not_to be_valid
  end

  it "is invalid without a building" do
    expect(FactoryGirl.build(:unit, building: nil)).not_to be_valid
  end

end
