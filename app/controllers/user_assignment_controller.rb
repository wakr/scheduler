class UserAssignmentController < ApplicationController
  before_action :ensure_that_user_is_signed_in

  # send post to this to create a connection between the created Assignment and the user
  def create
    @user_assignment = UserAssignment.new(membership_params)

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