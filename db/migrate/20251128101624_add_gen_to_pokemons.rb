class AddGenToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :gen, :string
  end
end
