# spec/requests/buildings_spec.rb
require 'rails_helper'

RSpec.describe "Buildings", :type => :request do
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:building)
  }

  let(:valid_session) { {} }

  describe "when responding with JSON" do
    describe "GET #index" do
      it "renders all buildings plus units count as a list in json" do
        building = Building.create! valid_attributes
        FactoryGirl.create(:unit, building: building)
        get buildings_path, {format: :json}, valid_session
        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        expect(JSON.parse(response.body)[0]['name']).to eq(building.name)
        expect(JSON.parse(response.body)[0]['units_count']).to eq(1)
      end
    end

    describe "GET #show" do
      it "renders the building and units in json" do
        building = FactoryGirl.create(:building, name: "Test Name")
        FactoryGirl.create(:unit, building: building)

        get building_path(building), {format: :json}, valid_session

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['name']).to eq("Test Name")
        expect(parsed_response['units'].length).to eq(1)
      end
    end

    describe "PUT #update" do
      it "updates the building" do
        building = FactoryGirl.create(:building, name: "before")
        put(
          building_path(building), 
          {format: :json, building: {name: "after"}}
        )

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['name']).to eq("after")
      end
    end 
  end
end