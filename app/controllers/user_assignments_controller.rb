class UserAssignmentsController < ApplicationController
  before_action :ensure_that_user_is_signed_in


  def new
    @user_assignment = UserAssignment.new()
    @assignmnt = Assignment.find(params[:assignment_id])
    @users = User.all_in_same_group_but_not_assigned_to_assignment(@assignmnt.id, current_user)
  end


  # send post to this to create a connection between the created Assignment and the user
  def create
    @user_assignment = UserAssignment.new(user_assignment_params)

    respond_to do |format|
      if @user_assignment.save
        format.html { redirect_to current_user, notice: 'Worker was successfully added' }
        format.json { render :show, status: :created, location: @user_assignment.assignment }

      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end


  private

  def user_assignment_params
    params.require(:user_assignment).permit(:user_id, :assignment_id) #connects the user and assignment for this user
  end

end