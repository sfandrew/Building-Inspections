require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    it "doesn't raise any errors" do
      get :index
    end
  end
end
