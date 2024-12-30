class CommentNotifier < ApplicationNotifier
  deliver_by :database

  def message(_recipient)
    "#{params[:comment].user.username} commented on your post"
  end
end
