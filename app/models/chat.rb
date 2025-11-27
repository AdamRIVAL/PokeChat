class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon
  has_many :messages, dependent: :destroy

  DEFAULT_TITLE = "Untitled"
  TITLE_PROMPT = <<~PROMPT
  Generate a short, descriptive, 3-to-6-word title that summarizes the user question for a chat conversation.
  PROMPT

  def generate_title_from_first_message
    return unless title == DEFAULT_TITLE
    first_pokemon_message = messages.where(role: "assistant").order(:created_at).first
    return if first_pokemon_message.nil?
    response = RubyLLM.chat(model: "gpt-4.1").with_instructions(TITLE_PROMPT).ask(first_pokemon_message.content)
    update(title: response.content)
  end
end
