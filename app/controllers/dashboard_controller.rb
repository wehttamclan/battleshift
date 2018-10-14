class DashboardController < ApplicationController
  def show
    if session[:user_id]
      @user = get_user(session[:user_id])
    end
  end
end
