# spec/requests/inspection_templates_spec.rb
require 'rails_helper'

RSpec.describe "Inspections", :type => :request do
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:inspection, user_id: @user.id)
  }

  describe "when logged in as a regular user" do
    before(:each) do
      sign_in_as_a_valid_user
    end

    describe "when responding with JSON" do
      describe "GET #index" do
        it "renders all inspections as a list in json, with items count" do
          inspection = Inspection.create! valid_attributes.tap{|x| x[:description] = "descr"}
          get inspections_path, {format: :json}
          expect(response.content_type).to eq("application/json")
          expect(response.status).to be(200)
          expect(JSON.parse(response.body)[0]['description']).to eq("descr")
          expect(JSON.parse(response.body)[0]['items_count']).to eq(inspection.items.count)

        end
      end

      describe "GET #show" do
        it "renders the inspection and its items in json" do
          inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 4)
          inspection_template.items[0].section = "item_0_section"
          inspection_template.save!

          inspection = Inspection.create! valid_attributes.tap{|x| 
            x[:description] = "Test Description"
            x[:template_id] = inspection_template.id
          }

          inspection.items[0].score = "pass"
          inspection.save!

          get inspection_path(inspection), {format: :json}

          expect(response.content_type).to eq("application/json")
          expect(response.status).to be(200)
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['description']).to eq("Test Description")
          expect(parsed_response['items'].length).to eq(4)
          expect(parsed_response['items'][0]['section']).to eq("item_0_section")
          expect(parsed_response['items'][0]['score']).to eq("pass")
        end
      end

      describe "POST #create" do
        it "creates and renders the inspection with its items and items count" do
          building = FactoryGirl.create(:building)
          unit = FactoryGirl.create(:unit, building: building)
          inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 4)
          inspection_template.items[0].section = "item_0_section"
          inspection_template.save!

          expect {
            post inspections_path, {
              format: :json, :inspection => valid_attributes.tap{ |x|
                x[:description] = "Test Description"
                x[:items_count] = 4
                x[:template_id] = inspection_template.id
                x[:unit_id] = unit.id
                x[:building_id] = building.id
              }
            }
          }.to change(Inspection, :count).by(1)

          expect(response.content_type).to eq("application/json")
          expect(response.status).to be(201)
          parsed_response = JSON.parse(response.body)

          expect(parsed_response['description']).to eq("Test Description")
          expect(parsed_response['items'].length).to eq(4)
          expect(parsed_response['items'][0]['section']).to eq("item_0_section")
          expect(parsed_response['items_count']).to eq(4)
        end
      end

      describe "PUT #update" do
        it "updates the inspection" do
          inspection = Inspection.create! valid_attributes.tap{|x| 
            x[:description] = "before"
          }
          put(
            inspection_path(inspection), 
            {format: :json, inspection: {description: "after"}}
          )

          expect(response.content_type).to eq("application/json")
          expect(response.status).to be(200)
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['description']).to eq("after")
        end

        it "updates associated items' scores" do
          inspection_template = FactoryGirl.create(:inspection_template_with_items, items_count: 2)
          inspection_template.items[0].score_type = "PassFail"
          inspection_template.items[1].score_type = "ZeroToTen"
          inspection_template.save!

          inspection = Inspection.create! valid_attributes.tap{|x| 
            x[:template] = inspection_template
          }
          inspection.items[0].score = "pass"
          inspection.items[1].score = 2
          inspection.save!

          put(
            inspection_path(inspection), 
            {format: :json, inspection: 
              {
                items_attributes: {
                  id: inspection.items[1].id,
                  score: 5
                }
              }
            }
          )

          expect(response.content_type).to eq("application/json")
          expect(response.status).to be(200)
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['items'].length).to eq(2)
          expect(parsed_response['items'][0]['score']).to eq("pass")
          expect(parsed_response['items'][1]['score']).to eq("5")
        end
      end 
    end
  end
end