class UsersController < ApplicationController
  def show
    response = Faraday.get("http://localhost:3000/api/v1/users/#{params[:id]}")
    user_data = JSON.parse(response.body, symbolize_names: true)
    @user = UserPresenter.new(user_data)
  end

  def index
    response = Faraday.get("http://localhost:3000/api/v1/users")
    users_data = JSON.parse(response.body, symbolize_names: true)
    @users = users_data.map do |user_data|
      UserPresenter.new(user_data)
    end
  end
end
