class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.citext :nickname, null: false
      t.string :password_digest, null: false
      t.string :session_token, limit: 64
      t.integer :games_played, null: false, default: 0
      t.integer :games_won, null: false, default: 0
      t.integer :current_streak, null: false, default: 0
      t.integer :max_streak, null: false, default: 0
      t.timestamps
    end

    add_index :users, :nickname, unique: true
    add_index :users, :session_token, unique: true
  end
end
