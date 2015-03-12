require 'rails_helper'

describe Assignment do
  it "no assigments in db before creating some." do
    expect(Assignment.all.count).to eq(0)
  end

  it "assignment without name is invalid" do
    expect(Assignment.create is_done:true).not_to be_valid
  end

  describe " is created and " do

    before :each do
      @assignment = FactoryGirl.create(:assignment)
    end

    it "has the name and user set correctly" do
      expect(Assignment.first.name).to eq(@assignment.name)
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

    it "can have one user." do
      put_user_to_assignment(FactoryGirl.create(:user), @assignment)
      expect(Assignment.first.memberships.count).to eq(1)
      expect(Assignment.first.users.count).to eq(1)
    end

    it "can have multiple users." do
      ["Kristian", "Samu", "Luukkainen", "Chang"].each do |username|
        put_user_to_assignment(FactoryGirl.create(:user, name:username), @assignment)
      end
      expect(Assignment.first.users.count).to eq(4)
    end
  end
end

def put_user_to_assignment(user, assignment)
  Membership.create user_id:user.id, assignment_id:assignment.id
end
