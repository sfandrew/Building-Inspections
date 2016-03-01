# spec/requests/inspection_templates_spec.rb
require 'rails_helper'

RSpec.describe "Inspections", :type => :request do
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:inspection)
  }

  let(:valid_session) { {} }

  describe "when responding with JSON" do
    describe "GET #index" do
      it "renders all inspections as a list in json, with items count" do
        inspection = Inspection.create! valid_attributes.tap{|x| x[:description] = "descr"}
        get inspections_path, {format: :json}, valid_session
        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        expect(JSON.parse(response.body)[0]['description']).to eq("descr")
        expect(JSON.parse(response.body)[0]['items_count']).to eq(inspection.items.count)

      end
    end

    describe "GET #show" do
      it "renders the inspection and its items in json" do
        inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 4)
        inspection = FactoryGirl.create(
          :inspection, 
          description: "Test Description", 
          template_id: inspection_template.id
        )
        get inspection_path(inspection), {format: :json}, valid_session

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(200)
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['description']).to eq("Test Description")
        expect(parsed_response['items'].length).to eq(4)
      end
    end

    describe "POST #create" do
      it "creates and renders the inspection with its items and items count" do
        unit = FactoryGirl.create(:unit)
        inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 4)
        expect {
          post inspections_path, {
            format: :json, :inspection => valid_attributes.tap{ |x|
              x[:description] = "Test Description"
              x[:items_count] = 4
              x[:template_id] = inspection_template.id
              x[:unit_id] = unit.id
            }
          }, valid_session
        }.to change(Inspection, :count).by(1)

        expect(response.content_type).to eq("application/json")
        expect(response.status).to be(201)
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['description']).to eq("Test Description")
        expect(parsed_response['items'].length).to eq(4)
        expect(parsed_response['items_count']).to eq(4)
      end
    end

  #   describe "PUT #update" do
  #     it "updates the inspection template" do
  #       inspection_template = FactoryGirl.create(:inspection_template, name: "before")
  #       put(
  #         inspection_template_path(inspection_template), 
  #         {format: :json, inspection_template: {name: "after"}}
  #       )

  #       expect(response.content_type).to eq("application/json")
  #       expect(response.status).to be(200)
  #       parsed_response = JSON.parse(response.body)
  #       expect(parsed_response['name']).to eq("after")
  #     end

  #     it "creates an associated item" do
  #       new_item_attributes = {
  #         items_attributes: [FactoryGirl.attributes_for(:inspection_template_item, name: "new item")]
  #       }

  #       inspection_template = FactoryGirl.create(:inspection_template)
  #       put(
  #         inspection_template_path(inspection_template), 
  #         {format: :json, inspection_template: 
  #           new_item_attributes
  #         }
  #       )

  #       expect(response.content_type).to eq("application/json")
  #       expect(response.status).to be(200)
  #       parsed_response = JSON.parse(response.body)
  #       expect(parsed_response['items'].length).to eq(1)
  #       expect(parsed_response['items'][0]['name']).to eq("new item")
  #     end

  #     it "updates an associated item" do
  #       inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 2)
  #       inspection_template.items[0].name = "first"
  #       inspection_template.items[1].name = "second"
  #       inspection_template.save!

  #       put(
  #         inspection_template_path(inspection_template), 
  #         {format: :json, inspection_template: 
  #           {
  #             items_attributes: {
  #               id: inspection_template.items[0].id,
  #               name: "first_after"
  #             }
  #           }
  #         }
  #       )

  #       expect(response.content_type).to eq("application/json")
  #       expect(response.status).to be(200)
  #       parsed_response = JSON.parse(response.body)
  #       expect(parsed_response['items'].length).to eq(2)
  #       expect(parsed_response['items'][0]['name']).to eq("first_after")
  #       expect(parsed_response['items'][1]['name']).to eq("second")

  #     end

  #     it "deletes an associated item" do
  #       inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 1)

  #       put(
  #         inspection_template_path(inspection_template), 
  #         {format: :json, inspection_template: 
  #           {
  #             items_attributes: {
  #               id: inspection_template.items[0].id,
  #               _destroy: '1'
  #             }
  #           }
  #         }
  #       )

  #       expect(response.content_type).to eq("application/json")
  #       expect(response.status).to be(200)
  #       parsed_response = JSON.parse(response.body)
  #       expect(parsed_response['items'].length).to eq(0)
  #     end
  #   end 
  end
end