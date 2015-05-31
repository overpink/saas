require 'rails_helper'

describe TasksController do
  let(:project){create(:project, tenant: create(:tenant))}
  before(:each) do
    signin
  end

  describe "GET 'index'" do
    before(:each) do
      @tasks = create_list(:task, rand(1..10), project: project)
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render :index template" do
      expect(response).to render_template :index
    end

    it "should load all tasks" do
      expect(assigns(:tasks)).to match_array @tasks
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @task = create(:task)
      get :show, id: @task
    end

    it "should find requested task" do
      expect(assigns(:task)).to eq(@task)
    end

    it "should be success" do
      expect(response).to be_succes
    end

    it "should render :show template" do
      expect(response).to render_template :show
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

    it "should build a new Task" do
      expect(assigns(:task)).to be_a_new Task
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @task = create(:task, project: project)
      get :edit, id: @task
    end

    it "should find requested task" do
      expect(assigns(:task)).to eq(@task)
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST 'create'" do
    context "With valid attributes" do
      it "should save the new task into database" do
        expect{
          post :create, task: attributes_for(:task, project_id: project.id)
        }.to change(Task, :count).by(1)
      end

      it "should redirect to task path" do
        post :create, task: attributes_for(:task, project_id: project.id)
        expect(response).to redirect_to(task_path(assigns(:task)))
      end
    end

    context "With invalid attributes" do
      it "should not save the new task into database" do
        expect{
          post :create, task: attributes_for(:task, content: nil)
        }.to_not change(Task, :count)
      end

      it "should render the form" do
        post :create, task: attributes_for(:task, content: nil)
      end
    end
  end

  describe "PATCH 'update'" do
    before(:each) do
      @task = create(:task, project: project)
    end

    context "With valid attributes" do
      it "should update task attributes" do
        patch :update, id: @task, task: attributes_for(:task, content: "new content")
        @task.reload
        expect(@task.content).to eq("new content")
      end

      it "should redirect to task path" do
        patch :update, id: @task, task: attributes_for(:task)
        expect(response).to redirect_to task_path(@task)
      end
    end

    context "With invalid attributes" do
      it "shouyld not udpate task attributes" do
        patch :update, id: @task, task: attributes_for(:task, content: nil)
        @task.reload
        expect(@task.content).to_not be_nil
      end

      it "should render the form" do
        patch :update, id: @task, task: attributes_for(:task, content: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @task = create(:task, project: project)
    end

    it "should find the requested task" do
      delete :destroy, id: @task
      expect(assigns(:task)).to eq(@task)
    end

    it "should delete task from database" do
      expect{
        delete :destroy, id: @task
      }.to change(Task, :count).by(-1)
    end

    it "should redirect to tasks url" do
      delete :destroy, id: @task
      expect(response).to redirect_to tasks_url
    end
  end
end