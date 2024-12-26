class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  # Create a new message in the current chat
  def create
    @message = @chat.messages.new(message_params)
    @message.sender = current_user
    @message.receiver = (@message.sender == @chat.sender ? @chat.receiver : @chat.sender)

    if @message.save
      redirect_to chat_path(@chat)
    else
      render "chats/show"
    end
  end

  # Display all messages in the current chat
  def index
    @messages = @chat.messages.order(created_at: :asc)
  end

  # Show a single message in the chat (optional depending on your use case)
  def show
    @message = @chat.messages.find(params[:id])
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :image)
  end
end
