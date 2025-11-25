class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home

    # pour voir mon pokémon test :
    @pokemon = Pokemon.find_by(number: 32)
    # FIN TEST

  end
end
