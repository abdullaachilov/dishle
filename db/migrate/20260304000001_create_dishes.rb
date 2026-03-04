class CreateDishes < ActiveRecord::Migration[8.1]
  def change
    enable_extension "citext"

    create_table :dishes do |t|
      t.citext :name, null: false
      t.string :slug, null: false, limit: 100
      t.string :cuisine, null: false, limit: 50
      t.string :base, null: false, limit: 50
      t.string :protein, null: false, limit: 50
      t.string :star, null: false, limit: 50
      t.string :fat, null: false, limit: 50
      t.string :heat, null: false, limit: 50
      t.text :description
      t.string :image_url, limit: 500
      t.string :difficulty, null: false, default: "medium", limit: 10
      t.boolean :used_as_daily, null: false, default: false
      t.timestamps
    end

    add_index :dishes, :slug, unique: true
    add_index :dishes, :name, unique: true
    add_index :dishes, :used_as_daily
    add_index :dishes, :difficulty
  end
end
