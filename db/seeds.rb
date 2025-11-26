require "json"
require "rest-client"


# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning database"
Pokemon.destroy_all

puts "creating 151 pokemons..."
for i in 1..151 do
  response = RestClient.get "https://pokeapi.co/api/v2/pokemon/#{i}"
  pokemon = JSON.parse(response)
  response_species = RestClient.get "https://pokeapi.co/api/v2/pokemon-species/#{i}"
  pokemon_species = JSON.parse(response_species)
  # types = pokemon["types"].map do |type|
  #   type["type"]["name"]
  # end
  types = pokemon["types"].map do |type|
    url = type["type"]["url"]
    response_types = RestClient.get url
    parse_types = JSON.parse(response_types)
    parse_types["sprites"]["generation-viii"]["sword-shield"]["name_icon"]
  end
  Pokemon.create!(number: pokemon["id"], name: pokemon["species"]["name"], description: pokemon_species["flavor_text_entries"][0]["flavor_text"], sound: pokemon["cries"]["latest"], sprite: pokemon["sprites"]["front_default"], types:, color:  pokemon_species["color"]["name"] )
  # puts "created #{pokemon["species"]["name"]}"
end

puts "finished creating #{Pokemon.all.length} pokemons!"
