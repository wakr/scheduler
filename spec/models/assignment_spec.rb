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
      @user = FactoryGirl.create(:user, :name => "Kaapo")
      @assignment.creator_id = @user.id
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

    it " finds the right creator" do
      u = @assignment.get_creator
      expect(u.id).to eq(@user.id)
    end

  end

  describe " when asked about ready state" do

    before :each do
      @assignment = FactoryGirl.create(:assignment)
      @task = FactoryGirl.create(:task)
      @assignment.tasks << @task
    end

      it " if all subtasks are done should be ready" do
        expect(@assignment.is_ready).to eq(true)
      end

      it " if assignment has no tasks, its initial state should be false" do
          @assignment2 = FactoryGirl.create(:assignment)
        expect(@assignment2.is_ready).to eq(false)
      end

      it " if assignment has one tasks that is not ready, it's state should be false" do
        @task2 = FactoryGirl.create(:task, :name => "t")
        @task2.update_attribute(:is_done, false)
        @assignment.tasks << @task2
        expect(@assignment.is_ready).to eq(false)
      end

end

  def put_user_to_assignment(user, assignment)

    ass = UserAssignment.create user_id:user.id, assignment_id:assignment.id
    user.user_assignments << ass
    assignment.user_assignments << ass
  end
end
