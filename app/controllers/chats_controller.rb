class ChatsController < ApplicationController
  before_action :authenticate_user!

  # Show all chats for the current user (sent and received)
  def index
    # Get all chats where the current user is either the sender or the receiver
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  # Show a specific chat
  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
    @message = Message.new
  end

  # Create a new chat with the current user as the sender and another user as the receiver
  def create
    @chat = Chat.new(chat_params)
    @chat.sender = current_user

    if Chat.exists?(sender_id: current_user.id, receiver_id: @chat.receiver_id) ||
      Chat.exists?(sender_id: @chat.receiver_id, receiver_id: current_user.id)
     flash[:alert] = "You already have an active chat with this user."
     redirect_to chats_path and return
    end

    if @chat.save
      redirect_to chat_path(@chat)
    else
      # If the chat creation fails, redirect to the chats index
      redirect_to chats_path, alert: "Unable to start chat."
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end
