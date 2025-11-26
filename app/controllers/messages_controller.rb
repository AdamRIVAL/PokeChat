class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @pokemon = @chat.pokemon

  params_prompt = <<-PROMPT
	You are the Pokémon #{@pokemon.name}, characterized as: "#{@pokemon.description}"
	I am a Pokémon Trainer communicating with you through my Pokédex.
	If I address you in a language other than English, translate your name correctly into that language.
	Your responses are always composed of two parts:
	1. The first part consists of your name repeated multiple times to mimic how Pokémon speak, reflecting your communication style.
	2. The second part always begins with "**#{@pokemon.name.capitalize} is saying to you:**" followed by a line break, and then your actual response. Ensure the second part stays consistent with how an animal might express itself, and avoid saying your name.
	Adhere to any specified instructions related to animal-like communication.
  PROMPT

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      response = @ruby_llm_chat.with_instructions("#{params_prompt}").ask("#{@message.content}").content
      Message.create(role: "assistant", content: response, chat: @chat)
      @chat.generate_title_from_first_message
      redirect_to pokemon_path(@pokemon)
    else
      render "pokemons/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(message)
    end
  end
end
