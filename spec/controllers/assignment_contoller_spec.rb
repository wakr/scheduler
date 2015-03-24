require 'rails_helper'

describe AssignmentsController do

  before :each do
    @assignment = FactoryGirl.create(:assignment)
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
end
