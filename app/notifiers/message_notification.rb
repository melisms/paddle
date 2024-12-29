class MessageNotification < Noticed::Base
  deliver_by :database

  param :message

  def message
    "#{params[:message].sender.username} sent you a message."
  end

  def url
    Rails.application.routes.url_helpers.chat_path(params[:message].chat)
  end
end
