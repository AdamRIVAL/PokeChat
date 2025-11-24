class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.integer :number
      t.string :name
      t.string :description
      t.string :sprite
      t.string :types
      t.string :sound
      t.string :color

      t.timestamps
    end
  end
end
