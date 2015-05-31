require 'rails_helper'

describe DashboardController do
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

    it "should render :index template"  do
      expect(response).to render_template :index
    end
  end
end