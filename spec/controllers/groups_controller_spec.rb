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
end
