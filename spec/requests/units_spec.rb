# spec/requests/buildings_spec.rb
require 'rails_helper'

RSpec.describe "Units", :type => :request do
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:unit)
  }

  let(:valid_session) { {} }

  describe "when responding with JSON" do
    describe "GET #index" do
      it "renders all units for a building as a list in json" do
        building = FactoryGirl.create(:building)
        unit = FactoryGirl.create(:unit, building: building)
        get building_units_path(building), {format: :json}, valid_session
        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        expect(JSON.parse(response.body)[0]['unit_number']).to eq(unit.unit_number)
      end
    end

    describe "GET #show" do
      it "renders the unit in json" do
        building = FactoryGirl.create(:building)
        unit = FactoryGirl.create(:unit, building: building, unit_number: "Foo Bar 01")

        get building_unit_path(building, unit), {format: :json}, valid_session

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['unit_number']).to eq("Foo Bar 01")
      end
    end

    describe "PUT #update" do
      it "updates the building" do
        building = FactoryGirl.create(:building)
        unit = FactoryGirl.create(:unit, building: building, unit_number: "before")
        put(
          building_unit_path(building, unit), 
          {format: :json, unit: {unit_number: "after"}}
        )

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['unit_number']).to eq("after")
      end
    end 
  end
end