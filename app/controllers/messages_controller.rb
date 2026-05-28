def create
  @chat = current_user.chats.find(params[:chat_id])

  @message = @chat.messages.build(
    content: params[:message][:content],
    role: "user"
  )

  if @message.save
    ruby_llm_chat = RubyLLM.chat

    @chat.messages.each do |message|
      ruby_llm_chat.add_message(
        role: message.role,
        content: message.content
      )
    end

    response = ruby_llm_chat.with_instructions(
      "Tu es un expert canin. Le chien s'appelle #{@chat.dog.name}"
    ).ask(@message.content)

    @chat.messages.create!(
      role: "assistant",
      content: response.content
    )

    redirect_to chat_path(@chat)
  else
    render "chats/show", status: :unprocessable_entity
  end
end
