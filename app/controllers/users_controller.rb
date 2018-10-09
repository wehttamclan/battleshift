class UsersController < ApplicationController
  def show
    @user = UserPresenter.new(user_params[:id])
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
