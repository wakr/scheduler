require 'rails_helper'

describe User do
  it "has the name and birthday set correctly" do
    user = User.new name:"Samu", birthdate:Date.new(1992,8,27)
    expect(user.name).to eq("Samu")
    expect(user.birthdate.year).to eq(1992)
  end

  it "when saved, count increases" do
    user = User.create name:"Samu", birthdate: Date.new(1992,8,27)
    expect(User.all.count).to eq(1)
  end

  it "when removed, can't be found anymore" do
    user = User.create name:"Samu", birthdate: Date.new(1992,8,27)
    user.destroy
    expect(User.all.count).to eq(0)
  end

end
