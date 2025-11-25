class Pokemon < ApplicationRecord
  has_many :chats
  validates :number, :name, :description, :sound, :sprite, :types, :color, presence: true
end
