require 'rails_helper'

describe User do
  it "has the name and birthday set correctly" do
    user = FactoryGirl.create(:user)
    expect(user.name).to eq("Samu")
    expect(user.birthdate.year).to eq(1992)
  end

  it "when saved, count increases" do
    user = FactoryGirl.create(:user)
    expect(User.all.count).to eq(1)
  end

  it "when removed, can't be found anymore" do

  end

end
