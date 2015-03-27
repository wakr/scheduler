require 'rails_helper'

describe MembershipsController do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  describe "GET index" do
    pending("do")
  end



end