class Pokemon < ApplicationRecord
  has_many :chats, dependent: :destroy
  validates :number, :name, :description, :sound, :sprite, :types, :color, presence: true
end
