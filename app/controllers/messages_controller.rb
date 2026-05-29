class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])

    @user_message = @chat.messages.build(
      role: "user",
      content: message_params[:content]
    )

    if @user_message.save
      ruby_llm_chat = RubyLLM.chat

      @chat.messages
           .where.not(id: @user_message.id)
           .order(created_at: :asc)
           .each do |message|
        ruby_llm_chat.add_message(
          role: message.role,
          content: message.content
        )
      end

      response = ruby_llm_chat.with_instructions(system_prompt).ask(@user_message.content)

      @chat.messages.create!(
        role: "assistant",
        content: response.content
      )

      generate_chat_title if @chat.title.blank?

      redirect_to chat_path(@chat)
    else
      @messages = @chat.messages.order(created_at: :asc)
      @message = @user_message
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def system_prompt # rubocop:disable Metrics/MethodLength
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
    2. Ajoute des sous-points indentés avec des tirets.
    3. Sépare chaque section par un paragraphe clair.
    4. Utilise une indentation propre.
    5. Limite la réponse à 3 niveaux maximum.
    6. Présente les conseils sous forme de liste lisible et aérée.
    7. Ne jamais écrire un bloc de texte compact."
  end

  def generate_chat_title # rubocop:disable Metrics/MethodLength
    title_response = RubyLLM.chat.with_instructions(
      "Tu génères un titre court pour une conversation entre un propriétaire et un coach canin.

      Règles :
      - 3 à 6 mots maximum
      - pas de guillemets
      - pas de point final
      - ne mets pas le nom du chien
      - réponds uniquement avec le titre"
    ).ask(@user_message.content)

    clean_title = title_response.content.to_s.strip.gsub(/\A["']|["']\z/, "")

    @chat.update(title: clean_title.truncate(60))
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
