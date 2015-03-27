require 'rails_helper'

describe ApplicationController do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  describe "#current_user" do
      it "returns right current user" do
        expect(subject.current_user.name).to eq(@user.name)
      end
  end

  describe "#ensure_that_user_is_signed_in" do
    it "redirects to right place and with right setting" do
    session[:user_id] = nil #reset the session
    expect(subject.current_user).to be(nil)

    # not working properly yet
  end

  end


end