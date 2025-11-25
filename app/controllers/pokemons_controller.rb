class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all.order(:number)
    @chats = Chat.all
    if params[:query].present?
    @pokemons = @pokemons.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    # Add the amazing Julien's code for create a new message
  end
end
