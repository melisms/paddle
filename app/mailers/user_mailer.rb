class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  def welcome_email(user)
    @user = user
    # @url  = "https://evident-massive-camel.ngrok-free.app/login"
    @url = "http://127.0.0.1:3000/users/sign_in"
    mail(to: @user.email, subject: "Welcome to Our App!")
  end
end
