class AddIntroToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :intro, :string
  end
end
