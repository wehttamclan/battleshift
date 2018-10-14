class UserPresenter
  attr_reader :id, :name, :email, :status

  def initialize(user_data)
    @status = user_data[:activated]
    @id     = user_data[:id]
    @name   = user_data[:name]
    @email  = user_data[:email]
  end

  def user_status
    if @status == 1
      "Status: Active"
    else
      "This account has not yet been activated. Please check your email."
    end 
  end
end
