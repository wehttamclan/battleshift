class UsersController < ApplicationController
  def show
    service = UserService.new
    @user = UserPresenter.new(service.single_user(user_params[:id]))
  end

  def index
    users_data = UserService.new.all_users

    @users = users_data.map do |user_data|
      UserPresenter.new(user_data[:id])
    end 
  end



  private
  def user_params
    params.permit(:id)
  end
end
