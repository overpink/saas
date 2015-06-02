require 'rails_helper'

describe CommentsController do

  before(:each) do
    signin
  end

  describe "GET 'index'" do
    before(:each) do
      @comments = create_list(:comment, rand(1..10))
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render :index template" do
      expect(response).to render_template :index
    end

    it "should load all comments" do
      expect(assigns(:comments)).to match_array(@comments)
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @comment = create(:comment)
      get :show, id: @comment
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render :show tempalte" do
      expect(response).to render_template :show
    end

    it "should find requested comment" do
      expect(assigns(:comment)).to eq(@comment)
    end
  end

  describe "GET 'new'" do
    before(:each) do
      get :new
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should build a new comment" do
      expect(assigns(:comment)).to be_a_new Comment
    end

    it "should render :new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @comment = create(:comment)
      get :edit, id: @comment
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should find requested comment" do
      expect(assigns(:comment)).to eq(@comment)
    end

    it "should render :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST 'create'" do
    context "With valid attributes" do
      it "should save the new comment into database" do
        expect{
          post :create, comment: attributes_for(:comment, owner: @user)
        }.to change(Comment, :count).by(1)
      end

      it "should redirect to comment path" do
        post :create, comment: attributes_for(:comment, owner: @user)
        comment = assigns(:comment)
        expect(response).to redirect_to comment_path(comment)
      end
    end

    context "With invalid attributes" do 
      it "should not save the new comment into database" do
        expect{
          post :create, comment: attributes_for(:comment, owner: @user, content: nil)
        }.to_not change(Comment, :count)
      end

      it "should render the form" do
        post :create, comment: attributes_for(:comment, owner: @user, content: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH 'update'" do
    before(:each) do
      @comment = create(:comment)
    end

    context "With valid attributes" do
      before(:each) do
        patch :update, id: @comment, comment: attributes_for(:comment, content: "My new content")
        @comment.reload
      end

      it "should find the requested comment" do
        expect(assigns(:comment)).to eq(@comment)
      end

      it "should update comment attributes" do
        expect(@comment.content).to eq("My new content")
      end

      it "should redirect to comment path" do
        expect(response).to redirect_to comment_path(@comment)
      end
    end

    context "With invalid attributes" do
      before(:each) do
        patch :update, id: @comment, comment: attributes_for(:comment, content: nil)
        @comment.reload
      end

      it "should not update comment attributes" do
        expect(@comment.content).to_not be_nil
      end

      it "should render form" do
        expect(@comment).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @comment = create(:comment)
    end

    it "should find the requested @comment" do
      delete :destroy, id: @comment
      expect(assigns(:comment)).to eq @comment
    end

    it "should delete comment from database" do
      expect{
        delete :destroy, id: @comment
      }.to change(Comment, :count).by(-1)
    end

    it "should redirect to comments url" do
      delete :destroy, id: @comment
      expect(response).to redirect_to comments_url
    end
  end
end