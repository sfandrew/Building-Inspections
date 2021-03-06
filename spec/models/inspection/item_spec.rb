require 'rails_helper'

RSpec.describe Inspection::Item, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:inspection_item)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:inspection_item, name: nil)).not_to be_valid
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

  it "is valid without a specified raw score" do
    expect(FactoryGirl.build(:inspection_item, raw_score: nil)).to be_valid      
  end

  it "is built correctly from an inspection template item" do
    template_item = FactoryGirl.create(:inspection_template_item,
      section: "template_section",
      weight: 15.55,
      position: 4)
    inspection_item = Inspection::Item.build_from_template_item(template_item)
    expect(inspection_item.matches_template_item?(template_item)).to be true
  end

  it "has a score object of the proper type" do
    expect(FactoryGirl.create(:inspection_item, score_type: "PassFail").score.type).to eq("PassFail")
  end

  it "updates and persists the score properly" do
    item = FactoryGirl.create(:inspection_item, score_type: "PassFail")
    item.score = "pass"
    item.save!
    item = Inspection::Item.find(item.id)

    expect(item.score.get_score).to eq("pass")
    
    item.score = "fail"
    item.save!
    item = Inspection::Item.find(item.id)
    expect(item.score.get_score).to eq("fail")
  end
end
