class MembershipController < ApplicationController

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.save
  end

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end
end
