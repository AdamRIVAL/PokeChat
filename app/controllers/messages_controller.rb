class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    response = RubyLLM.chat.ask("Génère la réponse via ce texte: #{@message.text}").content
    @message.save

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
