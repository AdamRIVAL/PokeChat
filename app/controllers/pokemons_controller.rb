class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all.order(:number)
    @chats = current_user.chats
    if params[:query].present?
    @pokemons = @pokemons.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    # Add the amazing Julien's code for create a new message
    @message = Message.new
    @chat = Chat.find_by(user: current_user, pokemon: @pokemon)
    if @chat.nil?
      @chat = Chat.create(user: current_user, pokemon: @pokemon, title: Chat::DEFAULT_TITLE)
    end
  end
end
