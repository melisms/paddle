class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
    @message = Message.new
  end

  def create
    receiver = User.find(params[:chat][:user_id] || params[:chat][:receiver_id])

    existing_chat = Chat.find_by(
      sender_id: current_user.id, receiver_id: receiver.id
    ) || Chat.find_by(
      sender_id: receiver.id, receiver_id: current_user.id
    )

    if existing_chat
      flash[:alert] = "You already have an active chat with this user."
      redirect_to chat_path(existing_chat) and return
    end

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
