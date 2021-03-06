require 'rails_helper'

describe AssignmentsController do

  before :each do
    @user = FactoryGirl.create(:user, name: "Kaapo")
    @user_assignment = FactoryGirl.create(:user_assignment)
    @assignment = Assignment.find(@user_assignment.assignment.id)
    @assignment.creator_id = @user.id
    session[:user_id] = @user.id
  end

  describe "GET show" do
    it "assigns @tasks" do
      task = FactoryGirl.create(:task)
      get :show, id: task.assignment.id
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

  describe "POST create" do
    it "saves correct assignment to database" do
      a = FactoryGirl.attributes_for(:assignment, group_id: 2)

      expect{
        post :create, assignment: a
      }.to change{Assignment.count}.from(1).to(2)
    end
  end

  describe "EDIT old" do

    it "assigns the @assignment, @assignment.user_assignments and @users" do
      get :edit, id: @assignment.id
      expect(assigns(:assignment)).not_to eq(nil)
    end

  end

  describe "UPDATE @assignment" do
    it "updates correctly the old one" do
      put :update, {id: @assignment, assignment: FactoryGirl.attributes_for(:assignment, :name => "asd")}
      @assignment.reload
      expect(@assignment.name).to eq("asd")
    end
  end

  describe "POST destroy @assignment" do

    it "deletes from the database if current_user is the creator" do
      asgnmt = FactoryGirl.create(:assignment, name: "Siivous", creator_id: @user.id)

      id = asgnmt.id
      expect{
        post :destroy, id: id
      }.to change{Assignment.count}.from(2).to(1)
    end

    it "redirects back if current_user is not the creator" do
      asgnmt = FactoryGirl.create(:assignment, name: "Siivous", creator_id: 3)
      id = asgnmt.id
      post :destroy, id: id
      expect(response).to redirect_to :root
    end
  end

end
