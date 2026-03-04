class CreateFeedbacks < ActiveRecord::Migration[8.1]
  def change
    create_table :feedbacks do |t|
      t.text :body, null: false
      t.string :ip_address, null: false, limit: 45
      t.string :session_id, limit: 64
      t.references :user, null: true, foreign_key: true, index: true
      t.timestamps
    end

    add_index :feedbacks, [:ip_address, :created_at]
    add_index :feedbacks, [:session_id, :created_at]
  end
end
