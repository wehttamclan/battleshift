class UserPoro
  attr_reader :name, :email, :address
  def initialize(user_hash)
    @name = user_hash[:name]
    @email = user_hash[:email]
    @address = user_hash[:address]
  end
end
