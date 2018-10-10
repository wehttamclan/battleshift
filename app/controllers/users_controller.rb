class UsersController < ApplicationController
  def show
    user_data = UserService.new.single_user(user_params[:id])
    @user = UserPresenter.new(user_data)
  end

  def index
    users_data = UserService.new.all_users

    @users = users_data.map do |user_data|
      UserPresenter.new(user_data)
    end 
  end



  private
  def user_params
    params.permit(:id)
  end
end
