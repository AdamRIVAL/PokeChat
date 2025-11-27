class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @pokemons = Pokemon.all
    if params[:query].present?
      @pokemons = @pokemons.where("name ILIKE ?", "%#{params[:query]}%")
    elsif
      @pokemons = Pokemon.order(:number).sample(12)
    end
  end
end
