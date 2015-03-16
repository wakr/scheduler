class SessionsController < ApplicationController

  def new
  end

  def create
      user = User.find_by name: params[:name]

      byebug

      if user
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      else
        redirect_to :back, notice: "Username mismatch"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end