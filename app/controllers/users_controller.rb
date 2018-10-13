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

  def create
    service.create_user(user_params)
    redirect_to '/dashboard', notice: "Logged in as #{user_params[:name]} \n
                                  This account has not yet been activated. Please check your email."
  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end

  def service
    BattleshiftService.new
  end

  def get_user
    user = service.find_user(params[:id])
    UserPresenter.new(user)
  end

end
