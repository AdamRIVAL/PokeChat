class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all.order(:number)
  end

  def show

  end


