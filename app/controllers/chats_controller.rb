class ChatsController < ApplicationController
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer, status: :see_other
  end
end
