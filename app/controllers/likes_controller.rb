class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to post_path(@post), notice: 'Post liked!'
    else
      redirect_to post_path(@post), alert: 'Unable to like post.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like&.destroy
      redirect_to post_path(@post), notice: 'Like removed!'
    else
      redirect_to post_path(@post), alert: 'Unable to remove like.'
    end
  end
end