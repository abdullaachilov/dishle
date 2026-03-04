class AddTotalPointsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :total_points, :integer, null: false, default: 0
    add_index :users, :total_points
  end
end
