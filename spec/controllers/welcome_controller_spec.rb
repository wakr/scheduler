require 'rails_helper'

describe WelcomeController do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  describe "GET index" do
    it "assigns variable @groups" do
      get :index
      expect(assigns(:groups)).not_to be(nil)
    end

    it "variable @groups contains only groups where current_user is member" do
      FactoryGirl.create(:group, name:"Mutantit")
      FactoryGirl.create(:group, name:"Koirat")
      get :index
      expect(assigns(:groups)).to eq(@user.groups)
    end

  end

end
