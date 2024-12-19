class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = current_user.sent_messages.new(message_params)
    if @message.save
      redirect_to conversations_path, notice: "Message sent successfully."
    else
      render :new
    end
  end

  def index
    @received_messages = current_user.received_messages.unread
    @sent_messages = current_user.sent_messages
  end

  def show
    @message = Message.find(params[:id])
    @message.update(read: true)
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :content)
  end
end
