class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @chat = Chat.find(params[:chat_id])
    @pokemon = @chat.pokemon
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      response = RubyLLM.chat.ask("Génère la réponse via ce texte: #{@message.content}").content
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
