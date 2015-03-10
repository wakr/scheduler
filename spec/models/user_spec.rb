require 'rails_helper'

describe User do

  it "when no users created, database is empty." do
    expect(User.all.count).to eq(0)
  end

  it "does not allow to create user without name" do
    expect(User.create(birthdate: Date.new(1999,9,2))).not_to be_valid
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

    it "does not allow duplicate names" do
      user2 = User.create name: "Samu"
      expect(user2).not_to be_valid
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
