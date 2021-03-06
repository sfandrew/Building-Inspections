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

RSpec.describe UnitsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Unit. As you add validations to Unit, be sure to
  # adjust the attributes here as well.

  let(:building_id) {
    FactoryGirl.create(:building, user: controller.current_user).id
  }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:unit, building_id: building_id)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:invalid_unit, building_id: building_id)
  }

  let (:unit_with_different_building) {
    FactoryGirl.create(:unit, 
      building: FactoryGirl.create(:building, user: controller.current_user))
  }


  let(:valid_attributes_wrong_user) {
    FactoryGirl.attributes_for(:unit,
      building_id: building_id_wrong_user)
  }

  let(:building_id_wrong_user) {
    FactoryGirl.create(:building, user: wrong_user).id
  }

  let (:unit_with_wrong_user) {
    FactoryGirl.create(:unit,
      building_id: building_id_wrong_user)
  }

  let (:wrong_user) {
    FactoryGirl.create(:user)
  }

  describe "whe logged in as a regular user" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    describe "GET #index" do
      it "assigns all units as @units" do
        unit = Unit.create! valid_attributes
        get :index, {building_id: building_id}
        expect(assigns(:units)).to eq([unit])
      end

      it "assigns building as @building" do
        unit = Unit.create! valid_attributes
        get :index, {building_id: building_id}
        expect(assigns(:building)).to eq(unit.building)
      end 

      it "doesn't get units from different buildings" do
        unit = Unit.create! valid_attributes
        get :index, {building_id: building_id}
        expect(assigns(:units)).to eq([unit])
      end

      context "when accessing an unpermitted building's units" do
        it "redirects" do
          unit = unit_with_wrong_user
          get :index, {building_id: unit.building_id}
          expect(response.status).to eq(302)
        end
      end
    end

    describe "GET #show" do
      it "assigns the requested unit as @unit" do
        unit = Unit.create! valid_attributes
        get :show, {:id => unit.to_param, :building_id => building_id}
        expect(assigns(:unit)).to eq(unit)
      end

      it "doesn't assign unit from the wrong building" do
        unit = Unit.create! valid_attributes
        expect{
          get(:show, {:id => unit.to_param, :building_id => unit_with_different_building.building_id})
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "when accessing an unpermitted building's unit" do
        it "denies authorization and redirects" do
          unit = unit_with_wrong_user
          get :show, {:id => unit.to_param, :building_id => unit.building_id}
          expect(response.status).to eq(302)
        end
      end
    end

    describe "GET #new" do
      it "assigns a new unit as @unit" do
        get :new, {:building_id => building_id}
        expect(assigns(:unit)).to be_a_new(Unit)
      end

      context "when accessing an unpermitted building's units" do
        it "redirects" do
          get :new, {:building_id => unit_with_wrong_user.building_id}
          expect(response.status).to eq(302)
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested unit as @unit" do
        unit = Unit.create! valid_attributes
        get :edit, {:id => unit.to_param, :building_id => building_id}
        expect(assigns(:unit)).to eq(unit)
      end

      it "doesn't assign unit from the wrong building" do
        unit = Unit.create! valid_attributes
        expect{
          get :edit, {:id => unit.to_param, :building_id => unit_with_different_building.building_id}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "when accessing an unpermitted building's units" do
        it "redirects" do
          unit = unit_with_wrong_user
          get :edit, {:id => unit.to_param, :building_id => unit.building_id}
          expect(response.status).to eq(302)
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Unit" do
          expect {
            post :create, {:unit => valid_attributes, :building_id => building_id}
          }.to change(Unit, :count).by(1)
        end

        it "assigns a newly created unit as @unit" do
          post :create, {:unit => valid_attributes, :building_id => building_id}
          expect(assigns(:unit)).to be_a(Unit)
          expect(assigns(:unit)).to be_persisted
        end

        it "redirects to the created unit" do
          post :create, {:unit => valid_attributes, :building_id => building_id}
          expect(response).to redirect_to([Unit.last.building, Unit.last])
        end

        it "creates the unit for the correct building" do 
          post :create, {:unit => valid_attributes, :building_id => unit_with_different_building.building_id}
          expect(assigns(:unit).building_id).to eq(unit_with_different_building.building_id)
        end

        context "when accessing an unpermitted building's units" do
          it "redirects and doesn't create a new unit" do
            expect {
              post :create, {:unit => valid_attributes_wrong_user, :building_id => building_id_wrong_user}
            }.to change(Unit, :count).by(0)
            expect(response.status).to eq(302)
          end
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved unit as @unit" do
          post :create, {:unit => invalid_attributes, :building_id => building_id}
          expect(assigns(:unit)).to be_a_new(Unit)
        end

        it "re-renders the 'new' template" do
          post :create, {:unit => invalid_attributes, :building_id => building_id}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:valid_attributes) {
          FactoryGirl.attributes_for(:unit, unit_number: "before_update", building_id: building_id)
        }

        let(:new_attributes) {
          {unit_number: "after_update"}
        }

        it "updates the requested unit" do
          unit = Unit.create! valid_attributes
          put :update, {:id => unit.to_param, :unit => new_attributes, :building_id => building_id}
          unit.reload
          expect(unit.unit_number).to eq("after_update")
        end

        it "assigns the requested unit as @unit" do
          unit = Unit.create! valid_attributes
          put :update, {:id => unit.to_param, :unit => valid_attributes, :building_id => building_id}
          expect(assigns(:unit)).to eq(unit)
        end

        it "redirects to the unit" do
          unit = Unit.create! valid_attributes
          put :update, {:id => unit.to_param, :unit => valid_attributes, :building_id => building_id}
          expect(response).to redirect_to([unit.building, unit])
        end

        it "doesn't assign unit from the wrong building" do
          unit = Unit.create! valid_attributes
          expect{
            put :update, {:id => unit.to_param, :unit => valid_attributes, :building_id => unit_with_different_building.building_id}
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

        context "when accessing an unpermitted building's units" do
          it "redirects and doesn't update the unit" do
            unit = unit_with_wrong_user

            put :update, {:id => unit.to_param, :unit => new_attributes, :building_id => unit_with_wrong_user.building_id}
            unit.reload
            expect(unit.unit_number).not_to eq("after_update")
            expect(response.status).to eq(302)
          end
        end
      end

      context "with invalid params" do
        it "assigns the unit as @unit" do
          unit = Unit.create! valid_attributes
          put :update, {:id => unit.to_param, :unit => invalid_attributes, :building_id => building_id}
          expect(assigns(:unit)).to eq(unit)
        end

        it "re-renders the 'edit' template" do
          unit = Unit.create! valid_attributes
          put :update, {:id => unit.to_param, :unit => invalid_attributes, :building_id => building_id}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested unit" do
        unit = Unit.create! valid_attributes
        expect {
          delete :destroy, {:id => unit.to_param, :building_id => building_id}
        }.to change(Unit, :count).by(-1)
      end

      it "redirects to the units list" do
        unit = Unit.create! valid_attributes
        delete :destroy, {:id => unit.to_param, :building_id => building_id}
        expect(response).to redirect_to(building_units_url(building_id))
      end

      it "doesn't assign unit from the wrong building" do
        unit = Unit.create! valid_attributes
        expect{
          delete :destroy, {:id => unit.to_param, :building_id => unit_with_different_building.building_id}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "when accessing an unpermitted building's units" do
        it "redirects and doesn't delete the unit" do
          unit = unit_with_wrong_user
          expect {
            delete :destroy, {:id => unit.to_param, :building_id => unit.building_id}
          }.to change(Unit, :count).by(0)
          expect(response.status).to eq(302)
        end
      end
    end
  end

end
