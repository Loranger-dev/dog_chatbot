class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :dog

  has_many :messages, dependent: :destroy

  def display_title
    return "#{dog.name} : Nouvelle conversation" if title.blank?
    return "#{dog.name} : Nouvelle conversation" if title.match?(%r{\A/chats/\d+\z})
    "#{dog.name} : #{title}"
  end
end
