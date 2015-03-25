class MembershipsController < ApplicationController
  before_action :ensure_that_user_is_signed_in


  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)

    if Membership.membership_exists?(@membership.user_id, @membership.group_id)
      return respond_to do |format|
        format.html { redirect_to :back, notice: "You are allready in this group!"}
        format.json { render json: @membership, status: :unprocessable_entity }
      end
    end

    respond_to do |format|
      if @membership.save
           format.html { redirect_to :back, notice: "Welcome to group!" }
           format.json { render :show, status: :created, location: @membership }
      else
           format.html { render :new }
           format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Membership.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'You are not in the group anymore.' }
      format.json { head :no_content }
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end
end
