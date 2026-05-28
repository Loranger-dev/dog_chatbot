class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])

    user_message = Message.create(
      chat: @chat,
      role: "user",
      content: message_params[:content]
    )

    ai_response = generate_ai_response(
      user_message.content,
      @chat.dog
    )

    Message.create(
      chat: @chat,
      role: "assistant",
      content: ai_response
    )

    redirect_to chat_path(@chat)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def generate_ai_response(content, dog)
    response = RubyLLM.chat.ask(
      "Tu es un expert canin.
    Le chien s'appelle #{dog.name}.
    Message du propriétaire : #{content}"
    )

    response.content
  end
end
