class UserPresenter
  attr_reader :name, :email

  def initialize(user_data)
    @name = user_data[:name]
    @email = user_data[:email]
  end
end