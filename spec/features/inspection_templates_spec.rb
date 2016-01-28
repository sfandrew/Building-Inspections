require 'rails_helper'

RSpec.describe "InspectionTemplates", type: :request do
  describe "GET /inspection_templates" do
    it "works! (now write some real specs)" do
      get inspection_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
