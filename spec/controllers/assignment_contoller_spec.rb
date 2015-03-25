require 'rails_helper'

describe AssignmentsController do

  before :each do
    @assignment = FactoryGirl.create(:assignment)
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  describe "GET show" do
    it "assigns @tasks" do
      task = FactoryGirl.create(:task)

      get :show, id: @assignment.id
      tasks = assigns(:tasks)
      expect(tasks.first).to eq(task)
    end

  end
  describe "GET index" do
    it "renders index" do
      get :index
      expect(response).to render_template(:index)
    end
    it "response contains created assignment" do
      get :index
      expect(assigns(:assignments)).to eq([@assignment])
    end
  end


  describe "GET new" do
    it "assigns variables" do
      get :new
      expect(assigns(:assignment).nil?).to eq(false)
    end
  end

  describe "POST new" do
    it "saves correct assignment to database" do
      a = FactoryGirl.attributes_for(:assignment)

      pending("for the nil message. should create a us stubb and send with the assignment param")

      expect{
        post :create, assignment: a
      }.to change{Assignment.count}.from(0).to(1)
    end
  end

end
