class HomeController < ApplicationController
  def index
    @username = current_user.username
  end
end
