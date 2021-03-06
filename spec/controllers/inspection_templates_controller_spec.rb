require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe InspectionTemplatesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # InspectionTemplate. As you add validations to InspectionTemplate, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:inspection_template, user_id: controller.current_user.id)
  }

  let(:valid_attributes_wrong_user){
    FactoryGirl.attributes_for(:inspection_template, user_id: wrong_user.id)
  }

  let(:wrong_user){
    FactoryGirl.create(:user)
  }

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  describe "when logged in as a regular user" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
    end
    
    describe "GET #index" do
      it "assigns logged in user's inspection_templates as @inspection_templates" do
        inspection_template = InspectionTemplate.create! valid_attributes
        wrong_inspection_template = InspectionTemplate.create! valid_attributes_wrong_user
        get :index, {}
        expect(assigns(:inspection_templates)).to eq([inspection_template])
      end
    end

    describe "GET #show" do
      it "assigns the requested inspection_template as @inspection_template" do
        inspection_template = InspectionTemplate.create! valid_attributes
        get :show, {:id => inspection_template.to_param}
        expect(assigns(:inspection_template)).to eq(inspection_template)
      end

      it "redirects the user if the inspection template does belong to the current user" do
        wrong_inspection_template = InspectionTemplate.create! valid_attributes_wrong_user
        get :show, {:id => wrong_inspection_template.to_param}
        expect(response.status).to be(302)
      end
    end

    describe "GET #new" do
      it "assigns a new inspection_template as @inspection_template" do
        get :new, {}
        expect(assigns(:inspection_template)).to be_a_new(InspectionTemplate)
      end
    end

    describe "GET #edit" do
      it "assigns the requested inspection_template as @inspection_template" do
        inspection_template = InspectionTemplate.create! valid_attributes
        get :edit, {:id => inspection_template.to_param}
        expect(assigns(:inspection_template)).to eq(inspection_template)
      end

      it "redirects the user if the inspection template does not belong to the current user" do
        wrong_inspection_template = InspectionTemplate.create! valid_attributes_wrong_user
        get :edit, {:id => wrong_inspection_template.to_param}
        expect(response.status).to be(302)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new InspectionTemplate" do
          expect {
            post :create, {:inspection_template => valid_attributes}
          }.to change(InspectionTemplate, :count).by(1)
        end

        it "assigns a newly created inspection_template as @inspection_template" do
          post :create, {:inspection_template => valid_attributes}
          expect(assigns(:inspection_template)).to be_a(InspectionTemplate)
          expect(assigns(:inspection_template)).to be_persisted
        end

        it "redirects to the created inspection_template" do
          post :create, {:inspection_template => valid_attributes}
          expect(response).to redirect_to(InspectionTemplate.last)
        end
      end

      # context "with invalid params" do
      #   it "assigns a newly created but unsaved inspection_template as @inspection_template" do
      #     post :create, {:inspection_template => invalid_attributes}
      #     expect(assigns(:inspection_template)).to be_a_new(InspectionTemplate)
      #   end

      #   it "re-renders the 'new' template" do
      #     post :create, {:inspection_template => invalid_attributes}
      #     expect(response).to render_template("new")
      #   end
      # end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { name: "Changed Name" }
        }

        it "updates the requested inspection_template" do
          inspection_template = InspectionTemplate.create! valid_attributes
          put :update, {:id => inspection_template.to_param, :inspection_template => new_attributes}
          inspection_template.reload
          expect(inspection_template.name).to eq("Changed Name")
        end

        it "assigns the requested inspection_template as @inspection_template" do
          inspection_template = InspectionTemplate.create! valid_attributes
          put :update, {:id => inspection_template.to_param, :inspection_template => valid_attributes}
          expect(assigns(:inspection_template)).to eq(inspection_template)
        end

        it "redirects to the inspection_template" do
          inspection_template = InspectionTemplate.create! valid_attributes
          put :update, {:id => inspection_template.to_param, :inspection_template => valid_attributes}
          expect(response).to redirect_to(inspection_template)
        end

        context "when editing an unpermitted inspection template" do
          it "redirects and doesn't update" do
            wrong_inspection_template = InspectionTemplate.create! valid_attributes_wrong_user
            put :update, {:id => wrong_inspection_template.to_param, :inspection_template => new_attributes}
            wrong_inspection_template.reload
            expect(response.status).to be(302)
            expect(wrong_inspection_template.name).not_to eq("after_update")
          end
        end
      end

      # context "with invalid params" do
      #   it "assigns the inspection_template as @inspection_template" do
      #     inspection_template = InspectionTemplate.create! valid_attributes
      #     put :update, {:id => inspection_template.to_param, :inspection_template => invalid_attributes}
      #     expect(assigns(:inspection_template)).to eq(inspection_template)
      #   end

      #   it "re-renders the 'edit' template" do
      #     inspection_template = InspectionTemplate.create! valid_attributes
      #     put :update, {:id => inspection_template.to_param, :inspection_template => invalid_attributes}
      #     expect(response).to render_template("edit")
      #   end
      # end
    end

    describe "DELETE #destroy" do
      it "destroys the requested inspection_template" do
        inspection_template = InspectionTemplate.create! valid_attributes
        expect {
          delete :destroy, {:id => inspection_template.to_param}
        }.to change(InspectionTemplate, :count).by(-1)
      end

      it "redirects to the inspection_templates list" do
        inspection_template = InspectionTemplate.create! valid_attributes
        delete :destroy, {:id => inspection_template.to_param}
        expect(response).to redirect_to(inspection_templates_url)
      end
    end
  end

end
