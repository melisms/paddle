class LikeNotifier < ApplicationNotifier
  deliver_by :database, target: -> { params[:like].post.user }

  def message(_recipient)
    "#{params[:username]} liked your post"
  end
end
