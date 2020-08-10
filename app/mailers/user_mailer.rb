class UserMailer < ApplicationMailer
  default from: 'no-reply@adev42.com'

  def welcome_email(user)
    @user = user
    @url = '/login'
    mail(to: @user.email, subject: 'Welcome to our website!')
  end
end
