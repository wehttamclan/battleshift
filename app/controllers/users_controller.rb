class UsersController < ApplicationController
  def show
    id = params[:id]
    conn = Faraday.new(:url => 'http://localhost:3000')
    response = conn.get "/api/v1/users/#{id}"
    user_hash = JSON.parse(response.body, symbolize_names: true)
    @user = UserPoro.new(user_hash)
  end

  def index
    conn = Faraday.new(:url => 'http://localhost:3000')
    response = conn.get "/api/v1/users"
    user_hash = JSON.parse(response.body, symbolize_names: true)
    @users = user_hash.map do |user_data|
      UserPoro.new(user_data)
    end 
  end
end
