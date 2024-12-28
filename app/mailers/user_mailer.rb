class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  def welcome_email(user)
    @user = user
    # @url  = "https://evident-massive-camel.ngrok-free.app/login"  # Update with your production URL
    mail(to: @user.email, subject: "Welcome to Our App!")
  end
end
