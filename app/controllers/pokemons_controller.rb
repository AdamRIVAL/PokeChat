class PokemonsController < ApplicationController
  def index

  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @message = Message.new
    @chat = Chat.find_by(user: current_user, pokemon: @pokemon)
    if @chat.nil?
      @chat = Chat.create(user: current_user, pokemon: @pokemon)
    end
  end
end
