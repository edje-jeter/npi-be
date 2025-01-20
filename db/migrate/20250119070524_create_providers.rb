class CreateProviders < ActiveRecord::Migration[8.0]
  def change
    create_table :providers do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :country_code
      t.string :country_name
      t.string :credential
      t.string :name_first
      t.string :name_last
      t.string :name_middle
      t.string :name_organization
      t.string :npi
      t.string :nppes_last_updated
      t.string :nppes_type
      t.string :postal_code
      t.string :primary_taxonomy
      t.string :state

      t.timestamps
    end
  end
end
