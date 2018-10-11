class RegistrationMailer < ApplicationMailer

  def confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Activation email")
  end
end
