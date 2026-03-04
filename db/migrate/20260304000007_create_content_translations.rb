class CreateContentTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :content_translations do |t|
      t.string :locale, null: false, limit: 5
      t.string :category, null: false, limit: 20
      t.string :key, null: false, limit: 100
      t.string :value, null: false, limit: 200

      t.timestamps
    end

    add_index :content_translations, [:locale, :category, :key], unique: true, name: "idx_translations_locale_cat_key"
    add_index :content_translations, [:locale, :category], name: "idx_translations_locale_cat"
    add_index :content_translations, [:category, :key], name: "idx_translations_cat_key"
  end
end
