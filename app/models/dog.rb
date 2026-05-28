class Dog < ApplicationRecord
  belongs_to :user

  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :breed, presence: true
end
