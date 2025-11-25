class PokemonsController < ApplicationController
  def index

  end

  def show
    @pokemon = Pokemon.find(params[:id])
    # Add the amazing Julien's code for create a new message

  end
end
