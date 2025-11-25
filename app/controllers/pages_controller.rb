class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home

    # pour voir mon pokémon test :
    @pokemon = Pokemon.first
    # FIN TEST
    
  end
end
