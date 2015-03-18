class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    allready_exists = Membership.where(:user_id => @membership.user_id, :group_id => @membership.group_id).first
    #byebug
    if !allready_exists.nil?
      return respond_to do |format|
        format.html { redirect_to :back, notice: "You are allready in this group!"}
        format.json { render json: @membership, status: :unprocessable_entity }
      end
    end

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
