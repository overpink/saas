require 'rails_helper'

describe HomeController do
  before(:each) do
    signin
  end

  context "With no tenants" do
    it "should redirect to new tenants path" do
      @user.roles.in_tenant.destroy_all
      get :index
      expect(response).to redirect_to new_tenant_path
    end
  end

  context "With tenants" do 
    it "should redirect to tenants path" do
      get :index
      expect(response).to redirect_to tenants_path
    end
  end
end