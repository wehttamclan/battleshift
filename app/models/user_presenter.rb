class UserPresenter
  attr_reader :id, :name, :email

  def initialize(user_data)
    @id    = user_data[:id]
    @name  = user_data[:name]
    @email = user_data[:email]
  end
end