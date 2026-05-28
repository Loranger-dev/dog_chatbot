class ChatsController < ApplicationController
  def index
    @chats = current_user.chats
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
    @message = Message.new
  end

  def create
    @dog = current_user.dogs.find(params[:dog_id])

    @chat = Chat.new(
      title: "Conversation avec #{@dog.name}"
    )

    @chat.user = current_user
    @chat.dog = @dog

    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirect_to dog_path(@dog),
                  alert: "Impossible de créer la conversation."
    end
  end
end
