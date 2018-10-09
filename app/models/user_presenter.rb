class UserPresenter
  
  def initialize(id)
    @id = id
  end

  def name
    user_data[:name]
  end

  def email
    user_data[:email]
  end

  def user_data
    response = user_service.single_user(@id)
  end

  def user_service
    @service ||= UserService.new
  end
end