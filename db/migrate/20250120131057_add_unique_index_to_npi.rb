class AddUniqueIndexToNpi < ActiveRecord::Migration[8.0]
  def change
    add_index :providers, :npi, unique: true
  end
end
