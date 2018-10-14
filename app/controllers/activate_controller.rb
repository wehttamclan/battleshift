class ActivateController < ApplicationController
  def show
    activate_user
    session[:user_id] = @user.id
    sleep(5)
    redirect_to "/dashboard"
  end

  private

  def activate_user
    @user = User.find_by_api_key(params[:api_key])
    user.activated = 1
  end
end
