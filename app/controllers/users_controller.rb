class UsersController < ApplicationController
  def show
    user_data = service.find_user(params[:id])
    @user = UserPresenter.new(user_data)
  end

  def index
    @users = service.all_users.map do |user_data|
      UserPresenter.new(user_data)
    end 
  end

  def edit
    user_data = service.find_user(params[:id]) # don't call single user, maybe find
    @user = UserPresenter.new(user_data)
  end
  
  def update
    id        = params[:id]
    new_email = user_params[:email]
    service.update_email(id, new_email)
    user_data = service.find_user(id)
    user = UserPresenter.new(user_data)
    redirect_to '/users', notice: "Successfully updated #{user.name}."
  end

  private
  def user_params
    params.permit(:email)
  end

  def service
    BattleshiftService.new
  end
end
