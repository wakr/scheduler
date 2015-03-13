require 'rails_helper'

describe Assignment do
  it " not in db before creating some." do
    expect(Assignment.all.count).to eq(0)
  end

  it " without name is invalid" do
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
      expect(Assignment.first.user_assignments.count).to eq(1)
      expect(Assignment.first.doers.count).to eq(1)
    end

    it "can have multiple users." do
      ["Kristian", "Samu", "Luukkainen", "Chang"].each do |username|
        put_user_to_assignment(FactoryGirl.create(:user, name:username), @assignment)
      end
      expect(Assignment.first.doers.count).to eq(4)
    end

    it "can find related users." do
      ["Kristian", "Samu", "Luukkainen", "Chang"].each do |username|
        put_user_to_assignment(FactoryGirl.create(:user, name:username), @assignment)
      end
      u_1 = Assignment.all.first.doers.find_by name: "Chang"
      u_2 = Assignment.all.first.doers.find_by name: "Samu"

      expect(u_1.name).to eq("Chang")
      expect(u_2.name).to eq("Samu")
    end

    it " when task is added to this object. It can be recovered via this object." do
      t = Task.new name: "asd", assignment_id: @assignment.id
      @assignment.tasks << t
      expect(@assignment.tasks.count).to eq(1)
      expect(@assignment.tasks.first.name).to eq("asd")
    end
  end
end

def put_user_to_assignment(user, assignment)

  ass = UserAssignment.create user_id:user.id, assignment_id:assignment.id
  user.user_assignments << ass
  assignment.user_assignments << ass
end
