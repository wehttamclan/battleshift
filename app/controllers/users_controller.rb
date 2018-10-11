class UsersController < ApplicationController
  def show
    user_data = UserService.new.single_user(params[:id])
    @user = UserPresenter.new(user_data)
  end

  def index
    users_data = UserService.new.all_users

    @users = users_data.map do |user_data|
      UserPresenter.new(user_data)
    end 
  end

  def edit
    service = UserService.new
    user_data = service.single_user(params[:id])
    @user = UserPresenter.new(user_data)
  end
  
  def update
    id        = params[:id]
    new_email = user_params[:email]
    service   = UserService.new
    service.update_email(id, new_email)
    user_data = service.single_user(id)
    user = UserPresenter.new(user_data)
    redirect_to '/users', notice: "Successfully updated #{user.name}."
  end

  private
  def user_params
    params.permit(:email)
  end
end
