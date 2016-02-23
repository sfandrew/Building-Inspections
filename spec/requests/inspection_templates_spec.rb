# spec/requests/inspection_templates_spec.rb
require 'rails_helper'

RSpec.describe "InspectionTemplates", :type => :request do
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:inspection_template)
  }

  let(:valid_session) { {} }

  describe "when responding with JSON" do
    describe "GET #index" do
      it "renders all inspection_templates as a list in json" do
        inspection_template = InspectionTemplate.create! valid_attributes
        get inspection_templates_path, {format: :json}, valid_session
        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        expect(JSON.parse(response.body)[0]['name']).to eq(inspection_template.name)
      end
    end

    describe "GET #show" do
      it "renders the inspection template and its items in json" do
        inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 5, name: "Test Name")
        get inspection_template_path(inspection_template), {format: :json}, valid_session
        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['name']).to eq("Test Name")
        expect(parsed_response['items'].length).to eq(5)
      end
    end

    describe "PUT #update" do
      it "updates the inspection template" do
        inspection_template = FactoryGirl.create(:inspection_template, name: "before")
        put(
          inspection_template_path(inspection_template), 
          {format: :json, inspection_template: {name: "after"}}
        )

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['name']).to eq("after")
      end

      it "creates an associated item" do
        new_item_attributes = {
          items_attributes: [FactoryGirl.attributes_for(:inspection_template_item, name: "new item")]
        }

        inspection_template = FactoryGirl.create(:inspection_template)
        put(
          inspection_template_path(inspection_template), 
          {format: :json, inspection_template: 
            new_item_attributes
          }
        )

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['items'].length).to eq(1)
        expect(parsed_response['items'][0]['name']).to eq("new item")
      end

      it "updates an associated item" do
        inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 2)
        inspection_template.items[0].name = "first"
        inspection_template.items[1].name = "second"
        inspection_template.save!

        put(
          inspection_template_path(inspection_template), 
          {format: :json, inspection_template: 
            {
              items_attributes: {
                id: inspection_template.items[0].id,
                name: "first_after"
              }
            }
          }
        )

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['items'].length).to eq(2)
        expect(parsed_response['items'][0]['name']).to eq("first_after")
        expect(parsed_response['items'][1]['name']).to eq("second")

      end

      it "deletes an associated item" do
        inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 1)

        put(
          inspection_template_path(inspection_template), 
          {format: :json, inspection_template: 
            {
              items_attributes: {
                id: inspection_template.items[0].id,
                _destroy: '1'
              }
            }
          }
        )

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['items'].length).to eq(0)
      end
    end 
  end
end