class CreateDailyPuzzles < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_puzzles do |t|
      t.date :puzzle_date, null: false
      t.references :dish, null: false, foreign_key: true, index: true
      t.integer :puzzle_number, null: false
      t.timestamps
    end

    add_index :daily_puzzles, :puzzle_date, unique: true
    add_index :daily_puzzles, :puzzle_number, unique: true
  end
end
