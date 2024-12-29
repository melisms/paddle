class CommentNotification < Noticed::Base
  deliver_by :database

  param :comment

  def message
    "#{params[:comment].user.username} commented on your post: '#{params[:comment].body}'."
  end

  def url
    Rails.application.routes.url_helpers.post_path(params[:comment].post)
  end
end
