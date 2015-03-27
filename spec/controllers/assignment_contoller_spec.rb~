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
<<<<<<< HEAD

=======
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
>>>>>>> 43b20e08070026395445ed4809ade274411cb61a

  describe "GET new" do
    it "assigns variables" do
      get :new
      expect(assigns(:assignment).nil?).to eq(false)
    end
  end
end
