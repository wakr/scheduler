require 'rails_helper'

describe User do
  it 'has the name and birthday set correctly' do
    user = User.new name:"Samu", birthdate:Date.new(1992,8,27)
    expect(user.name).to eq("Samu")
    expect(user.birthdate.year).to eq(1992)
  end
end
