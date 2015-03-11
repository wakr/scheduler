require 'rails_helper'

describe Assignment do
  it "no assigments in db before creating some." do
    expect(Assignment.all.count).to eq(0)
  end

  it "assignment without name is invalid" do
    expect(Assignment.create user_id:1).not_to be_valid
  end

  it "assignment without user is invalid" do
    expect(Assignment.create name:"Kristian").not_to be_valid
  end

  describe " is created and " do

    before :each do
      @assignment = FactoryGirl.create(:assignment)
    end

    it "has the name and user set correctly" do
      expect(Assignment.first.name).to eq(@assignment.name)
      expect(Assignment.first.user.name).to eq(@assignment.user.name)
    end

    it "when saved, count increases" do
      expect(Assignment.all.count).to eq(1)
    end

    it "when removed, can't be found anymore" do
      @assignment.destroy
      expect(Assignment.all.count).to eq(0)
    end

    it "to_s returns the name of the assignment." do
      expect(@assignment.to_s).to eq(@assignment.name)
    end

  end
end
