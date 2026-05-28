class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])

    @user_message = @chat.messages.build(
      role: "user",
      content: message_params[:content]
    )

    if @user_message.save
      ruby_llm_chat = RubyLLM.chat

      @chat.messages.order(created_at: :asc).each do |message|
        ruby_llm_chat.add_message(
          role: message.role,
          content: message.content
        )
      end

      response = ruby_llm_chat.with_instructions(
        "Tu es un coach canin professionnel, bienveillant et pédagogique.

        Ton rôle :
        - aider le propriétaire à mieux comprendre son chien
        - donner des conseils pratiques, simples et applicables
        - adapter tes réponses au profil réel du chien
        - privilégier l'éducation positive
        - ne jamais donner de diagnostic médical certain

        Profil du chien :
        - Nom : #{@chat.dog.name}
        - Race : #{@chat.dog.breed}
        - Âge : #{@chat.dog.age}

        Règles de réponse :
        - tiens compte de la race du chien, de son âge et de son historique
        - réponds de façon claire, naturelle et rassurante
        - donne 2 à 4 conseils concrets maximum
        - si la situation semble médicale, urgente ou dangereuse, conseille de contacter un vétérinaire ou un éducateur canin
        - pose une question de suivi si une information importante manque

        Format de réponse obligatoire :
        1. Structure la réponse en sections numérotées (1, 2, 3…).
        2. Ajoute des sous‑points indentés avec des tirets.
        3. Sépare chaque section par un paragraphe clair.
        4. Utilise une indentation propre :
              - un niveau pour les sections
              - un niveau pour les sous‑points
        5. Limite la réponse à 3 niveaux maximum.
        6. Présente les conseils sous forme de liste lisible et aérée.
        7. Ne jamais écrire un bloc de texte compact : toujours structurer.
        "
      ).ask(@user_message.content)

      @chat.messages.create!(
        role: "assistant",
        content: response.content
      )

      redirect_to chat_path(@chat)
    else
      # Corrections ici : orthographe de @messages et de :created_at
      @messages = @chat.messages.order(created_at: :asc)
      @message = @user_message
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
