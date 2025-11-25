class UpdateTypes < ActiveRecord::Migration[7.1]
  def change
    remove_column :pokemons, :types
    add_column :pokemons, :types, :string, array: true
  end
end
