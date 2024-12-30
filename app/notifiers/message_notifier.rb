class MessageNotification < ApplicationNotifier
  deliver_by :database

  def message(_recipient)
    "#{params[:message].sender.username} sent you a message"
  end
end
