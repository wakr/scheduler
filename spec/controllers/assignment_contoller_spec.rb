require 'rails_helper'

describe AssignmentsController do
  describe "GET show"
    it "assigns @tasks" do
      assignment = FactoryGirl.create(:assignment)
      task = FactoryGirl.create(:task)

      get :show, id: assignment.id
      tasks = assigns(:tasks)
      expect(tasks.first).to eq(task)
    end
  end

end
