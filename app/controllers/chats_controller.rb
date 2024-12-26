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
    receiver = User.find(params[:chat][:user_id]) # Find the user to chat with
  
    # Ensure there's only one chat between the two users
    existing_chat = Chat.find_by(
      sender_id: current_user.id, receiver_id: receiver.id
    ) || Chat.find_by(
      sender_id: receiver.id, receiver_id: current_user.id
    )
  
    if existing_chat
      flash[:alert] = "You already have an active chat with this user."
      redirect_to chat_path(existing_chat) and return
    end
  
    # Create a new chat
    @chat = Chat.new(sender: current_user, receiver: receiver)
  
    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirect_to chats_path, alert: "Unable to start chat."
    end
  end
  

  private

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end
