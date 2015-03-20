require 'rails_helper'

describe AssignmentsController do
  it "GET show assigns @tasks" do
    assignment = FactoryGirl.create(:assignment)
    task = FactoryGirl.create(:task)

    get :show, id: assignment.id
    tasks = assigns(:tasks)
    expect(tasks.first).to eq(task)
  end
end
