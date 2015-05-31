require 'rails_helper'

describe ProjectsController do
  before(:each) do
    signin
    request.host = "#{@tenant.slug}.test.com"
  end

  describe "GET 'index'" do
    before(:each) do
      @projects = create_list(:project, rand(1..10), tenant: @tenant)
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should load project related to current_tenant" do
      expect(assigns(:projects)).to match_array(@projects)
    end

    it "should render index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @project = create(:project, tenant: @tenant)
      get :show, id: @project
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render template :show" do
      expect(response).to render_template :show
    end

    it "should find requested project" do
      expect(assigns(:project)).to eq(@project)
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

    it "should build a new project" do
      expect(assigns(:project)).to be_a_new Project
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @project = create(:project, tenant: @tenant)
      get :edit, id: @project
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should find the requested project" do
      expect(assigns(:project)).to eq(@project)
    end

    it "should render :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST 'create'" do
    context "With valid attributes"  do
      it "should save the new project into database" do
        expect{
          post :create, project: attributes_for(:project, tenant: @tenant) 
        }.to change(Project, :count).by(1)
      end

      it "should redirect to project path" do
        post :create, project: attributes_for(:project, tenant: @tenant)
        expect(response).to redirect_to project_path(assigns(:project))
      end
    end

    context "With invalid attributes" do
      it "should not save project into database" do
        expect{
          post :create, project: attributes_for(:project, name: nil)
        }.to_not change(Project, :count)
      end

      it "should render the form" do
        post :create, project: attributes_for(:project, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH 'update'" do
    before(:each) do
      @project = create(:project, tenant: @tenant)
    end

    context "With valid attributes" do
      it "should update project attributes" do
        put :update, id: @project, project: attributes_for(:project, name: "new name")
        @project.reload
        expect(@project.name).to eq("new name")
      end

      it "should redirect to project path" do
        put :update, id: @project, project: attributes_for(:project, name: "new name")
        expect(response).to redirect_to project_path(assigns(:project))
      end
    end

    context "With invalid attributes" do
      it "should not update project attributes" do
        put :update, id: @project, project: attributes_for(:project, name: nil)
        @project.reload
        expect(@project.name).to_not be_nil
      end

      it "should render the form" do
        put :update, id: @project, project: attributes_for(:project, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @project = create(:project, tenant: @tenant)
    end

    it "should find requested project" do
      delete :destroy, id: @project
      expect(assigns(:project)).to eq(@project)
    end

    it "should delete project from database" do
      expect{
        delete :destroy, id: @project
      }.to change(Project, :count).by(-1)
    end

    it "should redirect to projects url" do
      delete :destroy, id: @project
      expect(response).to redirect_to projects_url
    end
  end
end