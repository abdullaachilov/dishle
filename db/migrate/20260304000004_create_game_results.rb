class CreateGameResults < ActiveRecord::Migration[8.1]
  def change
    create_table :game_results do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :daily_puzzle, null: false, foreign_key: true, index: true
      t.boolean :solved, null: false
      t.integer :guesses_count, null: false
      t.datetime :completed_at, null: false
      t.timestamps
    end

    add_index :game_results, [:user_id, :daily_puzzle_id], unique: true
  end
end
