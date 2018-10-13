class UsersController < ApplicationController
  def show
    @user = get_user
  end

  def index
    @users = service.all_users.map do |user_data|
      UserPresenter.new(user_data)
    end
  end

  def edit
    @user = get_user
  end

  def update
    service.update_email(params[:id], user_params[:email])
    redirect_to '/users', notice: "Successfully updated #{get_user.name}."
  end

  def new
  end

  private
  def user_params
    params.permit(:email)
  end

  def service
    BattleshiftService.new
  end

  def get_user
    user = service.find_user(params[:id])
    UserPresenter.new(user)
  end
end
