class ActivationNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "Come on and slam, and welcome to the battleship!")
  end
end
