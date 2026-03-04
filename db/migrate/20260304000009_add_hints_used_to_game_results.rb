class AddHintsUsedToGameResults < ActiveRecord::Migration[8.1]
  def change
    add_column :game_results, :hints_used, :integer, null: false, default: 0
  end
end
