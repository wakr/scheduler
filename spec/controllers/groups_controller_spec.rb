require 'rails_helper'

describe GroupsController do
  describe "GET index" do
    it "assigns @groups" do
      group1 = FactoryGirl.create(:group)
      get :index
      expect(assigns(:groups)).to eq([group1])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assigns @group" do
      get :new
      group = assigns(:group)
      answer = group.id == nil && group.name == nil && group.description == nil
      expect(answer).to eq(true)
    end
  end

  describe "GET show" do

    before :each do
      @group = FactoryGirl.create(:group)
    end

    it "requires the :id parameter" do
      expect { get :show }.to raise_error(ActionController::UrlGenerationError)
    end

    it "assigns @membership" do
      get :show, :id => @group.id
      membership = assigns(:membership)
      expect(membership.group).to eq(@group)
    end
  end

  describe "POST create" do
    it "html redirects after create." do
      post :create, group: FactoryGirl.attributes_for(:group)
      expect(response.status).to eq(302)
    end

    it "assigns @group" do
      post :create, group: FactoryGirl.attributes_for(:group)
      expect(assigns(:group).name).to eq("Test group")
    end

    it "returns json-format also" do
      post :create, group: FactoryGirl.attributes_for(:group), :format => :json
      expect(response.header['Content-Type']).to include('application/json')
    end

    it " saves new object to db" do
      expect{
        post :create, group: FactoryGirl.attributes_for(:group)
      }.to change{Group.count}.from(0).to(1)
    end
  end

  describe "POST destroy" do
    it "destroys from db" do
      FactoryGirl.create(:group)
      id = Group.first.id
      expect{
        post :destroy, id: id
      }.to change{Group.count}.from(1).to(0)
    end
  end
end
