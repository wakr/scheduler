require 'rails_helper'

describe MembershipsController do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
    @test_membership = FactoryGirl.create(:membership, user_id: 5, group_id: 5)
  end

  describe "GET new" do
    it "assigns variable membership" do
      get :new
      expect(assigns(:membership)).not_to eq(nil)
    end
  end

  describe "POST create" do
    describe "JSON" do
      before :each do
        send_post_create(3,2,:json)
      end

      it "assigns variable membership" do
        m = assigns(:membership)
        expect(m.user_id ).to eq(2)
        expect(m.group_id ).to eq(3)
      end

      it "answer contains just created membership if create success" do
        jsonAnswer = JSON.parse(response.body)
        expect(jsonAnswer["user_id"]).to eq(2)
        expect(jsonAnswer["group_id"]).to eq(3)
      end
    end

    it "HTML request renders back after succesful create" do
      request.env["HTTP_REFERER"] = "/taaltakutsutaan"
      send_post_create(11,22,:html)
      expect(response.status).to eq(302)
      expect(response).to redirect_to  %r(\Ahttp://test.host/taaltakutsutaan)
    end

    describe "with invalid input" do
      it "JSON request response status will tell that" do
        send_post_create(3, nil, :json)
        expect(response.status).to eq(422)
      end
    end

    describe "if membership allready exists" do
      it "HTML redirects back" do
        request.env["HTTP_REFERER"] = "/taaltakutsutaan"
        send_post_create(5,5,:html)
        expect(response.status).to eq(302)
        expect(response).to redirect_to  %r(\Ahttp://test.host/taaltakutsutaan)
      end
      it "JSON" do
        send_post_create(5,5,:json)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "POST destroy" do
    it "JSON return nothing" do
      send_post_destroy(@test_membership.id, :json)
      expect(response.status).to eq(204)
    end
    it "HTML " do
      request.env["HTTP_REFERER"] = "/taaltakutsutaan"
      send_post_destroy(@test_membership.id, :html)
      expect(response).to redirect_to  %r(\Ahttp://test.host/taaltakutsutaan)
    end
  end
end

def send_post_create(group_id, user_id, format)
  post :create, membership: FactoryGirl.attributes_for(:membership, group_id: group_id, user_id: user_id), :format => format
end

def send_post_destroy(id, format)
  post :destroy, id: id, :format => format
end
