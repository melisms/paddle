class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name].downcase)
    if @tag
      @posts = @tag.posts
    else
      @posts = []
      flash[:alert] = "Tag not found."
    end
  end
end
