require 'rails_helper'

describe MembershipsController do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
    ##@membership = FactoryGirl.create(:membership)
    request.env["HTTP_REFERER"] = "/taaltakutsutaan"
  end

  describe "GET new" do
    it "assigns variable membership" do
      get :new
      expect(assigns(:membership)).not_to eq(nil)
    end
  end

  describe "POST create" do
    it "assigns variable membership" do
      post :create, membership: FactoryGirl.attributes_for(:membership, group_id: 3, user_id: 2), :format => :json
      m = assigns(:membership)
      expect(m.user_id ).to eq(2)
      expect(m.group_id ).to eq(3)
    end

    it "renders back after succesful create " do
      post :create, membership: FactoryGirl.attributes_for(:membership, group_id: 11, user_id: 22)
      expect(response.status).to eq(302)
    end
  end
end
