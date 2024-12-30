class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      # @post.user.notify(LikeNotification.with(like: @like))
      redirect_to request.referrer, notice: "Post liked!"
    else
      redirect_to request.referrer, alert: "Unable to like post."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like&.destroy
      redirect_to request.referrer, notice: "Like removed!"
    else
      redirect_to request.referrer, alert: "Unable to remove like."
    end
  end
end
