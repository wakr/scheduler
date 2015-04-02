require 'rails_helper'

describe AssignmentsController do

  before :each do
    @user = FactoryGirl.create(:user, name: "Kaapo")
    @user_assignment = FactoryGirl.create(:user_assignment)
    @assignment = Assignment.find(@user_assignment.assignment)
    @assignment.creator_id = @user.id
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
      session[:user_id] = @user_assignment.user.id
      get :index
      expect(response).to render_template(:index)
    end
    it "response contains created assignment" do
      session[:user_id] = @user_assignment.user.id
      get :index
      expect(assigns(:assignments)).to eq([@user_assignment.assignment])
    end
  end


  describe "GET new" do
    it "assigns variables" do
      get :new
      expect(assigns(:assignment).nil?).to eq(false)
    end

    it "assigns variable @members." do
      get :new
      expect(assigns(:members).nil?).to eq(false)
    end

    describe "variable members" do
      before :each do
              @user2 = FactoryGirl.create(:user, name: "Kristian")
              @user3 = FactoryGirl.create(:user, name: "Chang")
        assignment = FactoryGirl.create(:assignment, name: "Mini ohtu projekti!")
        assignment.creator_id = @user2.id

        group_a = FactoryGirl.create(:group, name:"Microsoft")
        group_b = FactoryGirl.create(:group, name:"Kilometritehdas")
        FactoryGirl.create(:membership, user_id: @user2.id, group_id: group_a.id) #Kristian Microsoftille
        FactoryGirl.create(:membership, user_id: @user.id, group_id: group_b.id) # Samu kilometritehtaalle
        FactoryGirl.create(:membership, user_id: @user3.id, group_id: group_b.id) #Chang myös
      end

      it "should contain only persons who are in same groups as creator." do
        get :new
        members = assigns(:members)
        expect(members).not_to include(@user2)
        expect(members).to include(@user3)
      end

      it "should not contain creator/current_user" do
        get :new
        members = assigns(:members)
        expect(members).not_to include(@user)
      end
    end


  end

  describe "POST new" do
    it "saves correct assignment to database" do
      a = FactoryGirl.attributes_for(:assignment, group_id: 2)

      pending("for the nil message. should create a us stubb and send with the assignment param")
      post :create, assignment: a
    end
  end

end
