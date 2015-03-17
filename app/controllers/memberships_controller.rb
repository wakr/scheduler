class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.save # ? :D if @membership.save already checks this

    respond_to do |format|
     if @membership.save
       format.html { redirect_to :back, notice: "Yes!" }
       format.json { render :show, status: :created, location: @membership }
     else
       format.html { render :new }
       format.json { render json: @membership.errors, status: :unprocessable_entity }
     end
   end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end
end
