require 'rails_helper'

RSpec.describe InspectionTemplate, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.create(:inspection_template)).to be_valid
  end

  it "has a factory to create with multiple items" do
    expect(FactoryGirl.create(:inspection_template_with_items, items_count: 5).items.length).to eq(5)
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:inspection_template, name: nil)).not_to be_valid
  end

  it "is valid without a unit" do
    expect(FactoryGirl.build(:inspection_template, unit: nil)).to be_valid
  end

  it "has a persisted ordered list of sections" do
    inspection_template = FactoryGirl.create(:inspection_template)
    inspection_template.sections = ["first", "second"]
    inspection_template.sections << "third"
    inspection_template.save!
    inspection_template = InspectionTemplate.find(inspection_template.id)
    expect(inspection_template.sections).to eq(["first", "second", "third"])
  end

  it "gets items in position order" do 
    inspection_template = FactoryGirl.build(:inspection_template)

    FactoryGirl.create(:inspection_template_item, position: 3, inspection_template: inspection_template)
    FactoryGirl.create(:inspection_template_item, position: 1, inspection_template: inspection_template)
    FactoryGirl.create(:inspection_template_item, position: 2, inspection_template: inspection_template)

    positions = inspection_template.items.pluck(:position)
    expect(positions).to eq(positions.sort)
  end

  it "has a method to create multiple items" do
    inspection_template = FactoryGirl.create(:inspection_template)
    item1 = FactoryGirl.attributes_for(:inspection_template_item, inspection_template: nil)
    item2 = FactoryGirl.attributes_for(:inspection_template_item, inspection_template: nil)

    inspection_template.update(items_attributes: [item1, item2])
    inspection_template.save!

    expect(inspection_template.items.count).to eq(2)
  end

  it "has a method to update and create multiple items" do
    inspection_template = FactoryGirl.build(:inspection_template)

    item1 = FactoryGirl.create(:inspection_template_item, name: "before1", inspection_template: inspection_template)
    item2 = FactoryGirl.create(:inspection_template_item, name: "before2", inspection_template: inspection_template)

    inspection_template.update(items_attributes: [{
      id: item1.id,
      name: "after1"
      },
      FactoryGirl.attributes_for(:inspection_template_item, name: "new", inspection_template: nil)
      ])

    inspection_template.save!

    expect(inspection_template.items.count).to eq(3)
    expect(inspection_template.items[0].name).to eq("after1")
    expect(inspection_template.items[1].name).to eq("before2")
    expect(inspection_template.items[2].name).to eq("new")
  end

  it "accepts deletion of associated items" do
    inspection_template = FactoryGirl.build(:inspection_template)
    FactoryGirl.create(:inspection_template_item, inspection_template: inspection_template)

    inspection_template.update(items_attributes: {id: inspection_template.items.first.id, _destroy: true})
    inspection_template.save!
    expect(inspection_template.items.count).to eq(0)
  end
end
