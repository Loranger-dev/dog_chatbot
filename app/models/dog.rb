class Dog < ApplicationRecord
  belongs_to :user

  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :breed, presence: true
  validates :personality, presence: true
  validates :gender, presence: true
end
