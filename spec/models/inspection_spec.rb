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

  it "is invalid without a unit" do
    expect(FactoryGirl.build(:inspection, building: nil)).not_to be_valid
  end

  it "is invalid when created without a template" do
  	expect(FactoryGirl.build(:inspection, template: nil)).not_to be_valid
  end

  it "is invalid when created from a template with no items" do
    template = FactoryGirl.create(:inspection_template_with_items, items_count: 0)
    expect(FactoryGirl.build(:inspection, template: template)).not_to be_valid
  end

  it "is valid on update without a template" do
  	inspection = FactoryGirl.create(:inspection)
  	inspection.template = nil
  	expect(inspection).to be_valid
  end

  it "has a persisted ordered list of unique sections" do
    inspection = FactoryGirl.create(:inspection)
    inspection.sections = ["first", "second"]
    inspection.sections << "third"
    inspection.save!
    inspection = Inspection.find(inspection.id)
    expect(inspection.sections).to eq(["first", "second", "third"])
    inspection.sections << "third"
    expect(inspection).not_to be_valid
  end

  it "gets its items in position order" do
    inspection = FactoryGirl.build(:inspection_with_items, items_count: 5)

    FactoryGirl.create(:inspection_item, position: 3, inspection: inspection)
    FactoryGirl.create(:inspection_item, position: 1, inspection: inspection)
    FactoryGirl.create(:inspection_item, position: 2, inspection: inspection)

    positions = inspection.items.pluck(:position)
    expect(positions).to eq(positions.sort)
  end

  describe "when creating from a template which has items" do
    let (:template) {
      FactoryGirl.create(:inspection_template_with_items, items_count: 5)
    }
    let (:inspection) {
      FactoryGirl.create(:inspection, template: template)
    }

    it "has the correct number of items" do 
      expect(inspection.items.length).to eq(template.items.length)
    end

    it "items created from the template match the template's items" do
      inspection.items.each_with_index do |inspection_item, index|
        expect(inspection_item.matches_template_item?(template.items[index])).to be true
      end
    end

    it "has ordered sections which match the template" do
      template.sections = ["S1", "S2"]
      template.save!

      expect(inspection.sections).to eq(["S1", "S2"])
    end
  end

  it "has a method to update associated items" do
    inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 2)

    inspection = FactoryGirl.create(:inspection, template: inspection_template)

    inspection.update(items_attributes: [{
      id: inspection.items[0].id,
      raw_score: 5
      }])

    inspection.save!

    expect(inspection.items.count).to eq(2)
    expect(inspection.items[0].raw_score.to_i).to eq(5)
    expect(inspection.items[1].raw_score).to eq(nil)
  end

end
