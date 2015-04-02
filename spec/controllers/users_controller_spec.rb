require 'rails_helper'

describe UsersController do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end


  describe "GET index" do

    it "assigns @users" do
      get :index
      expect(assigns(:users)).to eq([@user])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assigns @user" do
      get :new
      user = assigns(:user)
      answer = user.id == nil && user.name == nil
      expect(answer).to eq(true)
    end
  end

  describe "POST create" do

    before :each do
      resetUser
    end

    it "html redirects after create." do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(response.status).to eq(302)
    end

    it "assigns @user" do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(assigns(:user).name).to eq("Samu")
    end

    it "returns json-format also" do
      post :create, user: FactoryGirl.attributes_for(:user), :format => :json
      expect(response.header['Content-Type']).to include('application/json')
    end

    it " saves new object to db" do
      expect{
        post :create, user: FactoryGirl.attributes_for(:user)
      }.to change{User.count}.from(0).to(1)
    end
  end

  describe "POST destroy" do

    it "destroys from db" do
      u2 = FactoryGirl.create(:user, :name => "Kaapo")
      id = u2.id
      expect{
        post :destroy, id: id
      }.to change{User.count}.from(2).to(1)
    end
  end

  describe "UPDATE @user" do

    it "updates the user" do
      put :update, {id: @user, user: FactoryGirl.attributes_for(:user, :name => "Pentti")}
      @user.reload
      @user.name.should == "Pentti"
    end

    it "after update, redirects to user show" do

    end

  end




end


def resetUser
    User.all.each do |u|
      u.destroy
    end
    session[:user_id] = nil
end