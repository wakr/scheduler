require 'rails_helper'

describe Task do
  it "no tasks in db before creating some." do
    expect(Task.all.count).to eq(0)
  end

  it "task without name is invalid" do
    expect(Task.create assignment_id:1).not_to be_valid
  end

  it "task without assignment is invalid" do
    expect(Task.create name:"Hoida homma, iso H!").not_to be_valid
  end

  describe " is created and " do

    before :each do
      @task = FactoryGirl.create(:task)
    end

    it "has the name and user set correctly" do
      expect(Task.first.name).to eq(@task.name)
      expect(Task.first.assignment.name).to eq(@task.assignment.name)
    end

    it "when saved, count increases" do
      expect(Task.all.count).to eq(1)
    end

    it "when removed, can't be found anymore" do
      @task.destroy
      expect(Task.all.count).to eq(0)
    end
  end
end
