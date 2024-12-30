class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :set_query, :set_user

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_query
    @query = Post.ransack(params[:q])
  end

  def set_user
    @user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end
