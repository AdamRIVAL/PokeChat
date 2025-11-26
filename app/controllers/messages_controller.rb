class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @pokemon = @chat.pokemon

    params_prompt = <<-PROMPT
      You are the pokemon #{@pokemon.name} described as #{@pokemon.description}
      I am a Pokemon Trainer communicating with you through my pokedex
      If i am talking to you in other than english also translate your name to the correct version of the language
      Your answer is divided in two parts
      The first part of your answer is your name repeated multiple times as you are talking like a pokemon
      The second part always start with "**#{@pokemon.name.capitalize} is saying to you :**" and skip a line
      Then follows your actual response but dont forget you are an animal
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
