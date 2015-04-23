class SessionsController < ApplicationController




  def new
    if current_user
      redirect_to current_user
    end
  end

  def create
      user = User.find_by name: params[:name]

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user
      else
        redirect_to :back, alert: "Username and/or password mismatch"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end
