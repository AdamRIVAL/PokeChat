class ChatsController < ApplicationController
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to pokemons_path, status: :see_other
  end
end
