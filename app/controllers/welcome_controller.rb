class WelcomeController < ApplicationController

  def index
    if current_user.nil?
      @groups = []
    else
      @groups = current_user.groups
    end
  end

end
