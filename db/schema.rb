# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_04_000009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"

  create_table "content_translations", force: :cascade do |t|
    t.string "category", limit: 20, null: false
    t.datetime "created_at", null: false
    t.string "key", limit: 100, null: false
    t.string "locale", limit: 5, null: false
    t.datetime "updated_at", null: false
    t.string "value", limit: 200, null: false
    t.index ["category", "key"], name: "idx_translations_cat_key"
    t.index ["locale", "category", "key"], name: "idx_translations_locale_cat_key", unique: true
    t.index ["locale", "category"], name: "idx_translations_locale_cat"
  end

  create_table "daily_puzzles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "dish_id", null: false
    t.date "puzzle_date", null: false
    t.integer "puzzle_number", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_daily_puzzles_on_dish_id"
    t.index ["puzzle_date"], name: "index_daily_puzzles_on_puzzle_date", unique: true
    t.index ["puzzle_number"], name: "index_daily_puzzles_on_puzzle_number", unique: true
  end

  create_table "dishes", force: :cascade do |t|
    t.string "base", limit: 50, null: false
    t.datetime "created_at", null: false
    t.string "cuisine", limit: 50, null: false
    t.text "description"
    t.string "difficulty", limit: 10, default: "medium", null: false
    t.string "fat", limit: 50, null: false
    t.text "fun_fact"
    t.string "heat", limit: 50, null: false
    t.string "image_url", limit: 500
    t.citext "name", null: false
    t.string "protein", limit: 50, null: false
    t.string "slug", limit: 100, null: false
    t.string "star", limit: 50, null: false
    t.datetime "updated_at", null: false
    t.boolean "used_as_daily", default: false, null: false
    t.index ["difficulty"], name: "index_dishes_on_difficulty"
    t.index ["name"], name: "index_dishes_on_name", unique: true
    t.index ["slug"], name: "index_dishes_on_slug", unique: true
    t.index ["used_as_daily"], name: "index_dishes_on_used_as_daily"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.string "ip_address", limit: 45, null: false
    t.string "session_id", limit: 64
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["ip_address", "created_at"], name: "index_feedbacks_on_ip_address_and_created_at"
    t.index ["session_id", "created_at"], name: "index_feedbacks_on_session_id_and_created_at"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "game_results", force: :cascade do |t|
    t.datetime "completed_at", null: false
    t.datetime "created_at", null: false
    t.bigint "daily_puzzle_id", null: false
    t.integer "guesses_count", null: false
    t.integer "hints_used", default: 0, null: false
    t.boolean "solved", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["daily_puzzle_id"], name: "index_game_results_on_daily_puzzle_id"
    t.index ["user_id", "daily_puzzle_id"], name: "index_game_results_on_user_id_and_daily_puzzle_id", unique: true
    t.index ["user_id"], name: "index_game_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_streak", default: 0, null: false
    t.integer "games_played", default: 0, null: false
    t.integer "games_won", default: 0, null: false
    t.integer "max_streak", default: 0, null: false
    t.citext "nickname", null: false
    t.string "password_digest", null: false
    t.string "session_token", limit: 64
    t.integer "total_points", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
    t.index ["total_points"], name: "index_users_on_total_points"
  end

  add_foreign_key "daily_puzzles", "dishes"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "game_results", "daily_puzzles"
  add_foreign_key "game_results", "users"
end
