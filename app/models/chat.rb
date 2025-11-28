class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon
  has_many :messages, dependent: :destroy

  DEFAULT_TITLE = "Untitled"
  TITLE_PROMPT = <<~PROMPT
  Génères un titre bref et descriptif de 3 à 6 mots qui résume le message du pokemon  pour une conversation par messages.
  PROMPT

  def generate_title_from_first_message
    return unless title == DEFAULT_TITLE
    first_pokemon_message = messages.where(role: "assistant").order(:created_at).first
    return if first_pokemon_message.content.blank?
    response = RubyLLM.chat(model: "gpt-4.1").with_instructions(TITLE_PROMPT).ask(first_pokemon_message.content)
    update(title: response.content)
  end
end
