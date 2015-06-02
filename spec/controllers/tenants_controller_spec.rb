require 'rails_helper'

describe TenantsController do
  before(:each) do
    signin
  end

  describe "GET 'index'" do
    before(:each) do
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render :index template" do
      expect(response).to render_template :index
    end

    it "should load all tenants related to user" do
      expect(@user.roles.in_tenant).to match_array(assigns(:user_roles))
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @tenant = create(:tenant)
      get :show, id: @tenant
    end

    it "should find the requested tenant" do
      expect(assigns(:tenant)).to eq(@tenant)
    end

    it "should render :show template" do
      expect(response).to render_template :show
    end

    it "should be success" do
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    before(:each) do
      get :new
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render :new template" do
      expect(response).to render_template :new
    end

    it "should build a new tenant" do
      expect(assigns(:tenant)).to be_a_new Tenant
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @tenant = create(:tenant)
      get :edit, id: @tenant
    end

    it "should find requested tenant" do
      expect(assigns(:tenant)).to eq(@tenant)
    end

    it "should render :edit template" do
      expect(response).to render_template :edit
    end

    it "should be succes" do
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    context "With valid attributes" do
      it "should save the new tenant into database" do
        expect{
          post :create, tenant: attributes_for(:tenant)
        }.to change(Tenant, :count).by(1)
      end

      it "should redirect to tenant path" do
        post :create, tenant: attributes_for(:tenant)
        expect(response).to redirect_to(tenant_path(assigns(:tenant)))
      end
    end

    context "With invalid attributes" do
      it "should not save the tenant into database" do
        expect{
          post :create, tenant: attributes_for(:tenant, name: nil)
        }.to_not change(Tenant, :count)
      end

      it "should render the form" do
        post :create, tenant: attributes_for(:tenant, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH 'update'" do
    before(:each) do
      @tenant = create(:tenant)
    end

    context "With valid attributes" do
      before(:each) do
        patch :update, id: @tenant, tenant: attributes_for(:tenant, name: "new name")
        @tenant.reload
      end

      it "should update tenant attributes" do
        expect(@tenant.name).to eq("new name")
      end

      it "should redirect to tenant path" do
        expect(response).to redirect_to tenant_path(@tenant)
      end
    end

    context "With invalid attributes" do
      before(:each) do
        patch :update, id: @tenant, tenant: attributes_for(:tenant, name: nil)
      end

      it "should not update tenant attributes" do
        expect(@tenant.name).to_not be_nil
      end

      it "should render the form" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @tenant = create(:tenant)
    end

    it "should find requested tenant" do
      delete :destroy, id: @tenant
      expect(assigns(:tenant)).to eq(@tenant)
    end

    it "should delete tenant from database" do
      expect{
        delete :destroy, id: @tenant
      }.to change(Tenant, :count).by(-1)
    end

    it "should redirect to tenants list" do
      delete :destroy, id: @tenant
      expect(response).to redirect_to tenants_url
    end
  end

end