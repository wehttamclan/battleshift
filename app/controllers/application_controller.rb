class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def service
    BattleshiftService.new
  end

  def get_user(id)
    user = service.find_user(id)
    UserPresenter.new(user)
  end
end
