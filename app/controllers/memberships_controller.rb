class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    byebug
    allready_exists = Membership.find_by(user_id:@membership.user_id)

    if allready_exists.nil?
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
   respond_to do |format|
     format.html { redirect_to :back, notice: "You are allready in this group!"}
     format.json { render json: @membership, status: :unprocessable_entity }
   end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end
end
