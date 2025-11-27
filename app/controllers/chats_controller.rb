class ChatsController < ApplicationController
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer, status: :see_other
  end

  def destroy_all
    current_user.chats.destroy_all
    redirect_to pokemons_path, status: :see_other
  end
end
