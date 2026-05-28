class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])

    user_message = Message.create!(
      chat: @chat,
      role: "user",
      content: message_params[:content]
    )

    ai_response = generate_ai_response(
      user_message.content,
      @chat.dog
    )

    Message.create!(
      chat: @chat,
      role: "assistant",
      content: ai_response
    )

    redirect_to chat_path(@chat)
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def generate_ai_response(content, dog)
    "Réponse pour #{dog.name} : #{content}"
  end
end
