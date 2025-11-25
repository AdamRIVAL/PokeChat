class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all.order(:number)
    @chats = Chat.all
  end

  def show

  end
end
