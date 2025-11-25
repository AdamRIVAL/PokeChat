class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home

    # pour voir un pokémon test :
    @pokemon = Pokemon.find_by(number: 14)
    # FIN TEST

  end
end
