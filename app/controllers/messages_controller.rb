class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @pokemon = @chat.pokemon

    params_prompt = <<-PROMPT
      You are the pokemon #{@pokemon.name}

      Base your personality on this description: #{@pokemon.description}

      I am a Pokemon Trainer communicating with you through my pokedex

      Your answer is divided in two parts

      The first part of your answer is your name repeated multiple times as you are talking like a pokemon

      The second part always start with "**#{@pokemon.name.capitalize} is saying to you :**" and skip a line

      Then follows your actual response but without saying your name, dont forget you are an animal

    PROMPT

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      response = RubyLLM.chat.ask("#{params_prompt} #{@message.content}").content
      Message.create(role: "assistant", content: response, chat: @chat)
      redirect_to pokemon_path(@pokemon)
    else
      render "pokemons/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
