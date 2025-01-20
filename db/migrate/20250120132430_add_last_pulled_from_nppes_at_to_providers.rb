class AddLastPulledFromNppesAtToProviders < ActiveRecord::Migration[8.0]
  def change
    add_column :providers, :last_pulled_from_nppes_at, :datetime, null: false
  end
end
