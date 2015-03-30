class UserAssignmentsController < ApplicationController
  before_action :ensure_that_user_is_signed_in


  def new
    @user_assignment = UserAssignment.new()
    @assignmnt = Assignment.find(params[:assignment_id])
    @users = User.all_in_same_group_but_not_assigned_to_assignment(@assignmnt.id, current_user)
  end


  # send post to this to create a connection between the created Assignment and the user
  def create
    @user_assignment = UserAssignment.new(UserAssignment_params)

    if @user_assignment.save
      raise "user assigned to assignment. Implement the rest"
    else
      raise "user assigment failed. Implement the rest"
    end

  end


  private

  def UserAssignment_params
    params.require(:user_assignment).permit(:user_id, :assignment_id) #connects the user and assignment for this user
  end

end