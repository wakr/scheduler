require 'rails_helper'

describe User do

  it "when no users created, database is empty." do
    expect(User.all.count).to eq(0)
  end

  describe "created and" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "has the name and birthday set correctly" do
      expect(User.first.name).to eq(@user.name)
      expect(User.first.birthdate.year).to eq(@user.birthdate.year)
    end

    it "when saved, count increases" do
      expect(User.all.count).to eq(1)
    end

    it "when removed, can't be found anymore" do
      @user.destroy
      expect(User.all.count).to eq(0)
    end

    it "to_s method returns name" do
      expect(User.first.to_s).to eq(@user.name)
    end
  end
end
