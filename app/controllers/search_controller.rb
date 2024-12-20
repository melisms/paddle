class SearchController < ApplicationController
  def index
    @query = Post.ransack(params[:q])
    @posts = @query.result.includes(:user).distinct
  end
end
